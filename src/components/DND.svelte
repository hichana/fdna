<script lang="ts">
	import { flip } from 'svelte/animate';
	import { dndzone } from 'svelte-dnd-action';
	import { strandA, strandB } from '#lib/stores';
	import { resolveImgStr } from '#lib/helpers';

	export let items: any[];
	export let listName: string;
	const flipDurationMs = 300;

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

</script>

<div class="flex flex-col mx-auto w-full">
    <section
        class="w-full h-120 flex-auto space-y-2.5 px-4 py-11"
        use:dndzone={{ items, flipDurationMs }}
        on:consider={handleDndConsider}
        on:finalize={handleDndFinalize}
    >
        {#each items as item (item.id)}
            <div
                class="w-full flex space-x-3.5 justify-start px-5 py-1.5 border-2 border-pink-400 rounded-2xl"
                animate:flip={{ duration: flipDurationMs }}
            >
                <img class="w-10 h-10 rounded-full" src={`${resolveImgStr(item.thumbnail)}`} alt="Rounded avatar" />
                <div class="inline-flex flex-col space-y-0.5 items-start justify-center">
                    <p class="text-sm font-semibold leading-tight">NFT {item.id}</p>
                    <p class="text-xs font-light leading-none">{item.name}</p>
                </div>
            </div>
        {/each}
    </section>
</div>
