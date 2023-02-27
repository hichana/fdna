<script lang="ts">
	import '../app.css';
	import { user } from '#lib/stores';
	import { unauthenticate, logIn } from '#lib/actions';
	import Button from '#components/Button.svelte';
</script>

<nav class="px-2 sm:px-4 py-2.5 fixed w-full z-20 top-0 left-0 bg-black">
	<div class="container flex items-center justify-between mx-auto">
		<a href="https://strands.so/" class="flex items-center">
			<span class="font-semibold text-xl tracking-tight">STRANDS 三</span>
		</a>
		<div class="flex">
			{#if $user}
				{#if $user?.loggedIn}
                    <Button
                        buttonText="Log out"
                        onClick={unauthenticate}
                    />
				{:else}
                    <Button
                        buttonText="Log In/Sign Up"
                        onClick={logIn}
                    />
				{/if}
			{:else}
				<p>Loading login status##########################3</p>
			{/if}
		</div>
	</div>
</nav>

<main class="pt-28">
	<slot />
</main>
