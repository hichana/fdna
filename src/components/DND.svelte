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
	<div class="flex h-10 items-center py-10">
		<div class="mx-auto rounded-2xl bg-slate-50  bg-opacity-90 px-4 py-1.5">
			<p class="text-center text-lg font-bold text-slate-900">{listName}</p>
		</div>
	</div>
	<section
		class="h-120 w-full flex-auto space-y-2.5 px-4 pb-11"
		use:dndzone={{ items, flipDurationMs }}
		on:consider={handleDndConsider}
		on:finalize={handleDndFinalize}
	>
		{#each items as item (item.id)}
			<div
				class="flex w-full flex-col justify-start space-x-3.5 rounded-2xl border-2 border-pink-400 bg-slate-900 bg-opacity-80 px-5 py-3 sm:flex-row"
				animate:flip={{ duration: flipDurationMs }}
			>
				<img
					class="mb-2 h-10 w-10 self-center rounded-full sm:mb-0 sm:self-start"
					src={`${resolveImgStr(item.thumbnail)}`}
					alt="Rounded avatar"
				/>
				<div class="inline-flex flex-col items-start justify-center space-y-0.5">
					<p class="text-xs font-medium leading-none sm:text-lg ">{item.name}</p>
					<p class="sm:text-md text-xs font-light leading-tight">ID: <span>{item.id}</span></p>
				</div>
			</div>
		{/each}
	</section>
</div>
