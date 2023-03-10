<script lang="ts">
	import { user, strandA, strandB, buyTxStatus, buyTxID, mintPrice } from '#lib/stores';
	import { slide } from 'svelte/transition';
	import { getUserNFTIDs, buySTRAND, logIn, getStrandMintPrice } from '#lib/actions';
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

    async function setMintPrice() {
        const mintPriceResult = await getStrandMintPrice();
        mintPrice.set(mintPriceResult)
    }
    setMintPrice()

	async function setUserNFTIDs(currentUser: { addr: string }) {
		userNFTIDs = await getUserNFTIDs(currentUser?.addr);
		userNFTIDs &&
			Object.values(userNFTIDs).forEach((nftIDs) => {
				if (nftIDs.length > 1) {
					userHasAtLeastTwoNFTs = true;
				}
			});
	}

	user.subscribe((userState) => {
		if (userState !== null) {
			setUserNFTIDs(userState);
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
					on-chain DNA on Flow:
				</p>
			</div>
			{#if $user?.addr}
				{#if userNFTIDs && userHasAtLeastTwoNFTs === true}
					{#each Object.entries(userNFTIDs) as [collectionName, nftIDs]}
						<div class="mx-4 rounded-2xl border-2 border-phosgreen bg-slate-600 bg-opacity-30">
							<NFTsDetail {collectionName} {nftIDs} />
						</div>
					{/each}
				{:else if userNFTIDs && userHasAtLeastTwoNFTs === false}
					<div class="mx-4 rounded-2xl border-2 border-phosgreen bg-slate-600 bg-opacity-30">
						<div class="flex flex-col items-center gap-8 p-10">
							<p class="">
								Flow Noooo!!! Looks like you don't two or more NFTs that are from smart contracts
								registered to the
								<span>
									<a
										class=" text-center font-normal text-blue-400 underline"
										href="https://www.flow-nft-catalog.com/"
										target="_blank"
										rel="noreferrer">Flow NFT Catalog</a
									></span
								>
								. Since this app is on testnet for now, you can easily go to MonsterMaker and get some!
							</p>
							<a
								class=" text-center font-normal text-blue-400 underline"
								href="https://monster-maker-web-client.vercel.app/view"
								target="_blank"
								rel="noreferrer">Monster Maker</a
							>
						</div>
					</div>
				{/if}
			{:else}
				<div class="mx-4 rounded-2xl border-2 border-phosgreen bg-slate-600 bg-opacity-30">
					<div class="flex flex-col items-center gap-8 p-10">
						<p class="">Log In/Sign Up to get started building your STRAND</p>
						<Button buttonText="Log In/Sign Up" onClick={logIn} />
					</div>
				</div>
			{/if}
		</div>

		<div>
			<p class="text-center text-3xl md:text-5xl">
				<span class="">Sequence your base pairs</span>
			</p>

			<p class="text-md my-6 px-4 text-start md:px-12">
				A strand of digital DNA on Flow is itself made of two strands, 'strandA' and 'strandB'. Drag
				the cards below to sequence your base pairs in each strand in any order that is meaningful
				to you -- the makeup, pairing and order may be useful in this, or other future projects on
				Flow.
			</p>
			<p class="mx-4 my-2 text-sm italic">
				* make sure you're creating
				<span class="font-bold"> base pairs </span>
				(so that strandA has the same number of NFTs as strandB).
			</p>
			<div class="flex gap-0">
				<div class="flex w-full flex-col sm:mx-4">
					<div
						style="background-image:linear-gradient(rgba(0, 200, 0, 0.4), rgba(0, 200, 0, 0.4)), url(https://upload.wikimedia.org/wikipedia/commons/0/0c/DNA_animation.gif)"
						class="ml-4 flex rounded-l-lg bg-cover bg-center sm:ml-0 sm:rounded-lg"
					>
						{#if nftsAreSelected}
							<DND listName="strandA" items={$strandA} />
							<DND listName="strandB" items={$strandB} />
						{:else}
							<div class="mx-auto flex h-36 items-center sm:h-96">
								<p class="text-md font-normal sm:text-3xl">
									(Select NFTs above to start sequencing)
								</p>
							</div>
						{/if}
					</div>
				</div>
				<div class="mr-4 flex items-center rounded-r-lg bg-slate-500 px-1 sm:hidden">
					<p class="font-semibold text-slate-400">???</p>
				</div>
			</div>
			<div class="flex">
				<DndNotifications listName="strandA" />
				<DndNotifications listName="strandB" />
			</div>
		</div>
	</div>

	{#if numBasePairs > 0}
		<div class="mt-16 flex flex-col" transition:slide>
			<p class="text-center text-3xl md:text-5xl">
				<span class="">Mint your STRAND</span>
			</p>

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
			<div class="mx-auto flex w-48 flex-col justify-center">
				<Button
					buttonText={`Mint STRAND for ${$mintPrice?.toString().slice(0,2)} FLOW`}
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
							<p class="text-md my-6 max-w-3xl px-4 text-start text-phosgreen md:px-12">
								Instead of a slick 3D animation of a pack opening and fire spewing out or something
								like that, we etched the the above double helix of DNA onto your transaction code
								that minted your NFT. We also added your DNA strands to the metadata of your NFT. In
								Flowview you can click on one of your NFTs to see its metadata.
							</p>
						</div>

						{#if $user?.addr}
							<div class="my-6 mx-auto flex gap-3 text-center sm:gap-10">
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
