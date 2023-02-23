import NonFungibleToken from "../../contracts/core/NonFungibleToken.cdc"
import MetadataViews from "../../contracts/core/MetadataViews.cdc"
import FlowToken from "../../contracts/core/FlowToken.cdc"
import STRANDS from "../../contracts/STRANDS.cdc"
import Apples from "../../contracts/Apples.cdc"
import Oranges from "../../contracts/Oranges.cdc"
import Dogs from "../../contracts/Dogs.cdc"
import Cats from "../../contracts/Cats.cdc"

transaction(strandA: [String], strandAIDs: [UInt64], strandB: [String], strandBIDs: [UInt64], mintPrice: UFix64) {

    let buyerCollection: &{NonFungibleToken.CollectionPublic}
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
                    let applesACollection = signer.borrow<&Apples.Collection{Apples.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Apples.CollectionStoragePath
                    ) ?? panic("Cannot borrow Apples collection capability from signer")

                    let applesANFT = applesACollection.borrowNFT(id: strandAIDs[loopAIndex])

                    if applesANFT != nil {
                        self.strandARefs.append(applesANFT)
                    }
                case "Oranges":
                    let orangesACollection = signer.borrow<&Oranges.Collection{Oranges.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Oranges.CollectionStoragePath
                    ) ?? panic("Cannot borrow Oranges collection capability from signer")

                    let orangesANFT = orangesACollection.borrowNFT(id: strandAIDs[loopAIndex])

                    if orangesANFT != nil {
                        self.strandARefs.append(orangesANFT)
                    }
                case "Dogs":
                    let dogsACollection = signer.borrow<&Dogs.Collection{Dogs.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Dogs.CollectionStoragePath
                    ) ?? panic("Cannot borrow Dogs collection capability from signer")

                    let dogsANFT = dogsACollection.borrowNFT(id: strandAIDs[loopAIndex])

                    if dogsANFT != nil {
                        self.strandARefs.append(dogsANFT)
                    }
                case "Cats":
                    let catsACollection = signer.borrow<&Cats.Collection{Cats.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Cats.CollectionStoragePath
                    ) ?? panic("Cannot borrow Cats collection capability from signer")

                    let catsANFT = catsACollection.borrowNFT(id: strandAIDs[loopAIndex])

                    if catsANFT != nil {
                        self.strandARefs.append(catsANFT)
                    }
               default:
                    panic("Can't find NFT.")
            }
            loopAIndex = loopAIndex + 1
        }

        var loopBIndex = 0 
        for nft in strandB {
            switch nft {
                case "Apples":
                    let applesBCollection = signer.borrow<&Apples.Collection{Apples.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Apples.CollectionStoragePath
                    ) ?? panic("Cannot borrow Apples collection capability from signer")

                    let applesBNFT = applesBCollection.borrowNFT(id: strandBIDs[loopBIndex])

                    if applesBNFT != nil {
                        self.strandBRefs.append(applesBNFT)
                    }
                case "Oranges":
                    let orangesBCollection = signer.borrow<&Oranges.Collection{Oranges.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Oranges.CollectionStoragePath
                    ) ?? panic("Cannot borrow Oranges collection capability from signer")

                    let orangesBNFT = orangesBCollection.borrowNFT(id: strandBIDs[loopBIndex])

                    if orangesBNFT != nil {
                        self.strandBRefs.append(orangesBNFT)
                    }
                case "Dogs":
                    let dogsBCollection = signer.borrow<&Dogs.Collection{Dogs.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Dogs.CollectionStoragePath
                    ) ?? panic("Cannot borrow Dogs collection capability from signer")

                    let dogsBNFT = dogsBCollection.borrowNFT(id: strandBIDs[loopBIndex])

                    if dogsBNFT != nil {
                        self.strandBRefs.append(dogsBNFT)
                    }
                case "Cats":
                    let catsBCollection = signer.borrow<&Cats.Collection{Cats.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(
                        from: Cats.CollectionStoragePath
                    ) ?? panic("Cannot borrow Cats collection capability from signer")

                    let catsBNFT = catsBCollection.borrowNFT(id: strandBIDs[loopBIndex])

                    if catsBNFT != nil {
                        self.strandBRefs.append(catsBNFT)
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
 