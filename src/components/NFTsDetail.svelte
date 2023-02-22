<script lang="ts">
	import { get } from 'svelte/store';
	import { slide } from 'svelte/transition';
    import { user, selectedNFTs } from '#lib/stores';

    import { getUserNFTs } from '#lib/actions';

	export let collectionName: string;
    $: console.log("collectionName:", collectionName)
	export let nftIDs: number[];

	let filterIsOpen = false;

    let userNFTs: any[];
    $: console.log("userNFTs:", userNFTs)
    
	async function handleHoverTouch() {
		if (!filterIsOpen && !userNFTs) {
			const currentUser = get(user);
			if (currentUser !== null) {
                userNFTs = await getUserNFTs(currentUser.addr, collectionName, nftIDs)
                selectedNFTs.update((prevSelectedNFTs) => ({
                    ...prevSelectedNFTs,
                    [collectionName]: []
                }))
            }
        }
    }

    $: console.log("userNFTs:", userNFTs);
</script>

<div class="border-b border-gray-200 bg-yellow-200 p-6">
	<h3 class="-my-3 flow-root">
		<button
			on:click={() => (filterIsOpen = !filterIsOpen)}
			on:touchstart={handleHoverTouch}
			on:mouseenter={handleHoverTouch}
			type="button"
			class="flex w-full items-center justify-between bg-white py-3 text-sm text-gray-400 hover:text-gray-500"
		>
			<span class="font-medium text-gray-900">{collectionName}</span>
			<span class="ml-6 flex items-center">
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
	</h3>

	{#if filterIsOpen}
		<div class="pt-6" transition:slide>
			<div class="space-y-4">
				{#each userNFTs as nft}
					<div class="flex items-center">
						<input
							id={nft.id}
							type="checkbox"
                            bind:group={$selectedNFTs[collectionName]}
							value={nft}
							class="h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-500"
						/>
						<label for={nft.id} class="ml-3 text-sm text-gray-600">UUID: {nft.id}, NFT ID: {nft.nftID}, name: {nft.name}</label>
					</div>
				{/each}
			</div>
		</div>
	{/if}
</div>
