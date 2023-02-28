<script lang="ts">
	import { slide } from 'svelte/transition';

	export let faqPair: { q: string; a: string };

	let filterIsOpen = false;
</script>

<div class="p-4 m-3 rounded-xl bg-slate-200 ">
	<h3 class="-my-3 flow-root">
		<button
			on:click={() => (filterIsOpen = !filterIsOpen)}
			type="button"
			class="flex p-2 w-full items-center justify-between text-sm text-gray-400 hover:text-gray-500"
		>
			<span class="italic font-medium text-gray-900 text-start">{faqPair.q}</span>
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
				<div class="flex items-center text-slate-900 font-normal">
					{faqPair.a}
				</div>
			</div>
		</div>
	{/if}
</div>
