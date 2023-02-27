<script lang="ts">
	import { slide } from 'svelte/transition';
</script>

<div class="min-w-xs container mx-auto flex max-w-4xl flex-col" transition:slide>
	<slot />
</div>
