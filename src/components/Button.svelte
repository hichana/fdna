<script lang="ts">
	export let onClick: () => void = () => {};
	export let buttonText: string = '';
	export let buttonLink: string = '';
</script>

<button
	type="button"
	on:click={onClick}
	class="rounded-full border-2 border-phosgreen bg-slate-600 bg-opacity-30 px-5 py-1.5 text-center text-sm md:text-lg font-extralight text-phosgreen hover:bg-opacity-50 focus:outline-none focus:ring-4 focus:ring-pink-500 mx-1"
>
	{#if buttonLink}
		<span class="sr-only">{buttonText}</span>
		<a href={buttonLink} target="_blank" rel="noreferrer">{buttonText}</a>
	{:else}
		<span class="sr-only">{buttonText}</span>
		{buttonText}
	{/if}
</button>
