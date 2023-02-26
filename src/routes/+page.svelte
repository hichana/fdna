<script lang="ts">
	import { user, strandA, strandB } from '#lib/stores';
	import { getUserNFTIDs, buySTRAND } from '#lib/actions';
	import Container from '#components/Container.svelte';
	import CTA from '#components/CTA.svelte';
	import type { UserNFTIDs } from '../types';
	import NFTsDetail from '#components/NFTsDetail.svelte';
	import DND from '#components/DND.svelte';
	import BuyTxStatus from '#components/BuyTxStatus.svelte';
	import DndNotifications from '#components/DNDNotifications.svelte';
	import Divider from '#components/Divider.svelte';
	import About from '#components/About.svelte';

	let userNFTIDs: UserNFTIDs | null = null;

	async function setUserNFTIDs2(currentUser: { addr: string }) {
		userNFTIDs = await getUserNFTIDs(currentUser?.addr);
	}

	user.subscribe((userState) => {
		if (userState !== null) {
			setUserNFTIDs2(userState);
		}
	});

	function getNFTIdentifier(collectionIdentifier: string, nftID: string) {
		const collectionTypeMembers = collectionIdentifier.split('.');
		collectionTypeMembers.pop();
		const fullyQualifiedIdentifier = collectionTypeMembers.join('.').concat(`.NFT.${nftID}`);
		return fullyQualifiedIdentifier;
	}

	let longestDNAStrand: any[] = [];
	$: {
		if ($strandA.length > $strandB.length) {
			longestDNAStrand = $strandA;
		} else {
			longestDNAStrand = $strandB;
		}
	}

	$: dnaIterator = Array.from({ length: longestDNAStrand.length }, (_, i) => i);

	function scrollTo(selector: string) {
		const element = document.querySelector(selector);
		if (element) {
			element.scrollIntoView({ behavior: 'smooth' });
		}
	}


    // check if the strand is ready
    let strandIsReady: boolean = false;
    let numBasePairs: number = 0;
    let numUniqueNFTProjectsInDNA: number = 0;
    
    $: {
        const strandLengthReady = $strandA.length > 0 && $strandB.length > 0;
        const strandIsEven = ($strandA.length === $strandB.length);
        (strandLengthReady && strandIsEven) ? (strandIsReady = true) : (strandIsReady = false);

        if (strandIsReady) {
            numBasePairs = $strandA.length;

            let nftProjects: string[] = [];

            $strandA.forEach((nft: any) => {
                if (!nftProjects.includes(nft.collectionName)) {
                    nftProjects.push(nft.collectionName);
                }
            })
            $strandB.forEach((nft: any) => {
                if (!nftProjects.includes(nft.collectionName)) {
                    nftProjects.push(nft.collectionName);
                }
            })

            numUniqueNFTProjectsInDNA = nftProjects.length;

        }

    }

</script>

<Container>
	<CTA />
</Container>

<div id="scroll-to-build"/>
<Divider />

<Container>
	<div class="flex flex-col gap-12 sm:gap-24">
        <div>
            <div class="px-4">

                <!-- prettier-ignore -->
                <pre class="leading-3 text-center text-xs">
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
                </pre>

                <p class="text-pink-300 text-md text-start my-6 px-4 md:p-0">
                    Start by learning more
                    <span class="text-blue-500">
                        <!-- svelte-ignore a11y-invalid-attribute -->
                        <a on:click|preventDefault={() => scrollTo('#scroll-to-about')} href="#">HERE,</a>
                    </span>
                    then build your STRAND by selecting two or more of your NFTs as the building blocks of your digital DNA on Flow:
                </p>
            </div>

            <div class="bg-slate-600 bg-opacity-30 border-2 border-phosgreen mx-4 rounded-sm">
                {#if userNFTIDs}
                    {#each Object.entries(userNFTIDs) as [collectionName, nftIDs]}
                        <NFTsDetail {collectionName} {nftIDs} />
                    {/each}
                {/if}
            </div>
        </div>

        <div>
        
            <!-- prettier-ignore -->
            <pre class="leading-3 text-center text-xs">
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
            </pre>
            <p class="mx-4 text-pink-300 text-md text-start my-6">
                A strand of digital DNA on Flow is itself made of two strands, 'strandA' and 'strandB'. Sequence your base pairs in each strand in any order that is meaningful to you -- the makeup, pairing and order may be useful in future projects on Flow.
            </p>
            <p class="text-xs italic mx-4 text-pink-300 my-2">
                * make sure you're creating 
                <span class="font-bold">
                    base pairs 
                </span>
                (so strandA has the same number of NFTs as strandB).
            </p>
            <div class="bg-slate-900 flex flex-col border-4 border-phosgreen border-dashed mx-4 rounded-sm">
                <div 
                    style="background-image:linear-gradient(rgba(135, 80, 156, 0.9), rgba(135, 80, 156, 0.9)), url(https://upload.wikimedia.org/wikipedia/commons/0/0c/DNA_animation.gif)"
                    class="flex bg-center bg-cover"
                >
                    <DND listName="strandA" items={$strandA} />
                    <DND listName="strandB" items={$strandB} />
                </div>
            </div>
                <div class="flex">
                    <DndNotifications listName="strandA" />
                    <DndNotifications listName="strandB" />
                </div>

        </div>
	</div>

</Container>

<Divider />

<Container>

    <!-- prettier-ignore -->
    <pre class="leading-3 text-center text-xs">
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
    </pre>

    <!-- prettier-ignore -->
    <div class="flex flex-col items-center mb-28 pt-12 border-phosgreen border-2 p-4 rounded-xl mx-auto mt-12">

        <div class="text-phosgreen">
            {#if longestDNAStrand.length > 0}
                {#each dnaIterator as _, i}
                    <pre>
            `-.`. ,',-'
                _,-'"
            ,-',' `.`-.
            `-.`. ,',-'
                _,-'"
            ,-',' `.`-.</pre>
<p class="break-all text-green-300">A: {$strandA[i] ? getNFTIdentifier($strandA[i].publicLinkedType.type.type.typeID, $strandA[i].nftID) : "(strand A DNA here)"}</p>
<p class="break-all text-green-300">B: {$strandB[i] ? getNFTIdentifier($strandB[i].publicLinkedType.type.type.typeID, $strandB[i].nftID) : "(strand B DNA here)"}</p>
            <pre>
            `-.`. ,',-'
                _,-'"
            ,-',' `.`-.
            `-.`. ,',-'
                _,-'"
            ,-',' `.`-.</pre>
                {/each}
            {/if}
        </div>
        <div class="pt-4 text-pink-300">
            <p>STRANDS DNA by {$user?.addr}</p>
            <p>contains {numBasePairs} base pairs</p>
            <p>{`from ${numUniqueNFTProjectsInDNA} Flow NFT project${numUniqueNFTProjectsInDNA > 1 ? "s" : ""}.`}</p>
        </div>
    </div>
</Container>


<Container>

	<!-- TODO: make a script that pulls mint price from on-chain and displays in UI and uses here -->
	<button
        class=" self-center text-phosgreen bg-slate-600 bg-opacity-30 border-phosgreen border-2 hover:bg-opacity-50 focus:ring-4 focus:outline-none focus:ring-pink-400 font-extrabold rounded-full text-lg md:text-6xl px-5 py-1.5 text-center max-w-2xl"
		on:click={() => {
			buySTRAND('10.0');
		}}
    >
        Big Mint Button
	</button>
	<BuyTxStatus />

	<div class="flex flex-col justify-center items-center">
		<div>
			You may be expecting a slick 3D animation of a pack opening and fire spewing out
			or something like that 🎉🔥🚀 -- but why try to be like all the other projects out there??
			🐓💨💨💨.
		</div>
		<div>
			Almost everything about STRANDS is on-chain, so instead of the fancy dancy, what we did was etch the following double
			helix of DNA onto your transaction code that minted your NFT here (make sure you save the
			link), and we also add real (but not really) DNA strands to the metadata of your NFT. Check
			them out here on Flowview. Thanks for minting a STRANDS NFT!!!
		</div>
	</div>

	{#if $user?.addr}
		<a
			href={`https://testnet.flowview.app/account/${$user.addr}/collection/strandsCollection`}
			target="_blank"
			rel="noreferrer">See your STRANDS collection on Flowview</a
		>
	{/if}
</Container>

<Divider />

<Container>
    <div id="scroll-to-about">
        <!-- prettier-ignore -->
        <pre class="leading-3 text-center text-xs">
 #  ##   #  # # ###
# # # # # # # #  # 
### ##  # # # #  # 
# # # # # # # #  # 
# # ##   #  ###  # 
        </pre>
    </div>
    <About />
    <p class="text-pink-300 text-md text-start my-6 px-4 md:p-0">
        Thanks for reading about STRANDS, now go 
        <span class="text-blue-500">
            <!-- svelte-ignore a11y-invalid-attribute -->
            <a on:click|preventDefault={() => scrollTo('#scroll-to-build')} href="#">BUILD!!!</a>
        </span>
    </p>
</Container>



