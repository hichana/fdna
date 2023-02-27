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

<div class="mx-auto flex w-full flex-col">
	<div class="flex h-10 items-center py-6 sm:py-10">
		<p class="mx-auto text-center font-bold">{listName}</p>
	</div>
	<section
		class="h-120 w-full flex-auto space-y-2.5 px-4 pb-11"
		use:dndzone={{ items, flipDurationMs }}
		on:consider={handleDndConsider}
		on:finalize={handleDndFinalize}
	>
		{#each items as item (item.id)}
			<div
				class="flex w-full justify-start space-x-3.5 rounded-2xl border-2 border-pink-400 px-5 py-1.5 bg-slate-900 bg-opacity-80"
				animate:flip={{ duration: flipDurationMs }}
			>
				<img
					class="h-10 w-10 rounded-full"
					src={`${resolveImgStr(item.thumbnail)}`}
					alt="Rounded avatar"
				/>
				<div class="inline-flex flex-col items-start justify-center space-y-0.5">
					<p class="text-sm font-semibold leading-tight">NFT {item.id}</p>
					<p class="text-xs font-light leading-none">{item.name}</p>
				</div>
			</div>
		{/each}
	</section>
</div>
