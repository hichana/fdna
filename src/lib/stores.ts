import { writable } from 'svelte/store';

export const user = writable<null | any>(null);
// user.subscribe((value) => {
// 	console.log('user store changed', value);
// });

export const strandA = writable<any>([]);
// strandA.subscribe((value) => {
// 	console.log('strandA Store:', value);
// });

export const strandB = writable<any>([]);
// strandB.subscribe((value) => {
// 	console.log('strandB Store:', value);
// });

export const buyTxStatus = writable<any>(null);
// buyTxStatus.subscribe((value) => {
// 	console.log('buyTxStatus Store:', value);
// });

export const buyTxID = writable<string>('');
// buyTxID.subscribe((value) => {
// 	console.log('buyTxID Store:', value);
// });

export const mintPrice = writable<number | null>(null);
// mintPrice.subscribe((value) => {
// 	console.log('mintPrice Store:', value);
// });
