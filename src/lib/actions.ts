import * as fcl from '@onflow/fcl';
import { configureFCL } from './config';
import { browser } from '$app/environment';
import { user } from './stores';
import { replaceCDCImports } from './helpers';
import GET_ALL_NFTS_AND_VIEWS_IN_ACCOUNT from '#queries/NFTCatalog/get_all_nfts_and_views_in_account.cdc?raw';

configureFCL();

if (browser) {
	// set Svelte $user store to currentUser, so other components can access it
	fcl.currentUser.subscribe(user.set, []);
}

// Lifecycle FCL Auth functions
export const unauthenticate = () => {
	fcl.unauthenticate();
};
export const logIn = async () => {
	await fcl.logIn();
};

export const getUserCollectionsViews = async (address: string) => {

    const scriptCode = replaceCDCImports(GET_ALL_NFTS_AND_VIEWS_IN_ACCOUNT);

	try {
		const getAllNftsAndViewsResult = await fcl.query({
			cadence: scriptCode,
			args: (arg: any, t: any) => [arg(address, t.Address)]
		});
		return getAllNftsAndViewsResult;
	} catch (e) {
		const errorMsg = (e as Error).message;
		console.log('Error when fetching all nfts and views data:', errorMsg);
	}
};
