import FungibleToken from "../../contracts/core/FungibleToken.cdc"
import MetadataViews from "../../contracts/core/MetadataViews.cdc"

transaction(vaultPath: StoragePath) {

    prepare(signer: AuthAccount) {

        if signer.borrow<&FungibleToken.Vault>(from: vaultPath) == nil {
            panic("A vault for the specified fungible token path does not exist")
        }

        let capability = signer.link<&{FungibleToken.Receiver, FungibleToken.Balance}>(
            MetadataViews.getRoyaltyReceiverPublicPath(),
            target: vaultPath
        )!

        if !capability.check() { panic("Beneficiary capability is not valid!") }
    }
}