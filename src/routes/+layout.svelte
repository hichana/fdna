<script lang="ts">
	import '../app.css';
	import { user } from '#lib/stores';
	import { unauthenticate, logIn } from '#lib/actions';
	import Button from '#components/Button.svelte';
	import Hand from '#components/Hand.svelte';
</script>

<nav class="fixed top-0 left-0 z-20 w-full bg-black px-2 py-2.5 sm:px-4">
	<div class="container mx-auto flex items-center justify-between">
		<a href="https://strands.so/" class="flex items-center">
			<span class="text-xl font-semibold tracking-tight">STRANDS 三</span>
		</a>
		<div class="flex">
			{#if $user}
				{#if $user.loggedIn}
					<Button buttonText="Log out" onClick={unauthenticate} />
				{:else}
					<Button buttonText="Log In/Sign Up" onClick={logIn} />
				{/if}
			{/if}
		</div>
	</div>
</nav>

<main class="pt-28">
	<slot />
</main>

<footer
	class="mx-auto mt-28 max-w-7xl rounded-lg bg-slate-700 p-4 shadow md:flex md:items-center md:justify-between md:p-6"
>
	<div class="flex gap-1">
		<Hand />
		<p class="text-sm text-gray-100 sm:text-center ">
			hichana#7569, made as my solo entry in the 2023 Flow Hackathon.
		</p>
	</div>
	<ul class="mt-3 flex flex-wrap items-center pl-5 text-sm text-gray-100 sm:mt-0">
		<li>
			<a
				href="https://discord.gg/AMEBbBHSKJ"
				target="_blank"
				rel="noreferrer"
				class="mr-4 font-normal hover:underline md:mr-6">The FLOASIS/IaNFT Discord</a
			>
		</li>
	</ul>
</footer>
