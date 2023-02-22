<script>
	import '../app.css';
</script>

<nav class="bg-gray-800">
    <button
        type="button"
        class=" bg-gray-800 p-1 text-orange-500 hover:text-white focus:outline-none"
    >
        Sign up / Login
    </button>
</nav>

<main>
    <div class="container mx-auto md:pt-28">
        <div class="border-8  border-dashed border-pink-500 ">
            <slot />
        </div>
    </div>
</main>
