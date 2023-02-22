<script lang="ts">
	import { get } from 'svelte/store';
    import { user } from '#lib/stores';
	import { getUserCollectionsViews } from '#lib/actions';

    let userCollectionsViews: string[][] | null = null;
    $: console.log("userCollectionsViews", userCollectionsViews);

    async function setUserCollectionsViews() {
			const currentUser = get(user);
			if (currentUser !== null) {
                userCollectionsViews = await getUserCollectionsViews(currentUser.addr)
			}
    }

    setUserCollectionsViews();

</script>

<h1 class="text-3xl font-bold underline bg-red-400 ">Hello world!</h1>
