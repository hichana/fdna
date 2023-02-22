import { writable } from 'svelte/store';

export const user = writable<null | any>(null);
user.subscribe((value) => {
    console.log('user store changed', value);
})