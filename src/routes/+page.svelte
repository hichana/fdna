<script lang="ts">
	import { get } from 'svelte/store';
    import { user } from '#lib/stores';
	import { getUserNFTIDs } from '#lib/actions';
	import type { UserNFTIDs } from '../types';
	import NFTsDetail from '#components/NFTsDetail.svelte';

    let userNFTIDs: UserNFTIDs | null = null;
    $: console.log("userNFTIDs:", userNFTIDs)

    async function setUserNFTIDs() {
        const currentUser = get(user);
        if (currentUser !== null) {
            userNFTIDs = await getUserNFTIDs(currentUser.addr)
        }
    }

    setUserNFTIDs();

</script>

<div>
    {#if userNFTIDs}
        {#each Object.entries(userNFTIDs) as [collectionName, nftIDs]}
            <NFTsDetail {collectionName} {nftIDs} />
        {/each}
    {/if}
</div>
