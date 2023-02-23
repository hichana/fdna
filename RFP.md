# BUILD OUT LAYOUT, DESIGN, ARTWORK
- start by building functional UI (what remains)
    -x login/out
    -x accordion view of user wallet nfts with inner views of nfts
    -x dnds
    -x mint button
    -x link to view nfts on flowview
- now build a layout and drop the existing various pieces in
    -x make a nav
    -x make a generic container to be used for cta, build and mint sections
        - to start, split out the accordion, dnd and link into three of them
    -x make the dnds be horizontal
    -x add CTA
    -x make the FAQ accordion
    -x work on the dnd
        - should have a minimum height
        - should grow as items are added
        - should not have scroll
        - should be two parallel columns that fill in the container with space around
    -x make the bottom section
        - an image, borring
        - no bottom image at all, just some stats, then show ascii, then text pointing to tx. Two easter eggs are
            - strandA and strandB are now like this
                  _.--'"'--._A.455569ddf52adebe.STRANDS.3_.--'"'--._A.455569ddf52adebe.STRANDS.3_.--'"'--._A.455569ddf52adebe.STRANDS.3_.--'"'--._A.455569ddf52adebe.STRANDS.3

                    _.--'"`'--.__.--'"`'--._ _.--'"`'--._

                    _.--'^`'--.__.--'^`'--.__.--'^`'--._

                    this one
                   _.--''``'--.__.--''``'--.__.--''``'--._

                  _.--'"'--._ 
                  _.--'"'--.__.--'"'--._
                  _.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'_.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'_.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'_.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'_.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'_.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'_.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'_.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'_.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'_.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'_.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'_.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'_.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'_.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'_.--'"'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'



                  _.--'"`'--._ 34434455435433'-..,..-'
                  _.--'"`'--._ A.455569ddf52adebe.STRANDS.3'-..,..-'


        let dnaSegment = "_.--'^`'--._"
        let dnaSegment = "_.--''``'--._"


    - do
        -x make minter get params strandARefs
        -x change mint tx code
        -x change strandA and strandB metadata members to be strandAStrings and strandBStrings
        -x construct the N length dna strands as strandA and strandB
        - run setup script with script to get metadata, inspect manually
        - make a new strandA and strandB that are just N concatenations of the dnaSegment
        - construct the double helix in svelte frontend "this unique double helix has also been etched onto your transaction code to mint your NFT"
        - etch double helix into tx code
            - "your unique double helix DNA has been etched onto your transaction to mint your NFT"
            - will simply be N concatenations of this, but will instead be fully qualified identifiers
            A: 233892348343
B: 233892348343
 `-.`. ,',-'
    _,-'"
 ,-',' `.`-.
A: 233892348343
B: 233892348343
 `-.`. ,',-'
    _,-'"
 ,-',' `.`-.

    - do
        - in UI, last section will just be some stats in text form, then some text like "This is the point you might expect a 3D animation of a pack opening and fire spewing out or something like that, but almost everything about STRANDS is on-chain, so what we did was etch the following double helix of DNA onto your transaction code that minted your NFT here (make sure you save the link), and we also add real (but not really) DNA strands to the metadata of your NFT. Check them out here on Flowview. Thanks for minting a STRANDS NFT!!!







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


 
 # SCAFFOLD WEB APP
-x bootstrap a svelte project into another folder, then drop into this repo
    -x tailwind
    -x confirm prettier, lint, typescript build
    -x fcl config
        - first add user login
    -x aliased paths
-x conduct basic functionality to mint dna
    - get and display data
        -x pull user wallet nft data
        -x instead need user nft ids for all their collection views
        -x display as accordion with checkboxes, make on hover pull invididual collection nft data
        -x add check to writable state
        - have reactive data from writable state to populate first DND
            -x first make the reactive state make a single array
            -x add dnd
    -x use checkbox data in parallel dnds, add rearrange to state
    - figure out string interpolated tx code construction with dnds data
        - start w/ nft contract, minter
            -x nft should have
                - two string members and one array of array of a struct called a Base which will contain a Type and ID
            -x metadata resolver
                - should consume the new data members (does by default)
            -x should take in
                - recipient collection cap
                - standA refs
                - strandB refs
                - payment
        -x make emulator work with an emulator only tx first
        -x interpolated tx
            -x first make a button that calls a buy tx
                - should take in
                    - strand a
                    - strand b
                    - mint price
            - should iterate over both strand a and b to create a non-duplicated list of
                - imports
                - collection borrows (first start off with making collection let name just be the fully qualified identifier, so will be making more collection borrows than actually needed, but fine for now. Add way to optimize this to icebox)
            - tx template
                - needs to replace part for imports and collection borrows, then mint NFT
        -x verify can view collectino and nft images in frontend, then submit all demo contracts to testnet nft catalog
            -x view in console, check images
            -x deploy
            -x give testnet user1 nfts
        -x add the check on DNA uniqueness against registry, verify in emulator
            - add registry of DNA strands as strings that are comma-separated list of fully qualified identifiers, ex: A.[address].[contract-name].[nft-id]
                -x key is strand string and value is a struct representing minter data, like wallet address, timestamp
                    - actually, just make it key as strand and value as minted timestamp
                -x registry should have methods to get its data
                    - keys
                    - a value
        -x checks to make sure num refs is two or more and an even number
            - don't need it, iterating over the strands to make base pairs will throw an index out of bounds error if an uneven number is passed in
        -x add the check that recipient colleciton owner same as each NFT refs owner
        -x add public methods for retrieving DNA records
            - function provides getting data in 'base pairs', [[String]]
            - note, this hsould be provided my metadata resolver
        -x nft should store appropriate catalog data w/o being too redundant with the catalog
            - a consumer of the data might be a frontend
                - in a single script
                    - borrows NFT
                    - uses similar code to nft catalog script to get nfts data by ids
                - would need a convenience method on 
                - can't get metadata on generic NFT, can't trust caller to provide collection and nft data
                    - should be up to a frontend to get this data
            - abandoning this, can't figure out
        -x double check that metadata form dna is being added and resolved properly via metadata standard
            - add one of the metadata scripts and look at result

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


