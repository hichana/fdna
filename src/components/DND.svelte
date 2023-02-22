<script lang="ts">
	import { flip } from 'svelte/animate';
	import { dndzone } from 'svelte-dnd-action';
	import { strandA, strandB } from '#lib/stores';

    export let items: any[];
    export let listName: string;
    const flipDurationMs = 300;

	function handleDndConsider(e: { detail: { items: any[]; }; }) {
		items = e.detail.items;
        if (listName === "strandA") {
            strandA.set(items);
        } else if (listName === "strandB") {
            strandB.set(items);
        }
	}
	function handleDndFinalize(e: { detail: { items: any[]; }; }) {
		items = e.detail.items;
        if (listName === "strandA") {
            strandA.set(items);
        } else if (listName === "strandB") {
            strandB.set(items);
        }
	}
</script>

<style>
	section {
		width: 50%;
		border: 1px solid black;
		overflow: scroll;
		height: 120px;
	}
	div {
		width: 50%;
		padding: 0.2em;
		border: 1px solid blue;
		margin: 0.15em 0;
	}
</style>
<section use:dndzone={{items, flipDurationMs}} on:consider={handleDndConsider} on:finalize={handleDndFinalize}>
	{#each items as item(item.id)}
		<div animate:flip="{{duration: flipDurationMs}}">
			UUID: {item.id}	, Name: {item.name}
		</div>
	{/each}
</section>