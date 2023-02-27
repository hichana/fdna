<script lang="ts">
	import '../app.css';
	import { user } from '#lib/stores';
	import { unauthenticate, logIn } from '#lib/actions';
	import Button from '#components/Button.svelte';
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
