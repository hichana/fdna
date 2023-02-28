# BUILD OUT LAYOUT, DESIGN, ARTWORK 2
-x work on DND
    - will need to pull out the notifications for dnd. try
        - pull out components from DVD into a new component that takes in a string id of strand a or b
-x fix data load upon logging in
-x fix alignment while CTA is hidden
-x probably better to not have a big intro but just start with a title, subtitble, then "Select NFTs from your wallet"?
    -x maybe just start off with steps, like 1. If you don't have two or more Flow NFTs, go buy them from one of these awesome marketplaces
    -x the experience should start right away, and for those who want more info they should be able to veer off to get it. So how to handle it?
        -x options
            - modal with about info
            - second page
            - parse down info so one page is ok
            - keep info and make it all work, 
            - minimize info at the top, have a link to the bottom, then have the info at the bottom of the page
-x ok, new layout is
    - header
    - sub-header explainer
    - link to scroll to bottom to learn more (about section)
    - Collection/selector
    - DND DNA builder
    - Minter/view DNA section
    - About
        - more explainer text
        - links to marketplaces
        - faq
        - link to scroll back up to top and "start building DNA"
-x try
    - make a new component called About
        - move things into About from CTA
    - in About
        - build out the elements, componentize the accordion (into its own component to be used with both faq and NFT selection)
-x get login/out button to not flash loading
-x now get layout dialed
    - all components should be nested appropriately
    - modify for desktop to mobile
-x fix any remaining color scheme issues
- handle all remaining logic, like if user is logged in but has no NFTs from catalog
    - user does not have any NFTs from catalog
        - point them to monster maker
- update all copy














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
        -x make a new strandA and strandB that are just N concatenations of the dnaSegment
        -x run setup script with script to get metadata, inspect manually
        - etch double helix into tx code
            - "your unique double helix DNA has been etched onto your transaction to mint your NFT"
            - will simply be N concatenations of this, but will instead be fully qualified identifiers
            A: 233892348343
            - in interpolation helper
                -x construct the fully qualified identifier in the loop over nfts, append with A.
                - can do?
                    -x first
                        -no add each to own array. Then have two separate but ordered arrays
                        -x or, add first loop as single member arrays in an array, then second loop can index into the array and append/push
                            - this gives me array pairs in an array
                    -x second
                        - loop over the array of arrays to construct a new array of double helix segment, add each to a new array
                    -x third
                        - use same pattern as allImportStrings to construct
                    -x fourth
                        - add new flag in cdc interpolated string
                    -x fifth
                        - .replace appropriately
                    -x sixth
                        - look at dev wallet code to see the constructed tx
                    
                    




B: 233892348343
 `-.`. ,',-'
    _,-'"
 ,-',' `.`-.
A: 233892348343
B: 233892348343
 `-.`. ,',-'
    _,-'"
 ,-',' `.`-.
        -x construct the double helix in svelte frontend "this unique double helix has also been etched onto your transaction code to mint your NFT"

    -x do
        - in UI, last section will just be some stats in text form, then some text like "This is the point you might expect a 3D animation of a pack opening and fire spewing out or something like that, but almost everything about STRANDS is on-chain, so what we did was etch the following double helix of DNA onto your transaction code that minted your NFT here (make sure you save the link), and we also add real (but not really) DNA strands to the metadata of your NFT. Check them out here on Flowview. Thanks for minting a STRANDS NFT!!!




# BUILD PERMUTATION CHECKER
-x reqs
    - each side has a check "This DNA strand has already been claimed"
-x first I'm going to need a script to check if a permutation is taken or not
    - can use ' getStrandRegistryTimestamp', will return nil if doesn't exist
    - can construct the string, then feed to a script that takes in the string and does the check
-x have an unitialized state member 'strandClaimedCheck' as type undefined, null, or string
-x have a reactive statement
    - if strand length is greater than 1
        - construct the string
        - set the state member (not initialized) with the result (should either be a number or string, or null)
        - print to console to check
-x in markup, 
    - if === null, say is available
    - if !== undefined, say is not available
-x try
    -x first make the script work in emulator setup
    - build the above in the DND file
-x when am I using the STRANDS/get_nft_metadata and when amd I usting NFTCatalog/get_nfts_in_ccount_from_ids?
-x find anywhere I'm using, nft.publicLinkedType.type.type.typeID, make sure it's requiring the Collection identifier, not the nFT
    -x was a logic error incorrectly using Collection instead of NFT
    - now also fix page.svelte


# MAKE TX STATUS ELEMENT
-x first, for fun play w/ some colors
- how might this happen?
    -x have the buy tx use fcl.subscribe to update a writable
    -x in the frontend, have a reactive state member (null) watch the writable and set transaction text
        - own component is better actually
    -x display the text in frontend

# ONCE FUNCTIONALITY APPEARS OK, DO A TESTNET DEPLOYMENT 
-x have a testnet account ready
-x have testnet script set up appropriately
-x deploy contracts
-x run script against testnet (don't need to do this)
-x run devT
-x questions
    -x make strandB start halfway through in smart contract
    -x why is base pairs data so huge?
    -x why can't see tx (b/c need to print to console not the response body but the tx id when running app)
-x get tx link working in frontend
- re-deploy to testnet

