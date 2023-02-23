<script lang="ts">
	import '../app.css';
	import { user } from '#lib/stores';
	import { unauthenticate, logIn } from '#lib/actions';
</script>

<nav class="flex items-center justify-between flex-wrap bg-teal-500 p-6">
  <div class="flex items-center flex-shrink-0 text-white mr-6">
    <span class="font-semibold text-xl tracking-tight">STRANDS 三</span>
  </div>
  <div class="w-full block flex-grow lg:flex lg:items-center lg:w-auto">
    <div>
        {#if $user}
            {#if $user?.loggedIn}
                <button
                    on:click={unauthenticate}
                    type="button"
                >
                    <span class="sr-only">Log out</span>
                    Log out
                </button>
            {:else}
                <button
                    on:click={logIn}
                    type="button"
                >
                    <span class="sr-only">Log In/Sign Up</span>
                    Log in/Sign up
                </button>
            {/if}
        {:else}
            <p>Loading login status##########################3</p>
        {/if}
    </div>
  </div>
</nav>

<main>
    <div class="container mx-auto md:pt-28">
        <div class="border-8  border-dashed border-pink-500 ">
            <slot />
        </div>
    </div>
</main>
