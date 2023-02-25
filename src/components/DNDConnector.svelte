<script lang="ts">
	import { strandA, strandB } from '#lib/stores';

	let longestDNAStrand: any[] = [];
	$: {
		if ($strandA.length > $strandB.length) {
			longestDNAStrand = $strandA;
		} else {
			longestDNAStrand = $strandB;
		}
	}

	$: dnaIterator = Array.from({ length: longestDNAStrand.length }, (_, i) => i);
</script>

<!-- LAYOUT FOR THIS COMPONENT SHOULD BE SAME AS DND TO TAKE UP SAME SPACE -->
<div class="flex flex-col mx-auto bg-yellow-300 bg-opacity-30">
	<section class="flex flex-col flex-auto space-y-2.5 py-11">
		{#each dnaIterator as _}
			<div class="flex flex-auto space-x-3.5 px-2 sm:px-5 py-1.5 items-center justify-center">
				<div class="">
					<p class="sm:text-2xl">-</p>
				</div>
			</div>
		{/each}
	</section>
</div>
