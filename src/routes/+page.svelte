<script lang="ts">
	import { get } from 'svelte/store';
	import { user, strandA, strandB } from '#lib/stores';
	import { getUserNFTIDs, buySTRAND } from '#lib/actions';
    import Container from '#components/Container.svelte';
    import CTA from '#components/CTA.svelte';
	import type { UserNFTIDs } from '../types';
	import NFTsDetail from '#components/NFTsDetail.svelte';
	import DND from '#components/DND.svelte';

	let userNFTIDs: UserNFTIDs | null = null;
	async function setUserNFTIDs() {
		const currentUser = get(user);
		if (currentUser !== null) {
			userNFTIDs = await getUserNFTIDs(currentUser.addr);
		}
	}

	setUserNFTIDs();
</script>

<Container>
    <CTA />
</Container>

<Container>
    <div>
        {#if userNFTIDs}
            {#each Object.entries(userNFTIDs) as [collectionName, nftIDs]}
                <NFTsDetail {collectionName} {nftIDs} />
            {/each}
        {/if}
    </div>
</Container>

<Container>
    <div class="flex flex-row bg-red-400">
        <DND listName="strandA" items={$strandA} />
        <DND listName="strandB" items={$strandB} />
    </div>
</Container>

<Container>
    <!-- TODO: make a script that pulls mint price from on-chain and displays in UI and uses here -->
    <button
        on:click={() => {
            buySTRAND('10.0');
        }}
        >Buy NFT
    </button>

    {#if $user?.addr}
        <a
            href={`https://testnet.flowview.app/account/${$user.addr}/collection/strandsCollection`}
            target="_blank"
            rel="noreferrer">See your STRANDS collection on Flowview</a
        >
    {/if}
</Container>
