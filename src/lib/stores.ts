import { writable } from 'svelte/store';

export const user = writable<null | any>(null);
user.subscribe((value) => {
    console.log('user store changed', value);
})

export const selectedNFTs = writable<any>({});
selectedNFTs.subscribe((value) => {
    console.log('selectedNFTs store changed', value);
})
