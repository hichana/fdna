<script lang="ts">
	import { get } from 'svelte/store';
	import { user, strandA, strandB } from '#lib/stores';
	import { getUserNFTIDs, buySTRAND } from '#lib/actions';
	import Container from '#components/Container.svelte';
	import CTA from '#components/CTA.svelte';
	import type { UserNFTIDs } from '../types';
	import NFTsDetail from '#components/NFTsDetail.svelte';
	import DND from '#components/DND.svelte';

	let userNFTIDs: UserNFTIDs | null = null;
	async function setUserNFTIDs() {
		const currentUser = get(user);
		if (currentUser !== null) {
			userNFTIDs = await getUserNFTIDs(currentUser.addr);
		}
	}

	setUserNFTIDs();

    function getNFTIdentifier(collectionIdentifier: string, nftID: string) {
        const collectionTypeMembers = collectionIdentifier.split(".")
        collectionTypeMembers.pop()
        const fullyQualifiedIdentifier = collectionTypeMembers.join(".").concat(`.NFT.${nftID}`);
        return fullyQualifiedIdentifier
    }

</script>

<!-- <Container>
    <CTA />
</Container> -->

<Container>
	<div class="bg-slate-400 rounded-2xl border-8 border-black">
		{#if userNFTIDs}
			{#each Object.entries(userNFTIDs) as [collectionName, nftIDs]}
				<NFTsDetail {collectionName} {nftIDs} />
			{/each}
		{/if}
	</div>
</Container>

<Container>
	<div class="flex flex-row bg-red-400">
		<DND listName="strandA" items={$strandA} />
		<DND listName="strandB" items={$strandB} />
	</div>
</Container>

<Container>
	<!-- TODO: make a script that pulls mint price from on-chain and displays in UI and uses here -->
	<button
		on:click={() => {
			buySTRAND('10.0');
		}}
		>Buy NFT
	</button>

	{#if $user?.addr}
		<a
			href={`https://testnet.flowview.app/account/${$user.addr}/collection/strandsCollection`}
			target="_blank"
			rel="noreferrer">See your STRANDS collection on Flowview</a
		>
	{/if}
</Container>

<p>
	This is the point you might expect a 3D animation of a pack opening and fire spewing out or
	something like that, but almost everything about STRANDS is on-chain, so what we did was etch the
	following double helix of DNA onto your transaction code that minted your NFT here (make sure you
	save the link), and we also add real (but not really) DNA strands to the metadata of your NFT.
	Check them out here on Flowview. Thanks for minting a STRANDS NFT!!!
</p>

<!-- prettier-ignore -->
<div class="flex-col">
	{#each $strandA as nft, i}
		<div class="flex">
			<pre>
            `-.`. ,',-'
                _,-'"
            ,-',' `.`-.
            `-.`. ,',-'
                _,-'"
            ,-',' `.`-.
A: {getNFTIdentifier(nft.publicLinkedType.type.type.typeID, nft.id)}
B: {$strandB[i] ? getNFTIdentifier($strandB[i].publicLinkedType.type.type.typeID, $strandB[i].id) : "(add DNA here)"}
            `-.`. ,',-'
                _,-'"
            ,-',' `.`-.
            `-.`. ,',-'
                _,-'"
            ,-',' `.`-.</pre>
		</div>
	{/each}
</div>
