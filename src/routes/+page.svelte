<script lang="ts">
	import { user, strandA, strandB, buyTxStatus, buyTxID } from '#lib/stores';
	import { slide } from 'svelte/transition';
	import { getUserNFTIDs, buySTRAND } from '#lib/actions';
	import Container from '#components/Container.svelte';
	import CTA from '#components/CTA.svelte';
	import type { UserNFTIDs } from '../types';
	import NFTsDetail from '#components/NFTsDetail.svelte';
	import DND from '#components/DND.svelte';
	import BuyTxStatus from '#components/BuyTxStatus.svelte';
	import DndNotifications from '#components/DNDNotifications.svelte';
	import About from '#components/About.svelte';
	import SeparatorStrand from '#components/SeparatorStrand.svelte';
	import Button from '#components/Button.svelte';

	let userNFTIDs: UserNFTIDs | null = null;
    let userHasAtLeastTwoNFTs: boolean = false;
    console.log("userHasAtLeastTwoNFTs: ", userHasAtLeastTwoNFTs);
    
    // let userHasAtLeastTwoNFTs: boolean | null = null;
    // $: {
    //     if (userNFTIDs) {
    //         Object.values(userNFTIDs).forEach((nftIDs) => {
    //             if (nftIDs.length > 1) {
    //                 userHasAtLeastTwoNFTs = true;
    //             }
    //         })
    //     }
    // }

	async function setUserNFTIDs2(currentUser: { addr: string }) {
		userNFTIDs = await getUserNFTIDs(currentUser?.addr);
        userNFTIDs && Object.values(userNFTIDs).forEach((nftIDs) => {
            if (nftIDs.length > 1) {
                userHasAtLeastTwoNFTs = true;
            }
        })
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

	// check if the strand is ready
	let strandIsReady: boolean = false;
	let numBasePairs: number = 0;
	let numUniqueNFTProjectsInDNA: number = 0;

	$: nftsAreSelected = $strandA.length > 0 || $strandB.length > 0;

	$: {
		const strandLengthReady = $strandA.length > 0 && $strandB.length > 0;
		const strandIsEven = $strandA.length === $strandB.length;
		strandLengthReady && strandIsEven ? (strandIsReady = true) : (strandIsReady = false);

		if (strandIsReady) {
			numBasePairs = $strandA.length;

			let nftProjects: string[] = [];

			$strandA.forEach((nft: any) => {
				if (!nftProjects.includes(nft.collectionName)) {
					nftProjects.push(nft.collectionName);
				}
			});
			$strandB.forEach((nft: any) => {
				if (!nftProjects.includes(nft.collectionName)) {
					nftProjects.push(nft.collectionName);
				}
			});

			numUniqueNFTProjectsInDNA = nftProjects.length;
		}
	}
</script>

<Container>
	<CTA />
</Container>

<Container>
	<SeparatorStrand />
	<div id="scroll-to-build" />
	<div class="flex flex-col gap-12 sm:gap-24">
		<div>
			<div class="px-4">
				<p class="text-center text-3xl md:text-5xl">
					<span class="bg-gradient-to-b from-phosgreen to-white bg-clip-text text-transparent"
						>Choose your building blocks</span
					>
				</p>
				<p class="text-md my-6 px-4 text-start md:px-12">
					Build your STRAND by selecting two or more of your NFTs as the building blocks of your
					digital DNA on Flow:
				</p>
			</div>
            {#if userNFTIDs && (userHasAtLeastTwoNFTs === true)}
            <!-- {#if userNFTIDs} -->
                {#each Object.entries(userNFTIDs) as [collectionName, nftIDs]}
                    <div class="mx-4 rounded-2xl border-2 border-phosgreen bg-slate-600 bg-opacity-30">
                        <NFTsDetail {collectionName} {nftIDs} />
                    </div>
                {/each}
            {:else if userNFTIDs && (userHasAtLeastTwoNFTs === false)}
                <div class="mx-4 rounded-2xl border-2 border-phosgreen bg-slate-600 bg-opacity-30">
                    <div class="flex flex-col items-center gap-8 p-10">
                        <p class="">Flow Noooo!!! Looks like you don't two or more NFTs that are from smart contracts registered to the 
                            <span> <a class=" underline text-blue-400 font-normal text-center" href="https://www.flow-nft-catalog.com/" target="_blank" rel="noreferrer">Flow NFT Catalog</a></span>
                            . Since this app is on testnet for now, you can easily go to MonsterMaker and get some!</p>
                        <a class=" underline text-blue-400 font-normal text-center" href="https://monster-maker-web-client.vercel.app/view" target="_blank" rel="noreferrer">Monster Maker</a>
                    </div>
                </div>
            {/if}
		</div>

		<div>
			<p class="text-center text-3xl md:text-5xl">
				<span class="">Sequence your base pairs</span>
			</p>

			<p class="text-md my-6 px-4 text-start md:px-12">
				A strand of digital DNA on Flow is itself made of two strands, 'strandA' and 'strandB'.
				Drag the cards below to sequence your base pairs in each strand in any order that is meaningful to you -- the
				makeup, pairing and order may be useful in this, or other future projects on Flow.
			</p>
			<p class="mx-4 my-2 text-sm italic">
				* make sure you're creating
				<span class="font-bold"> base pairs </span>
				(so that strandA has the same number of NFTs as strandB).
			</p>
            <div class="flex gap-0">
                <div
                    class="sm:mx-4 flex flex-col w-full"
                >
                    <div
                        style="background-image:linear-gradient(rgba(0, 200, 0, 0.4), rgba(0, 200, 0, 0.4)), url(https://upload.wikimedia.org/wikipedia/commons/0/0c/DNA_animation.gif)"
                        class="flex bg-cover bg-center sm:rounded-lg rounded-l-lg ml-4 sm:ml-0"
                    >
                        {#if nftsAreSelected}
                            <DND listName="strandA" items={$strandA} />
                            <DND listName="strandB" items={$strandB} />
                        {:else}
                            <div class="flex mx-auto h-36 sm:h-96 items-center">
                                <p class="text-md sm:text-3xl font-normal">(Select NFTs above to start sequencing)</p>
                            </div>
                        {/if}
                    </div>
                </div>
                <div class="sm:hidden bg-slate-500 mr-4 flex items-center px-1 rounded-r-lg"> 
                    <p class="text-slate-400 font-semibold">三</p>
                </div>
            </div>
			<div class="flex">
				<DndNotifications listName="strandA" />
				<DndNotifications listName="strandB" />
			</div>
		</div>
	</div>

	{#if numBasePairs > 0}
		<div class="flex flex-col mt-16" transition:slide>
			<p class="text-center text-3xl md:text-5xl">
				<span class="">Mint your STRAND</span>
			</p>

			<!-- <p class="text-md mt-6 px-4 text-center md:px-12">
				{numBasePairs > 4
					? 'Your STRAND is long, which is great! But make sure to scroll down to see it all'
					: 'Scroll down to see the rest of your STRAND'}
			</p> -->

			<!-- prettier-ignore -->
			<div class="flex flex-col items-center mb-12 pt-12 border-phosgreen border-2 p-4 rounded-xl mx-4 sm:mx-auto mt-12">

                {#if longestDNAStrand.length > 0}
                    {#each dnaIterator as _, i}
                <div class="text-phosgreen font-extrabold text-md">
                    <pre>
'-.'. ,',-'
    _,-'"
,-',' '.'-.
'-.'. ,',-'
    _,-'"
,-',' '.'-.</pre>
                </div>

                        <div>
                        <p class="break-all text-phosgreen font-medium  text-md">A: {$strandA[i] ? getNFTIdentifier($strandA[i].publicLinkedType.type.type.typeID, $strandA[i].nftID) : "(strand A DNA here)"}</p>
                        <p class="break-all text-phosgreen font-medium  text-md">B: {$strandB[i] ? getNFTIdentifier($strandB[i].publicLinkedType.type.type.typeID, $strandB[i].nftID) : "(strand B DNA here)"}</p>
                        </div>
                <div class="text-phosgreen font-extrabold text-md">
                    <pre>
'-.'. ,',-'
    _,-'"
,-',' '.'-.
'-.'. ,',-'
    _,-'"
,-',' '.'-.</pre>
                </div>
                    {/each}
                {/if}
                <div class="pt-4 font-medium text-pink-500">
                    <p>STRANDS DNA by {$user?.addr}</p>
                    <p>contains {numBasePairs} base pairs</p>
                    <p>{`from ${numUniqueNFTProjectsInDNA} Flow NFT project${numUniqueNFTProjectsInDNA > 1 ? "s" : ""}.`}</p>
                </div>
            </div>

			<!-- TODO: make a script that pulls mint price from on-chain and displays in UI and uses here -->
            <div class="mx-auto w-48 justify-center flex flex-col">
                <Button
                    buttonText="Mint"
                    onClick={() => {
                        buySTRAND('10.0');
                    }}
                />
            </div>
			<BuyTxStatus />

            {#if $buyTxStatus !== null}
                {#if $buyTxStatus.status === 4 && $buyTxStatus.statusCode === 0}
                    <div class="flex flex-col">
                        <div class="flex flex-col items-center justify-center">
                            <p class="text-md my-6 px-4 text-start text-phosgreen md:px-12">
                                Instead of a slick 3D animation of a pack opening and fire spewing out or something
                                like that, we etched the following double helix of DNA onto your transaction code that
                                minted your NFT. We also added real (but not really) DNA strands to the metadata of
                                your NFT.
                            </p>
                        </div>

                        {#if $user?.addr}
                            <div class="my-6 mx-auto flex gap-3">
                                <a
                                    href={`https://testnet.flowscan.org/transaction/${$buyTxID}/script`}
                                    target="_blank"
                                    rel="noreferrer"
                                    class="text-xl font-normal text-phosgreen underline"
                                >
                                    Transaction on Flowscan
                                </a>
                                <a
                                    href={`https://testnet.flowview.app/account/${$user.addr}/collection/strandsCollection`}
                                    target="_blank"
                                    rel="noreferrer"
                                    class="text-xl font-normal text-phosgreen underline"
                                >
                                    Collection on Flowview
                                </a>
                            </div>
                        {/if}
                    </div>
                {/if}
            {/if}
		</div>
	{/if}
</Container>

<SeparatorStrand />
<Container>
	<p id="scroll-to-about" class="text-center text-3xl md:text-5xl">
		<span class="bg-gradient-to-b from-phosgreen to-white bg-clip-text text-transparent"
			>About / FAQ</span
		>
	</p>
	<About />
</Container>
