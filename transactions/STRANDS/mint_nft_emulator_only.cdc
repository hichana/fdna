import NonFungibleToken from "../../contracts/core/NonFungibleToken.cdc"
import MetadataViews from "../../contracts/core/MetadataViews.cdc"
import FlowToken from "../../contracts/core/FlowToken.cdc"
import STRANDS from "../../contracts/STRANDS.cdc"
import Apples from "../../contracts/Apples.cdc"
import Oranges from "../../contracts/Oranges.cdc"
import Dogs from "../../contracts/Dogs.cdc"
import Cats from "../../contracts/Cats.cdc"

transaction(strandA: [String], strandAIDs: [UInt64], strandB: [String], strandBIDs: [UInt64], mintPrice: UFix64) {

    let buyerCollection: &STRANDS.Collection{NonFungibleToken.CollectionPublic}
    var strandARefs: [&NonFungibleToken.NFT]
    var strandBRefs: [&NonFungibleToken.NFT]
    let mintPrice: UFix64
    let buyerPaymentVault: &FlowToken.Vault

    prepare(signer: AuthAccount) {

        self.strandARefs = []
        self.strandBRefs = []
        self.mintPrice = mintPrice

        var loopAIndex = 0 
        for nft in strandA {
            switch nft {
                case "Apples":
                    let applesCollection = signer.borrow<&Apples.Collection{Apples.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Apples.CollectionStoragePath
                    ) ?? panic("Cannot borrow Apples collection capability from signer")

                    let applesNFT = applesCollection.borrowNFT(id: strandAIDs[loopAIndex])

                    if applesNFT != nil {
                        self.strandARefs.append(applesNFT)
                    }
                case "Oranges":
                    let applesCollection = signer.borrow<&Oranges.Collection{Oranges.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Oranges.CollectionStoragePath
                    ) ?? panic("Cannot borrow Oranges collection capability from signer")

                    let orangesNFT = applesCollection.borrowNFT(id: strandAIDs[loopAIndex])

                    if orangesNFT != nil {
                        self.strandARefs.append(orangesNFT)
                    }
                case "Dogs":
                    let dogsCollection = signer.borrow<&Dogs.Collection{Dogs.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Dogs.CollectionStoragePath
                    ) ?? panic("Cannot borrow Dogs collection capability from signer")

                    let dogsNFT = dogsCollection.borrowNFT(id: strandAIDs[loopAIndex])

                    if dogsNFT != nil {
                        self.strandARefs.append(dogsNFT)
                    }
                case "Cats":
                    let catsCollection = signer.borrow<&Cats.Collection{Cats.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Cats.CollectionStoragePath
                    ) ?? panic("Cannot borrow Cats collection capability from signer")

                    let catsNFT = catsCollection.borrowNFT(id: strandAIDs[loopAIndex])

                    if catsNFT != nil {
                        self.strandARefs.append(catsNFT)
                    }
               default:
                    panic("Can't find NFT.")
            }
            loopAIndex = loopAIndex + 1
        }

        var loopBIndex = 0 
        for nft in strandA {
            switch nft {
                case "Apples":
                    let applesCollection = signer.borrow<&Apples.Collection{Apples.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Apples.CollectionStoragePath
                    ) ?? panic("Cannot borrow Apples collection capability from signer")

                    let applesNFT = applesCollection.borrowNFT(id: strandBIDs[loopBIndex])

                    if applesNFT != nil {
                        self.strandBRefs.append(applesNFT)
                    }
                case "Oranges":
                    let applesCollection = signer.borrow<&Oranges.Collection{Oranges.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Oranges.CollectionStoragePath
                    ) ?? panic("Cannot borrow Oranges collection capability from signer")

                    let orangesNFT = applesCollection.borrowNFT(id: strandBIDs[loopBIndex])

                    if orangesNFT != nil {
                        self.strandBRefs.append(orangesNFT)
                    }
                case "Dogs":
                    let dogsCollection = signer.borrow<&Dogs.Collection{Dogs.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Dogs.CollectionStoragePath
                    ) ?? panic("Cannot borrow Dogs collection capability from signer")

                    let dogsNFT = dogsCollection.borrowNFT(id: strandBIDs[loopBIndex])

                    if dogsNFT != nil {
                        self.strandBRefs.append(dogsNFT)
                    }
                case "Cats":
                    let catsCollection = signer.borrow<&Cats.Collection{Cats.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Cats.CollectionStoragePath
                    ) ?? panic("Cannot borrow Cats collection capability from signer")

                    let catsNFT = catsCollection.borrowNFT(id: strandBIDs[loopBIndex])

                    if catsNFT != nil {
                        self.strandBRefs.append(catsNFT)
                    }
               default:
                    panic("Can't find NFT.")
            }
            loopBIndex = loopBIndex + 1
        }

        if signer.borrow<&STRANDS.Collection>(from: STRANDS.CollectionStoragePath) == nil {
            signer.save(<-STRANDS.createEmptyCollection(), to: STRANDS.CollectionStoragePath)
        }

        if signer.getLinkTarget(STRANDS.CollectionPublicPath) == nil {
            signer.link<&STRANDS.Collection{STRANDS.STRANDSCollectionPublic, NonFungibleToken.CollectionPublic}>(STRANDS.CollectionPublicPath, target: STRANDS.CollectionStoragePath)
        }

        self.buyerCollection = signer.borrow<&STRANDS.Collection{NonFungibleToken.CollectionPublic}>(
            from: STRANDS.CollectionStoragePath
        ) ?? panic("Cannot borrow STRANDS collection receiver capability from signer")

        self.buyerPaymentVault = signer.borrow<&FlowToken.Vault>(from: /storage/flowTokenVault)
            ?? panic("Can't borrow the Flow Token vault for the main payment from acct storage")
    }

    execute {
        STRANDS.mintNFT(
            recipient: self.buyerCollection,
            strandA: self.strandARefs,
            strandB: self.strandBRefs,
            payment: <- self.buyerPaymentVault.withdraw(amount: self.mintPrice)
        )
    }
}
 