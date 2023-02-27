<script lang="ts">
	import Button from './Button.svelte';
    import { scrollTo } from '#lib/helpers';
</script>

<div class="flex flex-col items-center">
	<h1 class="text-center text-5xl md:text-7xl">
		<span class="text-slate-200">On-Chain DNA</span>
	</h1>
	<p
		class="text-md mt-6 max-w-lg bg-gradient-to-b from-white to-phosgreen bg-clip-text px-4 text-center font-normal leading-8 text-transparent md:p-0 md:text-xl md:leading-10"
	>
		NFTs are not just for collecting, they're building blocks to create new experiences on top of
		existing ones. With STRAND, the NFT assets in your Flow wallet are used to craft one-of-a-kind,
		never duplicated, digital on-chain DNA to use across future experiences on Flow.
	</p>
	<div class="my-6 flex gap-3">
		<Button onClick={() => scrollTo('#scroll-to-build')} buttonText={'Start Building!'} />
		<Button onClick={() => scrollTo('#scroll-to-about')} buttonText={'Learn More'} />
	</div>
</div>
