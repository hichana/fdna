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
    - need to buy NFT first





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


 