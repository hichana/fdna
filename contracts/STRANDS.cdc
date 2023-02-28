import NonFungibleToken from "./core/NonFungibleToken.cdc"
import FungibleToken from "./core/FungibleToken.cdc"
import FlowToken from "./core/FlowToken.cdc"
import MetadataViews from "./core/MetadataViews.cdc"

pub contract STRANDS: NonFungibleToken {

    pub var totalSupply: UInt64
    access(account) var paymentRecipient: Address
    access(account) var royaltyReceivers: [MetadataViews.Royalty]
    access(account) var mintPrice: UFix64
    access(account) var mintingIsPaused: Bool
    
    // key is the DNA strand, value is the timestamp it was claimed
    access(contract) let strands: {String: UFix64}

    pub event ContractInitialized()

    pub event Withdraw(id: UInt64, from: Address?)
    pub event Deposit(id: UInt64, to: Address?)
    pub event MintPriceChanged(newMintPrice: UFix64)
    pub event PaymentRecipientChanged(newPaymentRecipient: Address)
    pub event RoyaltyReceiversChanged(newRoyaltyReceivers: [Address])
    pub event MintingPaused()
    pub event MintingResumed()

    pub let CollectionStoragePath: StoragePath
    pub let CollectionPublicPath: PublicPath
    pub let AdminStoragePath: StoragePath

    pub resource NFT: NonFungibleToken.INFT, MetadataViews.Resolver {
        
        pub let id: UInt64

        pub let name: String
        pub let description: String
        pub let thumbnail: String
        pub let thumbnailPath: String
        access(self) let royalties: [MetadataViews.Royalty]
        access(self) let metadata: {String: AnyStruct}

        pub let strandA: String
        pub let strandB: String
        pub let strandAIdentifiers: String
        pub let strandBIdentifiers: String

        access(self) let basePairs: [[String]]
    
        init(
            id: UInt64,
            name: String,
            description: String,
            thumbnail: String,
            thumbnailPath: String,
            royalties: [MetadataViews.Royalty],
            metadata: {String: AnyStruct},
            strandA: String,
            strandB: String,
            strandAIdentifiers: String,
            strandBIdentifiers: String,
            basePairs: [[String]]
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.thumbnail = thumbnail
            self.thumbnailPath = thumbnailPath
            self.royalties = royalties
            self.metadata = metadata
            self.strandA = strandA
            self.strandB = strandB
            self.strandAIdentifiers = strandAIdentifiers
            self.strandBIdentifiers = strandBIdentifiers
            self.basePairs = basePairs
        }

        /// @return An array of Types defining the implemented views. 
        ///
        pub fun getViews(): [Type] {
            return [
                Type<MetadataViews.Display>(),
                Type<MetadataViews.Royalties>(),
                Type<MetadataViews.Editions>(),
                Type<MetadataViews.ExternalURL>(),
                Type<MetadataViews.NFTCollectionData>(),
                Type<MetadataViews.NFTCollectionDisplay>(),
                Type<MetadataViews.Serial>(),
                Type<MetadataViews.Traits>()
            ]
        }

        /// @param view: The Type of the desired view.
        /// @return A structure representing the requested view.
        ///
        pub fun resolveView(_ view: Type): AnyStruct? {
            switch view {
                case Type<MetadataViews.Display>():
                    return MetadataViews.Display(
                        name: self.name,
                        description: self.description,
                        thumbnail: MetadataViews.IPFSFile(
                            cid: self.thumbnail,
                            path: self.thumbnailPath
                        )
                    )
                case Type<MetadataViews.Editions>():
                    // There is no max number of NFTs that can be minted from this contract
                    // so the max edition field value is set to nil
                    let editionInfo = MetadataViews.Edition(name: "STRANDS NFT Edition", number: self.id, max: nil)
                    let editionList: [MetadataViews.Edition] = [editionInfo]
                    return MetadataViews.Editions(
                        editionList
                    )
                case Type<MetadataViews.Serial>():
                    return MetadataViews.Serial(
                        self.id
                    )
                case Type<MetadataViews.Royalties>():
                    return MetadataViews.Royalties(
                        self.royalties
                    )
                case Type<MetadataViews.ExternalURL>():
                    return MetadataViews.ExternalURL("https://strands.id/".concat(self.id.toString()))
                case Type<MetadataViews.NFTCollectionData>():
                    return MetadataViews.NFTCollectionData(
                        storagePath: STRANDS.CollectionStoragePath,
                        publicPath: STRANDS.CollectionPublicPath,
                        providerPath: /private/strandsCollection,
                        publicCollection: Type<&STRANDS.Collection{STRANDS.STRANDSCollectionPublic}>(),
                        publicLinkedType: Type<&STRANDS.Collection{STRANDS.STRANDSCollectionPublic,NonFungibleToken.CollectionPublic,NonFungibleToken.Receiver,MetadataViews.ResolverCollection}>(),
                        providerLinkedType: Type<&STRANDS.Collection{STRANDS.STRANDSCollectionPublic,NonFungibleToken.CollectionPublic,NonFungibleToken.Provider,MetadataViews.ResolverCollection}>(),
                        createEmptyCollectionFunction: (fun (): @NonFungibleToken.Collection {
                            return <-STRANDS.createEmptyCollection()
                        })
                    )
                case Type<MetadataViews.NFTCollectionDisplay>():
                    let media = MetadataViews.Media(
                        file: MetadataViews.IPFSFile(
                            cid: "bafybeibcy3vbnonzmwiy4vsmkx7qgb3wv2g23ese3ldgjeaudfmfmctmzi",
                            path: "STRANDS_banner.png"
                        ),
                        mediaType: "image/png"
                    )
                    return MetadataViews.NFTCollectionDisplay(
                        name: "The STRAND Collection -- digital DNA on Flow",
                        description: "With STRANDS, the NFT assets in your wallet allow you to create one-of-a-kind, never duplicated, digital DNA to use across future experiences on Flow.",
                        externalURL: MetadataViews.ExternalURL("https://strands.id"),
                        squareImage: media,
                        bannerImage: media,
                        socials: {
                            "twitter": MetadataViews.ExternalURL("https://twitter.com/strandOnFlow")
                        }
                    )
                case Type<MetadataViews.Traits>():
                    // exclude mintedTime to mark it as "Date" type and still use 'dictToTraits'
                    let excludedTraits = ["mintedTime"]
                    let traitsView = MetadataViews.dictToTraits(dict: self.metadata, excludedNames: excludedTraits)

                    // add back mintedTime, which is a unix timestamp. Mark it with a displayType so platforms know how to show it.
                    let mintedTimeTrait = MetadataViews.Trait(name: "mintedTime", value: self.metadata["mintedTime"]!, displayType: "Date", rarity: nil)
                    traitsView.addTrait(mintedTimeTrait)
                    
                    return traitsView

            }
            return nil
        }
    }

    pub resource interface STRANDSCollectionPublic {
        pub fun deposit(token: @NonFungibleToken.NFT)
        pub fun getIDs(): [UInt64]
        pub fun borrowNFT(id: UInt64): &NonFungibleToken.NFT
        pub fun borrowStrandsNFT(id: UInt64): &STRANDS.NFT? {
            post {
                (result == nil) || (result?.id == id):
                    "Cannot borrow STRANDS reference: the ID of the returned reference is incorrect"
            }
        }
    }

    pub resource Collection: STRANDSCollectionPublic, NonFungibleToken.Provider, NonFungibleToken.Receiver, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection {
        pub var ownedNFTs: @{UInt64: NonFungibleToken.NFT}

        init () {
            self.ownedNFTs <- {}
        }

        /// Removes an NFT from the collection and moves it to the caller
        ///
        /// @param withdrawID: The ID of the NFT that wants to be withdrawn
        /// @return The NFT resource that has been taken out of the collection
        ///
        pub fun withdraw(withdrawID: UInt64): @NonFungibleToken.NFT {
            let token <- self.ownedNFTs.remove(key: withdrawID) ?? panic("missing NFT")

            emit Withdraw(id: token.id, from: self.owner?.address)

            return <-token
        }

        /// Adds an NFT to the collections dictionary and adds the ID to the id array
        ///
        /// @param token: The NFT resource to be included in the collection
        /// 
        pub fun deposit(token: @NonFungibleToken.NFT) {
            let token <- token as! @STRANDS.NFT

            let id: UInt64 = token.id

            // add the new token to the dictionary which removes the old one
            let oldToken <- self.ownedNFTs[id] <- token

            emit Deposit(id: id, to: self.owner?.address)

            destroy oldToken
        }

        /// Helper method for getting the collection IDs
        ///
        /// @return An array containing the IDs of the NFTs in the collection
        ///
        pub fun getIDs(): [UInt64] {
            return self.ownedNFTs.keys
        }

        /// Gets a reference to an NFT in the collection so that 
        /// the caller can read its metadata and call its methods
        ///
        /// @param id: The ID of the wanted NFT
        /// @return A reference to the wanted NFT resource
        ///
        pub fun borrowNFT(id: UInt64): &NonFungibleToken.NFT {
            return (&self.ownedNFTs[id] as &NonFungibleToken.NFT?)!
        }
 
        /// Gets a reference to an NFT in the collection so that 
        /// the caller can read its metadata and call its methods
        ///
        /// @param id: The ID of the wanted NFT
        /// @return A reference to the wanted NFT resource
        ///        
        pub fun borrowStrandsNFT(id: UInt64): &STRANDS.NFT? {
            if self.ownedNFTs[id] != nil {
                // Create an authorized reference to allow downcasting
                let ref = (&self.ownedNFTs[id] as auth &NonFungibleToken.NFT?)!
                return ref as! &STRANDS.NFT
            }

            return nil
        }

        /// Gets a reference to the NFT only conforming to the `{MetadataViews.Resolver}`
        /// interface so that the caller can retrieve the views that the NFT
        /// is implementing and resolve them
        ///
        /// @param id: The ID of the wanted NFT
        /// @return The resource reference conforming to the Resolver interface
        /// 
        pub fun borrowViewResolver(id: UInt64): &AnyResource{MetadataViews.Resolver} {
            let nft = (&self.ownedNFTs[id] as auth &NonFungibleToken.NFT?)!
            let exampleNFT = nft as! &STRANDS.NFT
            return exampleNFT as &AnyResource{MetadataViews.Resolver}
        }

        destroy() {
            destroy self.ownedNFTs
        }
    }

    /// Allows anyone to create a new empty collection
    ///
    /// @return The new Collection resource
    ///
    pub fun createEmptyCollection(): @NonFungibleToken.Collection {
        return <- create Collection()
    }

    /// Mints a new NFT with a new ID and deposit it in the
    /// recipients collection using their collection reference
    ///
    /// @param recipient: A capability to the collection where the new NFT will be deposited
    ///     
    pub fun mintNFT(
        recipient: &{NonFungibleToken.CollectionPublic},
        strandARefs: [&NonFungibleToken.NFT],
        strandBRefs: [&NonFungibleToken.NFT],
        payment: @FungibleToken.Vault
    ) {
        pre {
            payment.balance >= STRANDS.mintPrice: "Payment must be at least the price of the NFT"
        }

        let metadata: {String: AnyStruct} = {}
        let currentBlock = getCurrentBlock()
        let currentTimestamp = currentBlock.timestamp
        let recipientCollectionOwnerAddress = recipient.owner!.address
        metadata["mintedBlock"] = currentBlock.height
        metadata["mintedTime"] = currentTimestamp
        metadata["minter"] = recipientCollectionOwnerAddress

        // construct DNA
        let dot = "."
        let dnaASegment = "_.--''``'--._"
        let dnaBSegment = "``'--.__.--''"
        // strandA
        var strandAIdentifiers = ""
        var strandA = ""
        var strandALoop = 0
        let strandALength = strandARefs.length
        let basePairs: [[String]] = []

        for strandABase in strandARefs {

            if strandABase.owner!.address != recipientCollectionOwnerAddress {
                panic("Base NFTs must be owned by the owner of the recipient collection")
            }

            strandALoop = strandALoop + 1

            // build strandA identifiers string
            let strandAID = strandABase.id
            let appendAID = dot.concat(strandAID.toString())
            let fullyQualifiedStrandAID = strandABase.getType().identifier.concat(appendAID)
            let constructedStrandA = strandAIdentifiers.concat(fullyQualifiedStrandAID)
            strandAIdentifiers = constructedStrandA

            if strandALoop < strandALength {
                strandAIdentifiers = strandAIdentifiers.concat(",")
            }

            // build strandA DNA
            strandA = strandA.concat(dnaASegment)

            // build base pairs
            basePairs.append([fullyQualifiedStrandAID])
        }

        // check if the constructed strand already exists in the strands registry
        if STRANDS.strands[strandAIdentifiers] != nil {
            panic("Strand A already exists in the registry")
        }

        // add this strand to the registry
        STRANDS.strands.insert(key: strandAIdentifiers, currentTimestamp)

        // add to metadata
        metadata["strandAIdentifiers"] = strandAIdentifiers
        metadata["strandA"] = strandA

        // strandB
        var strandBIdentifiers = ""
        var strandB = ""
        var strandBLoop = 0
        let strandBLength = strandBRefs.length

        for strandBBase in strandBRefs {

            if strandBBase.owner!.address != recipientCollectionOwnerAddress {
                panic("Base NFTs must be owned by the owner of the recipient collection")
            }

            strandBLoop = strandBLoop + 1

            // build strandB identifiers string
            let strandBID = strandBBase.id
            let appendBID = dot.concat(strandBID.toString())
            let fullyQualifiedStrandBID = strandBBase.getType().identifier.concat(appendBID)
            let constructedStrandB = strandBIdentifiers.concat(fullyQualifiedStrandBID)
            strandBIdentifiers = constructedStrandB

            if strandBLoop < strandBLength {
                strandBIdentifiers = strandBIdentifiers.concat(",")
            }

            // build strandB DNA
            strandB = strandB.concat(dnaBSegment)

            // build base pairs
            basePairs[strandBLoop -1].append(fullyQualifiedStrandBID)
        }

        // check if the constructed strand already exists in the strands registry
        if STRANDS.strands[strandBIdentifiers] != nil {
            panic("Strand B already exists in the registry")
        }
        // add this strand to the registry
        STRANDS.strands.insert(key: strandBIdentifiers, currentTimestamp)
        
        // add to metadata
        metadata["strandBIdentifiers"] = strandBIdentifiers
        metadata["strandB"] = strandB
        metadata["basePairs"] = basePairs

        // construct NFT name
        let nftNamePrefix = "STRANDS #"
        let nftNameID = STRANDS.totalSupply.toString()
        let nftName = nftNamePrefix.concat(nftNameID)

        // accept payment
        let paymentRecipientRef = getAccount(STRANDS.paymentRecipient).getCapability<&{FungibleToken.Receiver}>(/public/flowTokenReceiver).borrow()
            ?? panic("couldn't borrow Flow token receiver cap")

        paymentRecipientRef.deposit(from: <-payment)

        // create a new NFT
        var newNFT <- create NFT(
            id: STRANDS.totalSupply,
            name: nftName,
            description: "On-Chain DNA for Flow",
            thumbnail: "bafybeibqwjgwfxk4keropnob73t56vo4fy7yhlf6twdjizl4zgemjotxj4",
            thumbnailPath:"STRANDS_square.png",
            royalties: self.royaltyReceivers,
            metadata: metadata,
            strandA: strandA,
            strandB: strandB,
            strandAIdentifiers: strandAIdentifiers,
            strandBIdentifiers: strandBIdentifiers,
            basePairs: basePairs
        )

        // deposit it in the recipient's account using their reference
        recipient.deposit(token: <-newNFT)

        STRANDS.totalSupply = STRANDS.totalSupply + UInt64(1)
    }

    pub resource Admin{

        pub fun changeMintPrice(newMintPrice: UFix64) {
            STRANDS.mintPrice = newMintPrice
            emit MintPriceChanged(newMintPrice: newMintPrice)
        }

        pub fun changePaymentRecipient(newPaymentRecipient: Address) {

            // borrow the receiver cap and check it
            let flowTokenReceiverCap = getAccount(newPaymentRecipient).getCapability<&FlowToken.Vault{FungibleToken.Receiver}>(/public/flowTokenReceiver)
            assert(flowTokenReceiverCap.borrow() != nil, message: "Missing or mis-typed FlowToken receiver")

            STRANDS.paymentRecipient = newPaymentRecipient
            emit PaymentRecipientChanged(newPaymentRecipient: newPaymentRecipient)
        }

        pub fun changeRoyaltyReceivers(newRoyaltyReceivers: [Address], newCuts: [UFix64]) {

            // create the new royalty receivers
            let royaltyReceivers = STRANDS.createRoyaltyReceivers(newRoyaltyReceivers, newCuts)

            // update the royalty receivers
            STRANDS.royaltyReceivers = royaltyReceivers
            emit RoyaltyReceiversChanged(newRoyaltyReceivers: newRoyaltyReceivers)

        }

        pub fun pauseMinting() {
            pre {
                STRANDS.mintingIsPaused == false: "Minting is already paused!"
            }
            STRANDS.mintingIsPaused = true
            emit MintingPaused()
        }

        pub fun resumeMinting() {
            pre {
                STRANDS.mintingIsPaused == true: "Minting is not already paused!"
            }
            STRANDS.mintingIsPaused = false
            emit MintingResumed()
        }

    }

    // function that both the contract init and transactions can use to construct royalty receivers for STRANDS
    pub fun createRoyaltyReceivers(_ royaltyReceiverAddresses: [Address], _ cuts: [UFix64]): [MetadataViews.Royalty] {

        let royaltyReceiversList: [MetadataViews.Royalty] = []

        var index = 0
        for royaltyReceiver in royaltyReceiverAddresses {

            // create the Royalty struct
            let flowTokenReceiverCap = getAccount(royaltyReceiver).getCapability<&FlowToken.Vault{FungibleToken.Receiver}>(/public/flowTokenReceiver)
            assert(flowTokenReceiverCap.borrow() != nil, message: "Missing or mis-typed FlowToken receiver")

            let royaltyReceiver = MetadataViews.Royalty(
                receiver: flowTokenReceiverCap,
                cut: cuts[index],
                description: "Royalty receiver for STRANDS"
            )

            royaltyReceiversList.append(royaltyReceiver)

            index = index + 1

        }

        return royaltyReceiversList

    }

    // public function to get current mint price
    pub fun getMintPrice(): UFix64 {
        return STRANDS.mintPrice
    }

    // public function to get current mint price
    pub fun getMintingStatus(): Bool {
        return STRANDS.mintingIsPaused
    }

    // public function to get the whole strands registry
    pub fun getStrandsRegistry(): {String: UFix64} {
        return STRANDS.strands
    }

    // public function to get strands registry keys
    pub fun getStrandsRegistryKeys(): [String] {
        return STRANDS.strands.keys
    }
    // public function to get a strands registry timestamp
    pub fun getStrandRegistryTimestamp(strandID: String): UFix64? {
        return STRANDS.strands[strandID]
    }

    init() {
        // Initialize the total supply
        self.totalSupply = 0
        self.mintingIsPaused = false
        self.strands = {}

        self.paymentRecipient = self.account.address

        self.mintPrice = 10.0
        
        // add deployer as initial royalty receiver
        self.royaltyReceivers = STRANDS.createRoyaltyReceivers(
            [self.account.address],
            [0.05]
        )

        // Set the named paths
        self.CollectionStoragePath = /storage/strandsCollection
        self.CollectionPublicPath = /public/strandsCollection
        self.AdminStoragePath = /storage/strandsAdmin

        // Create a Collection resource and save it to storage
        let collection <- create Collection()
        self.account.save(<-collection, to: self.CollectionStoragePath)

        // create a public capability for the collection
        self.account.link<&STRANDS.Collection{NonFungibleToken.CollectionPublic, STRANDS.STRANDSCollectionPublic, MetadataViews.ResolverCollection}>(
            self.CollectionPublicPath,
            target: self.CollectionStoragePath
        )

        // Create an Admin resource and save it to storage
        let admin <- create Admin()
        self.account.save(<-admin, to: self.AdminStoragePath)

        emit ContractInitialized()
    }
}
 