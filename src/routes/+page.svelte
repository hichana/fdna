<script lang="ts">
	import { get } from 'svelte/store';
    import { user } from '#lib/stores';
	import { getUserNFTIDs } from '#lib/actions';
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

</script>

<h1 class="text-3xl font-bold underline bg-red-400 ">Hello world!</h1>
