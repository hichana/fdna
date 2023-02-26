 <script lang="ts">
	import { blur } from 'svelte/transition';
 </script>

<div class="flex flex-col lg:p-8 container max-w-4xl min-w-xs mx-auto" transition:blur>
    <slot />
</div>
