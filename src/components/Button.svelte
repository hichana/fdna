<script lang="ts">
	export let onClick: () => void;
	export let buttonText: string;
</script>

<button
	type="button"
	on:click={onClick}
	class=" bg-slate-600 bg-opacity-30 text-phosgreen border-phosgreen border-2 hover:bg-opacity-50 focus:ring-4 focus:outline-none focus:ring-pink-500 font-extralight rounded-full text-sm px-5 py-1.5 text-center mr-3 md:mr-0"
>
	<span class="sr-only">{buttonText}</span>
	{buttonText}
</button>
