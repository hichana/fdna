<script lang="ts">
	import { getStrandRegistryTimestamp } from '#lib/actions';

	import { strandA, strandB } from '#lib/stores';

    export let listName: string;

    let strandClaimedCheck: undefined | null | string

    async function setStrandClaimedCheck(nfts: any[]) {

        const fullyQualifiedIdentifiers: string[] = [];

        nfts.forEach((nft: any) => {

            // construct the NFT identifier string
            const collectionTypeID = nft.publicLinkedType.type.type.typeID;
            const collectionTypeMembers = collectionTypeID.split(".")
            collectionTypeMembers.pop()
            const fullyQualifiedIdentifier = collectionTypeMembers.join(".").concat(`.NFT.${nft.nftID}`);
            
            fullyQualifiedIdentifiers.push(fullyQualifiedIdentifier);
        })

        const strand: string = fullyQualifiedIdentifiers.join(",")

        strandClaimedCheck = await getStrandRegistryTimestamp(strand)
    }

    $: {
		if (listName === 'strandA') {
            $strandA.length > 0 && setStrandClaimedCheck($strandA)
            $strandA.length === 0 && (strandClaimedCheck = undefined)
		} else if (listName === 'strandB') {
            $strandB.length > 0 && setStrandClaimedCheck($strandB)
            $strandB.length === 0 && (strandClaimedCheck = undefined)
		}
    }

</script>


{#if strandClaimedCheck !== undefined}
    {#if strandClaimedCheck === null}
        <p>{listName} is unique!</p>
    {:else}
        <p>{listName}, this sequence of DNA has already been claimed :(</p>
    {/if}
{/if}
