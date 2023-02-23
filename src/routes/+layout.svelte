<script lang="ts">
	import '../app.css';
	import { user } from '#lib/stores';
	import { unauthenticate, logIn } from '#lib/actions';
</script>

<nav
	class="bg-slate-300 px-2 sm:px-4 py-2.5 fixed w-full z-20 top-0 left-0"
>
	<div class="container flex items-center justify-between mx-auto">
		<a href="https://strands.so/" class="flex items-center">
			<span class="font-semibold text-xl tracking-tight">STRANDS 三</span>
		</a>
		<div class="flex">
			<button
				type="button"
				class="text-black bg-slate-700 bg-opacity-30 border-slate-900 border-2 hover:bg-opacity-50 focus:ring-4 focus:outline-none focus:ring-pink-300 font-medium rounded-full text-sm px-5 py-1.5 text-center mr-3 md:mr-0"
				>Sign Up / Login</button
			>
		</div>
	</div>
</nav>

<main>
	<div class="container mx-auto pt-28">
		<div class="border-8  border-dashed border-pink-500 ">
			<slot />
		</div>
	</div>
</main>
