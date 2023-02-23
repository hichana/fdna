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

	const pairs = [
		['233892348343', '233892348343'],
		['233892348343', '233892348343']
	];
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

<!-- <div class="flex-col">
	{#each pairs as pair}
		<div class="flex">
			<pre>
 `-.`. ,',-'
    _,-'"
 ,-',' `.`-.
({pair[0]}        {pair[1]})
 `-.`. ,',-'
    _,-'"
 ,-',' `.`-.</pre>
		</div>
	{/each}
</div> -->
<div class="flex-col">
	{#each pairs as pair}
		<div class="flex">
			<pre>
A: {pair[0]}
B: {pair[1]}
 `-.`. ,',-'
    _,-'"
 ,-',' `.`-.</pre>
		</div>
	{/each}
</div>
