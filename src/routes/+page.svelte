<script lang="ts">
	import { get } from 'svelte/store';
    import { user } from '#lib/stores';
	import { getUserCollectionsViews, getUserNFTIDs } from '#lib/actions';
	import type { UserNFTIDs } from '../types';

    let userNFTIDs: UserNFTIDs | null = null;
    $: console.log("userNFTIDs:", userNFTIDs)

    async function setUserNFTIDs() {
        const currentUser = get(user);
        if (currentUser !== null) {
            userNFTIDs = await getUserNFTIDs(currentUser.addr)
        }
    }

    setUserNFTIDs();


    // TODO: remove probably don't need this data after all. Need user collection ids instead
    // remove this, the script
    // let userCollectionsViews: string[][] | null = null;
    // $: console.log("userCollectionsViews", userCollectionsViews);

    // async function setUserCollectionsViews() {
	// 		const currentUser = get(user);
	// 		if (currentUser !== null) {
    //             userCollectionsViews = await getUserCollectionsViews(currentUser.addr)
	// 		}
    // }

    // setUserCollectionsViews();


</script>

<h1 class="text-3xl font-bold underline bg-red-400 ">Hello world!</h1>
