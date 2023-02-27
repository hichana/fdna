<script lang="ts">
	import { slide } from 'svelte/transition';
</script>

<div class="flex flex-col container max-w-4xl min-w-xs mx-auto" transition:slide>
	<slot />
</div>
