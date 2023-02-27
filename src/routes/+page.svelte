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
	import About from '#components/About.svelte';
	import SeparatorStrand from '#components/SeparatorStrand.svelte';
	import Button from '#components/Button.svelte';
	import ButtonLink from '#components/ButtonLink.svelte';

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

	// check if the strand is ready
	let strandIsReady: boolean = false;
	let numBasePairs: number = 0;
	let numUniqueNFTProjectsInDNA: number = 0;

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
                <p class="text-center text-xl md:text-5xl">
                    <span class="text-transparent bg-gradient-to-b from-phosgreen to-white bg-clip-text">Choose your building blocks</span>
                </p>
				<p class="text-md my-6 px-4 text-start md:px-12">
					Build your STRAND by selecting two or more of your NFTs as the building blocks of your
					digital DNA on Flow:
				</p>
			</div>

			<div class="mx-4 rounded-2xl border-2 border-phosgreen bg-slate-600 bg-opacity-30">
				{#if userNFTIDs}
					{#each Object.entries(userNFTIDs) as [collectionName, nftIDs]}
						<NFTsDetail {collectionName} {nftIDs} />
					{/each}
				{/if}
			</div>
		</div>

		<div>
			<p class="text-center text-xl md:text-5xl">
				<span class="">Sequence your base pairs</span>
			</p>

			<p class="text-md my-6 px-4 text-start md:px-12">
				A strand of digital DNA on Flow is itself made of two strands, 'strandA' and 'strandB'.
				Sequence your base pairs in each strand in any order that is meaningful to you -- the
				makeup, pairing and order may be useful in this, or other future projects on Flow.
			</p>
			<p class="mx-4 my-2 text-sm italic">
				* make sure you're creating
				<span class="font-bold"> base pairs </span>
				(so that strandA has the same number of NFTs as strandB).
			</p>
			<div
				class="mx-4 flex flex-col rounded-sm border-4 border-dashed border-phosgreen bg-slate-900"
			>
				<div
					style="background-image:linear-gradient(rgba(135, 80, 156, 0.9), rgba(135, 80, 156, 0.9)), url(https://upload.wikimedia.org/wikipedia/commons/0/0c/DNA_animation.gif)"
					class="flex bg-cover bg-center"
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
	<p class="text-center text-xl md:text-5xl">
		<span class="text-blue-100">Mint</span>
		<span class="text-purple-100">your</span>
		<span class="text-green-100">STRAND</span>
	</p>

	<p class="text-md my-6 px-4 text-start md:px-12">
		{numBasePairs > 4
			? 'Your STRAND is long, which is great! But make sure to scroll down to see it all'
			: 'Scroll down to see the rest of your STRAND'}
	</p>

	<!-- prettier-ignore -->
	<div class="flex flex-col items-center mb-28 pt-12 border-phosgreen border-2 p-4 rounded-xl mx-auto mt-12">

         {#if longestDNAStrand.length > 0}
            {#each dnaIterator as _, i}
        <div class="text-phosgreen font-extrabold text-md">
            <pre>
`-.`. ,',-'
    _,-'"
,-',' `.`-.
`-.`. ,',-'
    _,-'"
,-',' `.`-.</pre>
        </div>

                <div>
                <p class="break-all text-phosgreen font-medium  text-md">A: {$strandA[i] ? getNFTIdentifier($strandA[i].publicLinkedType.type.type.typeID, $strandA[i].nftID) : "(strand A DNA here)"}</p>
                <p class="break-all text-phosgreen font-medium  text-md">B: {$strandB[i] ? getNFTIdentifier($strandB[i].publicLinkedType.type.type.typeID, $strandB[i].nftID) : "(strand B DNA here)"}</p>
                </div>
        <div class="text-phosgreen font-extrabold text-md">
            <pre>
`-.`. ,',-'
    _,-'"
,-',' `.`-.
`-.`. ,',-'
    _,-'"
,-',' `.`-.</pre>
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
	<button
		class=" max-w-2xl self-center rounded-full border-2 border-phosgreen bg-slate-600 bg-opacity-30 px-5 py-1.5 text-center text-lg font-extrabold text-phosgreen hover:bg-opacity-50 focus:outline-none focus:ring-4 focus:ring-pink-400 md:text-6xl"
		on:click={() => {
			buySTRAND('10.0');
		}}
	>
		Big Mint Button
	</button>
	<BuyTxStatus />

	<div class="flex flex-col items-center justify-center">
		<p class="text-md my-6 px-4 text-start md:px-12">
			Instead of a slick 3D animation of a pack opening and fire spewing out or something like that,
			we etched the following double helix of DNA onto your transaction code that minted your NFT.
			We also added real (but not really) DNA strands to the metadata of your NFT.
		</p>
	</div>

	{#if $user?.addr}
        <div class="my-6 flex gap-3 mx-auto">
            <Button
                buttonText="Transaction on Flowscan"
                buttonLink={`https://testnet.flowview.app/account/${$user.addr}/collection/strandsCollection`}
            />
            <Button
                buttonText="Collection on Flowview"
                buttonLink={`https://testnet.flowview.app/account/${$user.addr}/collection/strandsCollection`}
            />
        </div>
	{/if}
</Container>

<SeparatorStrand />
<Container>
	<div id="scroll-to-about">
		<!-- prettier-ignore -->
		<pre class="leading-3 text-center text-xs">
#  ##   #  # # ###        #    ###  #   # 
# # # # # # # #  #        #     #   # # # #
### ##  # # # #  #       #      ##  ### # #
# # # # # # # #  #      #       #   # #  ##
# # ##   #  ###  #     #        #   # #   #
        </pre>
	</div>
	<About />
	<p class="text-md my-6 px-4 text-start text-pink-300 md:p-0">
		Thanks for reading about STRANDS, now go
		<span class="text-blue-500">
			<!-- svelte-ignore a11y-invalid-attribute -->
			<a on:click|preventDefault={() => scrollTo('#scroll-to-build')} href="#">BUILD!!!</a>
		</span>
	</p>
</Container>
<button
	on:click={() => {
		scrollTo('#scroll-to-build');
	}}
>
	Start Building!
</button>
