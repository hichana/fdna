# PROJECT SUMMARY
- Flow DNA strands are primitives for other experiences on Flow
- a Flow DNA strand comprises nft type base pairs as an ordered and immutable sequence that can only ever be created once
- any holder of one or more Flow NFTs can potentially claim a Flow DNA strand
- users can select and reorder NFTs from their Flow wallet to create a Flow DNA strand
- on-chain helper functions and sample Cadence scripts allow any Flow ecosystem project to easily query Flow DNA data from users

# REQUIREMENTS
- testnet deployment
    - populates test user with exampleNFTs in their wallet
- emulator
    - deploys nft catalog with example NFT contracts registered to nft catalog
    - manages accounts and testnet and mainnet deployments
    - demo user is issued example NFTs
- repo/docs
    - scripts examples walkthrough for pulling DNA data
    - examples of how DNA data can be leveraged across NFT experiences
- UI
    - user can see a list of all NFT projects for which their wallet contains a collection that is registered in the nft catalog
    - user can expand the list to reveal the NFTs and their metadata (displays image) from their wallet
    - user can toggle a checkbox next to each of their NFTs to select or deselect any number of their NFTs to build a Flow DNA strand
    - selected NFTs appear on a horizontal dnd pallete
    - user can drag selected NFTs from the pallet into either strand1 or strand2 and then reorder as needed
    - upon each reordering of either strand1 or strand2, a frontend script checks whether or not that permuation is taken and informs the user
    - user can mint their Flow DNA strand
    - user can see a card representing their Flow DNA strand with a list of the DNA string identifiers from each strand
    - overflow setup script registers projects to the nft-catalog and demonstrates the whole minting process
    - overflow scripts automate processes on testnet and mainnet
- smart contracts
    - Strand.cdc
        - integrates DNA data with the metadata standard Traits view
        - maintains a registry of DNA strands as strings that are comma-separated list of fully qualified identifiers, ex: A.[address].[contract-name].[nft-id]
            - key is strand string and value is a struct representing minter data, like wallet address, timestamp
        - admin can set the mint price in Flow tokens
        - NFT resource members include
            - a 'basePairs' [[String]] member to represent the ordered double-stranded/helix in DNA
            - a string representation of each strand ('strand1' and 'strand2'), where the string is a comma-separated list of fully qualified identifiers, ex: A.[address].[contract-name].[nft-id]
        - minter
            - constructs each DNA strand's concatenated string identifier and checks it against the registry, panicing if it already exists in the registry
            - when constructing the DNA strands, adds each ref or ref string to a strand1 and strand2 array, checks length of both, panicking if the length of each is different
        - provides public methods for retrieving DNA records

# ICEBOX/STRETCH REQUIREMENTS
- query params to save user state
- when minting, uses some kind of confetti with double helix art
- in my submission, include a dev.to post called 'the story of FLOW DNA' where I talk about over-engineering a solution with my recursive node structure for The FLOASIS, and why I chose to re-do/build it from the ground up and offer to other builders. "Because concatenated strings just looked yucky to me"
