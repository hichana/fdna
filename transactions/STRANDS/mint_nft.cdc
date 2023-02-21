import NonFungibleToken from "../../contracts/core/NonFungibleToken.cdc"
import MetadataViews from "../../contracts/core/MetadataViews.cdc"
import FlowToken from "../../contracts/core/FlowToken.cdc"
import STRANDS from "../../contracts/STRANDS.cdc"

transaction() {

    let buyerCollection: &STRANDS.Collection{NonFungibleToken.CollectionPublic}
    let buyerPaymentVault: &FlowToken.Vault

    prepare(signer: AuthAccount) {

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
            payment: <- self.buyerPaymentVault.withdraw(amount: STRANDS.getMintPrice())
        )

    }
}
