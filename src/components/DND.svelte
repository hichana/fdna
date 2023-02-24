<script lang="ts">
	import { flip } from 'svelte/animate';
	import { dndzone } from 'svelte-dnd-action';
	import { strandA, strandB } from '#lib/stores';
	import { getStrandRegistryTimestamp } from '#lib/actions';

	export let items: any[];
	export let listName: string;
    let strandClaimedCheck: undefined | null | string
	const flipDurationMs = 300;

    async function setStrandClaimedCheck(nfts: any[]) {

        const fullyQualifiedIdentifiers: string[] = [];

        nfts.forEach((nft: any) => {

            // construct the NFT identifier string
            const collectionTypeID = nft.publicLinkedType.type.type.typeID;
            const collectionTypeMembers = collectionTypeID.split(".")
            collectionTypeMembers.pop()
            const fullyQualifiedIdentifier = collectionTypeMembers.join(".").concat(`.NFT.${nft.nftID}`);
            
            fullyQualifiedIdentifiers.push(fullyQualifiedIdentifier);
        })

        const strand: string = fullyQualifiedIdentifiers.join(",")

        strandClaimedCheck = await getStrandRegistryTimestamp(strand)
    }

	function handleDndConsider(e: { detail: { items: any[] } }) {
		items = e.detail.items;
		if (listName === 'strandA') {
			strandA.set(items);
		} else if (listName === 'strandB') {
			strandB.set(items);
		}
	}
	function handleDndFinalize(e: { detail: { items: any[] } }) {
		items = e.detail.items;
		if (listName === 'strandA') {
			strandA.set(items);
		} else if (listName === 'strandB') {
			strandB.set(items);
		}
	}

    $: {
		if (listName === 'strandA') {
            $strandA.length > 0 && setStrandClaimedCheck($strandA)
            $strandA.length === 0 && (strandClaimedCheck = undefined)
		} else if (listName === 'strandB') {
            $strandB.length > 0 && setStrandClaimedCheck($strandB)
            $strandB.length === 0 && (strandClaimedCheck = undefined)
		}
    }

</script>

        <!-- class="border-2 rounded-2xl border-phosgreen w-full h-120 inline-flex flex-col space-y-2.5 items-center justify-start px-4 py-11 bg-black bg-opacity-30" -->
        <!-- class="w-full h-120 inline-flex flex-col space-y-2.5 items-center justify-start px-4 py-11 bg-red-200 bg-opacity-30" -->
        <!-- class="w-full h-120 inline-flex flex-col space-y-2.5 px-4 py-11 bg-red-200 bg-opacity-30" -->

<div class="flex flex-col mx-auto w-full">
    {#if strandClaimedCheck !== undefined}
        {#if strandClaimedCheck === null}
            <p>{listName} is unique!</p>
        {:else}
            <p>{listName}, this sequence of DNA has already been claimed :(</p>
        {/if}
    {/if}
    <section
        class="w-full h-120 inline-flex flex-col space-y-2.5 px-4 py-11 bg-red-200 bg-opacity-30"
        use:dndzone={{ items, flipDurationMs }}
        on:consider={handleDndConsider}
        on:finalize={handleDndFinalize}
    >
        {#each items as item (item.id)}
            <div
                class="w-full inline-flex space-x-3.5 justify-start px-5 py-1.5 border-2 border-pink-400 rounded-2xl"
                animate:flip={{ duration: flipDurationMs }}
            >
                <img class="w-10 h-10 rounded-full" src={`${item.thumbnail}`} alt="Rounded avatar" />
                <div class="inline-flex flex-col space-y-0.5 items-start justify-center">
                    <p class="text-sm font-semibold leading-tight">NFT {item.id}</p>
                    <p class="text-xs font-light leading-none">{item.name}</p>
                </div>
            </div>
        {/each}
    </section>
</div>
