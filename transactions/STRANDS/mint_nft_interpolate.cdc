// <dna>

import NonFungibleToken from "../../contracts/core/NonFungibleToken.cdc"
import MetadataViews from "../../contracts/core/MetadataViews.cdc"
import FlowToken from "../../contracts/core/FlowToken.cdc"
import STRANDS from "../../contracts/STRANDS.cdc"
// <imports>

transaction(mintPrice: UFix64) {

    let buyerCollection: &{NonFungibleToken.CollectionPublic}
    var strandARefs: [&NonFungibleToken.NFT]
    var strandBRefs: [&NonFungibleToken.NFT]
    let mintPrice: UFix64
    let buyerPaymentVault: &FlowToken.Vault

    prepare(signer: AuthAccount) {

        self.strandARefs = []
        self.strandBRefs = []
        self.mintPrice = mintPrice

        // <collections>

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
            strandARefs: self.strandARefs,
            strandBRefs: self.strandBRefs,
            payment: <- self.buyerPaymentVault.withdraw(amount: self.mintPrice)
        )
    }
}
 