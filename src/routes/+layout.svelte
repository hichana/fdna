<script lang="ts">
	import '../app.css';
	import { user } from '#lib/stores';
	import { unauthenticate, logIn } from '#lib/actions';
</script>

<nav class="px-2 sm:px-4 py-2.5 fixed w-full z-20 top-0 left-0 bg-black">
	<div class="container flex items-center justify-between mx-auto">
		<a href="https://strands.so/" class="flex items-center">
			<span class="font-semibold text-xl tracking-tight">STRANDS 三</span>
		</a>
		<div class="flex">
			{#if $user}
				{#if $user?.loggedIn}
					<button
						type="button"
						on:click={unauthenticate}
						class=" bg-slate-600 bg-opacity-30 border-white border-2 hover:bg-opacity-50 focus:ring-4 focus:outline-none focus:ring-pink-400 font-extralight rounded-sm text-sm px-5 py-1.5 text-center mr-3 md:mr-0"
					>
						<span class="sr-only">Log out</span>
						Log out
					</button>
				{:else}
					<button
						type="button"
						on:click={logIn}
						class=" bg-slate-600 bg-opacity-30 border-white border-2 hover:bg-opacity-50 focus:ring-4 focus:outline-none focus:ring-pink-400 font-extralight rounded-sm text-sm px-5 py-1.5 text-center mr-3 md:mr-0"
					>
						<span class="sr-only">Log In/Sign Up</span>
						Log In/Sign Up</button
					>
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
