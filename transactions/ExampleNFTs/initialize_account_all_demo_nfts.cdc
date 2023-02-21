import NonFungibleToken from "../../contracts/core/NonFungibleToken.cdc"
import MetadataViews from "../../contracts/core/MetadataViews.cdc"
import Cats from "../../contracts/Cats.cdc"
import Dogs from "../../contracts/Dogs.cdc"
import Apples from "../../contracts/Apples.cdc"
import Oranges from "../../contracts/Oranges.cdc"
import Black from "../../contracts/Black.cdc"
import White from "../../contracts/White.cdc"

transaction {

    prepare(signer: AuthAccount) {
        
        // Cats
        if signer.borrow<&Cats.Collection>(from: Cats.CollectionStoragePath) != nil {
            return
        }

        let catsCollection <- Cats.createEmptyCollection()

        signer.save(<-catsCollection, to: Cats.CollectionStoragePath)

        signer.link<&{NonFungibleToken.CollectionPublic, Cats.ExampleNFTCollectionPublic, MetadataViews.ResolverCollection}>(
            Cats.CollectionPublicPath,
            target: Cats.CollectionStoragePath
        )

        // Dogs
        if signer.borrow<&Cats.Collection>(from: Dogs.CollectionStoragePath) != nil {
            return
        }

        let dogsCollection <- Dogs.createEmptyCollection()

        signer.save(<-dogsCollection, to: Dogs.CollectionStoragePath)

        signer.link<&{NonFungibleToken.CollectionPublic, Dogs.ExampleNFTCollectionPublic, MetadataViews.ResolverCollection}>(
            Dogs.CollectionPublicPath,
            target: Dogs.CollectionStoragePath
        )

        // Apples
        if signer.borrow<&Cats.Collection>(from: Apples.CollectionStoragePath) != nil {
            return
        }

        let applesCollection <- Apples.createEmptyCollection()

        signer.save(<-applesCollection, to: Apples.CollectionStoragePath)

        signer.link<&{NonFungibleToken.CollectionPublic, Apples.ExampleNFTCollectionPublic, MetadataViews.ResolverCollection}>(
            Apples.CollectionPublicPath,
            target: Apples.CollectionStoragePath
        )

        // Oranges
        if signer.borrow<&Cats.Collection>(from: Oranges.CollectionStoragePath) != nil {
            return
        }

        let orangesCollection <- Oranges.createEmptyCollection()

        signer.save(<-orangesCollection, to: Oranges.CollectionStoragePath)

        signer.link<&{NonFungibleToken.CollectionPublic, Oranges.ExampleNFTCollectionPublic, MetadataViews.ResolverCollection}>(
            Oranges.CollectionPublicPath,
            target: Oranges.CollectionStoragePath
        )

        // Black
        if signer.borrow<&Cats.Collection>(from: Black.CollectionStoragePath) != nil {
            return
        }

        let blackCollection <- Black.createEmptyCollection()

        signer.save(<-blackCollection, to: Black.CollectionStoragePath)

        signer.link<&{NonFungibleToken.CollectionPublic, Black.ExampleNFTCollectionPublic, MetadataViews.ResolverCollection}>(
            Black.CollectionPublicPath,
            target: Black.CollectionStoragePath
        )

        // White
        if signer.borrow<&Cats.Collection>(from: White.CollectionStoragePath) != nil {
            return
        }

        let whiteCollection <- White.createEmptyCollection()

        signer.save(<-whiteCollection, to: White.CollectionStoragePath)

        signer.link<&{NonFungibleToken.CollectionPublic, White.ExampleNFTCollectionPublic, MetadataViews.ResolverCollection}>(
            White.CollectionPublicPath,
            target: White.CollectionStoragePath
        )

    }
}
