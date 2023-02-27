<script lang="ts">
	import Button from "./Button.svelte";


	function scrollTo(selector: string) {
        // solution modified from SO: https://stackoverflow.com/questions/49820013/javascript-scrollintoview-smooth-scroll-and-offset
		const element = document.querySelector(selector);
        const offset = 145;
        const bodyRect = document.body.getBoundingClientRect().top;
        if (element !== null) {
            const elementRect = element.getBoundingClientRect().top;
            const elementPosition = elementRect - bodyRect;
            const offsetPosition = elementPosition - offset;

            window.scrollTo({
                top: offsetPosition,
                behavior: 'smooth'
            });

        }
	}

</script>

<div class="flex flex-col items-center">
	<!-- <h1 class="text-5xl md:text-7xl text-center">
        <span class="text-blue-100">Digital</span>
        <span class="text-purple-100">DNA</span>
        <span class="text-pink-100">on</span>
        <span class="text-green-400">Flow</span>
    </h1> -->
	<h1 class="text-5xl md:text-7xl text-center">
        <span class="text-slate-200">On-Chain</span>
        <span class="text-green-400">Flow DNA</span>
    </h1>

	<p class="text-md md:text-xl leading-8 md:leading-10 text-center mt-6 max-w-lg  px-4 md:p-0">
		NFTs are not just for collecting, they're building blocks to create new experiences on top of
		existing ones. With STRAND, the NFT assets in your Flow wallet are used to craft one-of-a-kind, never
		duplicated, digital on-chain DNA to use across future experiences on Flow.
	</p>
	<!-- <p class="text-md md:text-xl leading-8 md:leading-10 text-center mt-6 max-w-lg  px-4 md:p-0">
		NFTs are not just for collecting, they're building blocks to create new experiences on top of
		existing ones. With STRAND, the NFT assets in your wallet are used to craft one-of-a-kind, never
		duplicated, digital on-chain DNA to use across future experiences on Flow.
	</p> -->

    <div class="flex gap-3 my-6">
        <Button
            onClick={() => scrollTo('#scroll-to-build')}
            buttonText={'Start Building!'}
        />
        <Button
            onClick={() => scrollTo('#scroll-to-about')}
            buttonText={'Learn More'}
        />
    </div>

</div>
