import NonFungibleToken from "../../contracts/core/NonFungibleToken.cdc"
import MetadataViews from "../../contracts/core/MetadataViews.cdc"
import Cats from "../../contracts/Cats.cdc"

transaction {

    prepare(signer: AuthAccount) {
        
        // Return early if the account already has a collection
        if signer.borrow<&Cats.Collection>(from: Cats.CollectionStoragePath) != nil {
            return
        }

        // Create a new empty collection
        let collection1 <- Cats.createEmptyCollection()

        // save it to the account
        signer.save(<-collection1, to: Cats.CollectionStoragePath)

        // create a public capability for the collection
        signer.link<&{NonFungibleToken.CollectionPublic, Cats.ExampleNFTCollectionPublic, MetadataViews.ResolverCollection}>(
            Cats.CollectionPublicPath,
            target: Cats.CollectionStoragePath
        )

    }
}
