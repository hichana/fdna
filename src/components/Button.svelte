<script lang="ts">
	export let onClick: () => void;
	export let buttonText: string;
</script>

<button
	type="button"
	on:click={onClick}
	class=" mr-3 rounded-full border-2 border-phosgreen bg-slate-600 bg-opacity-30 px-5 py-1.5 text-center text-sm font-extralight text-phosgreen hover:bg-opacity-50 focus:outline-none focus:ring-4 focus:ring-pink-500 md:mr-0"
>
	<span class="sr-only">{buttonText}</span>
	{buttonText}
</button>
