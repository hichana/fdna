# PROJECT SUMMARY
- Flow DNA strands are building blocks for experiences on Flow
- a Flow DNA strand comprises nft type base pairs as an ordered and immutable sequence that can only ever be created once
- any holder of two or more Flow NFTs can potentially claim a Flow DNA strand
- users can select and reorder NFTs from their Flow wallet to create the two parallel helices of their Flow DNA strand
- on-chain helper functions and sample Cadence scripts allow any Flow ecosystem project to easily query Flow DNA data from users
- people who are new to Web3 can find links to the many great Flow marketplaces so they can buy NFTs and build their DNA strands

# BUILD APPROACH
-x scaffold app with basic emulator contracts deployment
-x build overflow emulator setup automation, adding transactions and scrips to confirm basic app requirements
    - develop contracts as much as possible I do this
-x scaffold web app while building basic app functionality in smart contracts
-x circle back to contracts, working on building data for string interpolated version of mint tx in frontend while also connecting UI elements to flow scripts and transactions
-x once functionality appears ok, do a testnet deployment 
-x checklist before testnet deploy/submission
    -x must have collection and NFT artwork created and links added to STRANDS, all other metadata strings must be right
    -x in minter, update mint strings for thumbnail and thumbnail path
    -x in fcl config, change app.detail.icon
-x launch/re-launch to testnet
-x complete build out layout, design, artwork
- create hackathon submission

# REQUIREMENTS
-x external
    - as soon as one or more exampleNFT contracts are suitable and working as expected on emulator, need to submit to testnet nft catalog
-x .env
    - contains all appropriate env vars suffixed if necessary with environment (emulator, testnet, mainnet)
-x fcl config
    - has conditional loading of config based on env var
-x flow config and deploy
    -x init flow.json
    -x add core contracts to repo
-x app
    -x has method for constructing mint transaction code for variable data received from nft catalog via user dna building process
    -x has configuration for using aliased paths in web app modules
    -x has helper to replace string imports to allow for using cadence inside svelte
    -x integrates tailwind css
    -x makes a .env available for use in web app and flow.json
    -x integrates prettier, svelte prettier plugin
    -x includes ignore files for git and prettier
-x functional UI
    -x has project artwork that is image of ascii dna???
    -x user can see a CTA to start building a Flow NFT collection -- includes descriptive text about this project and Web3/Flow, links to marketplaces and projects, and to the four OG Bases FLOATS
        - (not sure whether to do OG FLOATS or not)
    -x user can login using Blocto and other wallets
    -x user can see a list of all NFT projects for which their wallet contains a collection that is registered in the nft catalog
    -x user can expand the list of NFT projects to reveal the NFTs and their metadata (displays image) from their wallet
    -x user can toggle a checkbox next to each of their NFTs to select or deselect any number of their NFTs to include when building their Flow DNA strand
    -x selected NFTs appear can be arranged inside of two vertical dnd palletes to signify they are "base pairs"
    -x users can click/tap drag NFT data between vertical dnd to build and rearrange base pairs
    -x with each re-arrange of base pairs, user is informed whether or not that permutation of Flow DNA for either side is taken or not
    -x user can mint their Flow DNA strand, showing transaction status throughout the process and providing a link to the transaction on flowscan
    -x user can see a card representing their Flow DNA strand with a list of the DNA string identifiers from each strand
-x layout and design UI
    - as needed
- project submission to hackathon
    - precise presentation deck and short/understandable demo video
        - video is 2-3 minutes long
        - presentation deck is not more than 10 slides long
    - link to github repo
    - link to live version of project
        - web app
        - flowscan account with smart contracts
    - list of code used from other projects (ex. ExampleNFT, flow nft catalog scripts and transactions, etc.)
    - in description of challenges talk about wanting to save catalog data on-chian/nft but difficulties due to passing in NFT only ref
-x testnet deployment
    -x script populates test user with exampleNFTs in their wallet
    -x STRANDS has appropriate metadata set before final testnet deployment
    -x do final testnet deployment for submission
-x emulator
    -x manages accounts and testnet and mainnet deployments
    -x deploys nft catalog with example NFT contracts registered to nft catalog
    -x demo user is issued example NFTs
-x repo/docs
    - scripts examples walkthrough for pulling DNA data
    - examples of how DNA data can be leveraged across NFT experiences
    - includes instructions for judges to deploy and run the app locally and on testnet
-x smart contracts and scripts/transactions
    - contracts have sufficient comments to present the abstraction of DNA in a contract for appropriately
    -x NFTCatalog, NFTCatalogAdmin, NFTRetrieval (not deployed to testnet)
        - get nfts in account
        - get nfts in account from ids
    -x Strands
        -x has appropriate events
        -x can mint nfts
        -x on contract init
            -x sets royalty receiver(s)
            -x sets NFT sales payment receiver
            -x gives deployer admin resources
        -x has admin resource given to deployer with functions to
            - start or pause minting (checked by minter)
            - change nft royalty receiver
            - change nft payment receiver
        -x nft stores nft-catalog data for each NFT added to the DNA
        -x integrates DNA data with the metadata standard Traits view
        -x maintains a registry of DNA strands as strings that are comma-separated list of fully qualified identifiers, ex: A.[address].[contract-name].[nft-id]
            - key is strand string and value is a struct representing minter data, like wallet address, timestamp
        -x admin can set the mint price in Flow tokens
        -x NFT resource members include
            - a 'basePairs' [[String]] member to represent the ordered double-stranded/helix in DNA
            - a string representation of each strand ('helix1' and 'helix2'), where the string is a comma-separated list of fully qualified identifiers, ex: A.[address].[contract-name].[nft-id]
        -x minter
            -x constructs each DNA strand's concatenated string identifier and checks it against the registry, panicing if it already exists in the registry
            -x when constructing the DNA strands, adds each ref or ref string to a strand1 and strand2 array, checks length of both, panicking if the length of each is different (not necessary)
        -x provides public methods for retrieving DNA records
            - function provides getting data in 'base pairs', [[String]]
        -x metadata
            - number of base pairs
    -x ExampleNFTs (Cats, Dogs, etc.)
        - has admin method to add nfts to catalog for emulator
        - has method to set up royalty receiver
        - has tx to give demo user NFTs
-x project artwork
    - NFT art (single image for all)
    - Strand.cdc metadata art
    - ExampleNFT.cdc metadata art
-x project deployment (vercel)
    -x adds devT to package.json
    -x vercel settings for deployment includes appropriately scoped env var for flow_env, and any others that may use conditional logic

# ICEBOX/STRETCH REQUIREMENTS
- add svelte confetti, find png w/ alpha layer images of DNA and use those
    https://github.com/Mitcheljager/svelte-confetti
- embed the ascii art on-chain as the three pieces separated by <br> -- use metadata standard to say how to display it (like timestamp does)
- add page.ts to grab env var for FLOW_ENV and feed to markup to conditionally render either mainnet or testnet flowview
- build a double-helix view of NFTs that were just minted into user DNA. can use the strandA and strandB writable store for the data
- if time refactor string interpolation to not make redundant collection borrows
- use AuthAccount (in minter) to verify person minting actually owns the NFTs rather than just checking resource owner and comparing against deposit collection address
- web app background cylces between green, purple, blue and yellow
- query params to save user state
- when minting, uses some kind of confetti with double helix art
- in my submission, include a dev.to post called 'the story of FLOW DNA' where I talk about over-engineering a solution with my recursive node structure for The FLOASIS, and why I chose to re-do/build it from the ground up and offer to other builders. "Because concatenated strings just looked yucky to me"
- user integration tests
    - can't mint an uneven number base pair
    - has a testing utils that can be used with an integration test
    - basic integration test to test DNA building and minting
        - admin can change payment recipient
        - admin can change royalty receivers
        - admin cna change mint price
    -x setup script registers projects to the nft-catalog and demonstrates the whole minting process
    -x scripts automate processes on testnet
    -x has testnet scripts and transactions
        - setup account to receive royalties
        - give demo user NFTs 

# MAINNET
- figure out how IPFS paths really work for metadata standard
ipfs://bafybeignscwxzysa25xvw37injizn3nw2af77jfrtnf7xegr5kaisuicne
https://bafybeigy7cpgakfxdabjb2gxcri3fdojeyvalwq5estarwwjy6qvolzgeu.ipfs.w3s.link/athletian-hat-thumbnail.png

- would need to process tx for mainnet service account to receive royalties
- OG Bases FLOATs
    - four limited FLOATs ("A", "G", "C", "T") that anyone can get to bootstrap their NFT collection and start building Flow DNA right away

# HASH TEXT
##  # # ### #   ## 
# # # #  #  #   # #
##  # #  #  #   # #
# # # #  #  #   # #
##  ### ### ### ## 

                <!-- prettier-ignore -->
                <!-- <pre class="leading-3 text-center text-xs">
 ## # #  #   #   ## ###
#   # # # # # # #   #  
#   ### # # # #  #  ## 
#   # # # # # #   # #  
 ## # #  #   #  ##  ###

##  # # ### #   ##  ### ###  ## 
# # # #  #  #   # #  #  # # #   
##  # #  #  #   # #  #  # # # # 
# # # #  #  #   # #  #  # # # # 
##  ### ### ### ##  ### # #  ## 
                        
##  #    #   ## # #  ## 
# # #   # # #   # # #   
##  #   # # #   ##   #  
# # #   # # #   # #   # 
##  ###  #   ## # # ##  
                </pre> -->

        
            <!-- prettier-ignore -->
            <!-- <pre class="leading-3 text-center text-xs">
##   #   ## ### 
# # # # #   #   
##  ###  #  ##  
# # # #   # #   
##  # # ##  ### 

                    
##   #  ### ##   ## 
# # # #  #  # # #   
##  ###  #  ##   #  
#   # #  #  # #   # 
#   # # ### # # ##  

                                        
 ## ###  #  # # ### ###  ## ### ###  ## 
#   #   # # # # #   # # #    #  # # #   
 #  ##  # # # # ##  # # #    #  # # # # 
  # #    ## # # #   # # #    #  # # # # 
##  ###   # ### ### # #  ## ### # #  ## 
            </pre> -->


    <!-- prettier-ignore -->
    <!-- <pre class="leading-3 text-center text-xs">
# # ### ### ###
###  #  # #  # 
###  #  # #  # 
# #  #  # #  # 
# # ### # #  # 


# #  #  # # ## 
# # # # # # # #
 #  # # # # ## 
 #  # # # # # #
 #   #  ### # #

## ### ##   #  ### ## 
#   #  # # # # # # # #
 #  #  ##  ### # # # #
  # #  # # # # # # # #
##  #  # # # # # # ## 
    </pre> -->

            <!-- <a on:click|preventDefault={() => scrollTo('#scroll-to-about')} href="#">Learn more first</a> -->