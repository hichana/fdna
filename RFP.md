# SCAFFOLD WEB APP
-x bootstrap a svelte project into another folder, then drop into this repo
    -x tailwind
    -x confirm prettier, lint, typescript build
    -x fcl config
        - first add user login
    -x aliased paths


# BUILD V1 OF STRANDS CONTRACT
- fork over example nft and adjust
    -x needs a public minter funciton that accepts payments
    -x construct name, royalties
    -x add ipfs path and display view
    -x make minter public and receive payment
    -x  needs an admin resource
        - fun to set royalty receivers when minting
        - fun to set payment recipient 
        - fun to set mint price
- now build out DNA abstraction and other features
    -x need to buy NFT first
    - contract level has a registry of strings representing single side of a dna strand each
        - should be a dnaStrands dict w/ key of string, and value of a DNASingleStrand struct, which contains things like 'sequenced' timestamp, 'sequencer' address
    - minter checks the registry for a string key in the dnaStrands registry
        - minter will need to receive an array of arrays of refs
            - will iterate over them to create
                - two separate strings, one for strand1 and other for strand2
                - an array of arrays of fully qualified string identifiers (identifier + nft id)
            - on each iteration 
                - should check length of inner array -- should be 2 and panic if not
                - recipient collection owner should equal nft reference owner
            - should add to 'metadata' member on the nft
                - 'strand1' (concatenated strings)
                - 'strand2' (concatenated strings)
                - 'doubleHelix' (array of arrays of fully qualified string identifiers)
            - will do a check for each completed 
    - nft captures all nft-catalog data upon mint???
    - metadata traits view resolver pulls metadata about DNA and returns it
        - minter adds the data to 'metadata' member first





```
# SCAFFOLD APP WITH BASIC EMULATOR CONTRACTS DEPLOYMENT
-x add .env with testnet, mainnet service accounts and demo user
-x get deployment working to emulator
    -x add contracts, set them up in flow.json
    -x will need an overflow script
        -x set up overflow
            -x need to add placeholder smart contract to run a script, use basic from flow playground
-x register example NFT projects to nft catalog, mint user1 demo NFTs
    -x make six of them, cats, dogs, apples, oranges, black, white
        - make tx to give user1 some nfts from each
            -x steps to swap out name from ExampleNFT.cdc
                - cmd d all the instances of contract name
                - change metadata standard supplied data
                - cmd d all storage path handles
                - change minter storage path
            -x now mint nfts to exmaple user and register cats to nft catalog
                - need to set up initialize and royalty receiver
            -x now add rest of contracts with same setup in script
                -x replace things using abov list
                -x update flow.json
                - update setup script
                    - replace thumbnail for each
    -x register all demo NFT projects in nft catalog


 
 