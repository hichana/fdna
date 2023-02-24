<script lang="ts">
	import { get } from 'svelte/store';
	import { slide } from 'svelte/transition';
	import { user, strandA, strandB } from '#lib/stores';
	import { getUserNFTs } from '#lib/actions';

	export let collectionName: string;
	export let nftIDs: number[];

	let filterIsOpen = false;

	let userNFTs: any[];

	async function loadUserNFTs() {
        const currentUser = get(user);
        if (currentUser !== null) {
            userNFTs = await getUserNFTs(currentUser.addr, collectionName, nftIDs);
        }
	}
    loadUserNFTs();

	function handleCheck(event: { target: any }) {
		const { target } = event;
		const { value } = target;
		const userNFT = userNFTs.find((nft) => nft.id === value);

		if (target.checked) {
			strandA.update((prev) => {
				return [...prev, userNFT];
			});
		} else {
			strandA.update((prev) => [...prev.filter((nft: { id: string }) => nft.id !== userNFT.id)]);
			strandB.update((prev) => [...prev.filter((nft: { id: string }) => nft.id !== userNFT.id)]);
		}
	}
</script>

<div class="mx-2 my-3 border-2 border-pink-400 rounded-xl">
	<button
		on:click={() => (filterIsOpen = !filterIsOpen)}
		type="button"
		class="p-2 flex w-full items-center justify-between py-3 text-sm"
	>
		<span class="font-medium">{collectionName}</span>
		<span class="flex items-center">
			{#if filterIsOpen}
				<svg
					class="h-5 w-5"
					xmlns="http://www.w3.org/2000/svg"
					viewBox="0 0 20 20"
					fill="currentColor"
					aria-hidden="true"
				>
					<path
						fill-rule="evenodd"
						d="M3 10a.75.75 0 01.75-.75h10.5a.75.75 0 010 1.5H3.75A.75.75 0 013 10z"
						clip-rule="evenodd"
					/>
				</svg>
			{:else}
				<svg
					class="h-5 w-5"
					xmlns="http://www.w3.org/2000/svg"
					viewBox="0 0 20 20"
					fill="currentColor"
					aria-hidden="true"
				>
					<path
						d="M10.75 4.75a.75.75 0 00-1.5 0v4.5h-4.5a.75.75 0 000 1.5h4.5v4.5a.75.75 0 001.5 0v-4.5h4.5a.75.75 0 000-1.5h-4.5v-4.5z"
					/>
				</svg>
			{/if}
		</span>
	</button>

	{#if filterIsOpen}
		<div class="border-pink-400 rounded-b-xl" transition:slide>
			<div class="space-y-6 p-6">
				{#each userNFTs as nftData}
					<div class="flex items-center">
						<input
							id={nftData.id}
							type="checkbox"
							on:change={handleCheck}
							bind:value={nftData.id}
							class="h-4 w-4 rounded border-gray-300 mr-4"
						/>
						<img class="w-10 h-10 rounded-full" src={`${nftData.thumbnail}`} alt="Rounded avatar" />
						<label for={nftData.id} class="ml-3 text-sm text-purple-400"
							>UUID: {nftData.id}, NFT ID: {nftData.nftID}, name: {nftData.name}</label
						>
					</div>
				{/each}
			</div>
		</div>
	{/if}
</div>
