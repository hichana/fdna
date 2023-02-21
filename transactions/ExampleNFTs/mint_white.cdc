import NonFungibleToken from "../../contracts/core/NonFungibleToken.cdc"
import White from "../../contracts/White.cdc"
import MetadataViews from "../../contracts/core/MetadataViews.cdc"
import FungibleToken from "../../contracts/core/FungibleToken.cdc"

transaction(
    recipient: Address,
    name: String,
    description: String,
    thumbnail: String,
    cuts: [UFix64],
    royaltyDescriptions: [String],
    royaltyBeneficiaries: [Address] 
) {

    let minter: &White.NFTMinter
    let recipientCollectionRef: &{NonFungibleToken.CollectionPublic}

    let mintingIDBefore1: UInt64

    prepare(signer: AuthAccount) {
        self.mintingIDBefore1 = White.totalSupply

        self.minter = signer.borrow<&White.NFTMinter>(from: White.MinterStoragePath)
            ?? panic("Account does not store an object at the specified path")

        // Borrow the recipient's public NFT collection reference
        self.recipientCollectionRef = getAccount(recipient)
            .getCapability(White.CollectionPublicPath)
            .borrow<&{NonFungibleToken.CollectionPublic}>()
            ?? panic("Could not get receiver reference to the NFT Collection")

    }

    pre {
        cuts.length == royaltyDescriptions.length && cuts.length == royaltyBeneficiaries.length: "Array length should be equal for royalty related details"
    }

    execute {

        // Create the royalty details
        var count = 0
        var royalties: [MetadataViews.Royalty] = []
        while royaltyBeneficiaries.length > count {
            let beneficiary = royaltyBeneficiaries[count]
            let beneficiaryCapability = getAccount(beneficiary)
            .getCapability<&{FungibleToken.Receiver}>(MetadataViews.getRoyaltyReceiverPublicPath())

            // Make sure the royalty capability is valid before minting the NFT
            if !beneficiaryCapability.check() { panic("Beneficiary capability is not valid!") }

            royalties.append(
                MetadataViews.Royalty(
                    receiver: beneficiaryCapability,
                    cut: cuts[count],
                    description: royaltyDescriptions[count]
                )
            )
            count = count + 1
        }

        // Mint the NFT and deposit it to the recipient's collection
        self.minter.mintNFT(
            recipient: self.recipientCollectionRef,
            name: name,
            description: description,
            thumbnail: thumbnail,
            royalties: royalties
        )
    }

    post {
        self.recipientCollectionRef.getIDs().contains(self.mintingIDBefore1): "The next NFT ID should have been minted and delivered"
        
        // note, this should be incremented according to num nfts given to someone
        White.totalSupply == self.mintingIDBefore1 + 1: "The total supply should have been increased by 1"
    }
}
 