<script lang="ts">
	import FaqDetail from './FAQDetail.svelte';
	import { faq } from '#lib/appData';
	import { scrollTo } from '#lib/helpers';
</script>

<div class="mx-5 flex flex-col  gap-14 pt-12">
	<p class="text-md leading-8 sm:text-lg">
		<span class="mr-1 text-4xl font-normal text-phosgreen">NFT: </span>
		STRANDS is meant to promote the ownership of many and varied NFTs on Flow. We believe many great
		experiences and brands will come about if we find ways to encourage more composability of NFTs from
		many different projects. To create a STRANDS NFT, you’ll need to own two or more Flow NFTs. There
		are a lot of awesome ones out there from great marketplaces. If you need to grab a few before minting
		your STRAND, checkout
		<a
			href="https://www.flowverse.co/flow-nfts"
			target="_blank"
			rel="noreferrer"
			class="text-blue-700"
		>
			<span class="text-xl font-semibold">Flowverse </span>
		</a>
		to see a list of great NFTs on Flow.
	</p>
	<p class="text-md leading-8 sm:text-lg">
		<span class="mr-1 text-4xl font-normal text-phosgreen">FAQ: </span>
		STRAND DNA, like real DNA, can be totally unique to us, to who we are, to our identity. To be a part
		of this experience, you should first learn more:
	</p>
	<div class="rounded-2xl bg-slate-700 bg-opacity-50 p-4">
		{#each faq as faqPair}
			<FaqDetail {faqPair} />
		{/each}
	</div>
	<button
		on:click={() => {
			scrollTo('#scroll-to-build');
		}}
		class="text-xl"
	>
		Thanks for reading about STRANDS. Click
		<span class="text-phosgreen">HERE</span>
		to start Building!!!
	</button>
</div>
