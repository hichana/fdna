import * as fcl from '@onflow/fcl';
import { configureFCL } from './config';
import { browser } from '$app/environment';
import { user } from './stores';
import { replaceCDCImports } from './helpers';
import GET_NFT_IDS_IN_ACCOUNT from '#queries/NFTCatalog/get_nft_ids_in_account.cdc?raw';

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

export const getUserNFTIDs = async (address: string) => {

    const scriptCode = replaceCDCImports(GET_NFT_IDS_IN_ACCOUNT);

	try {
		const getUserNFTIDsResult = await fcl.query({
			cadence: scriptCode,
			args: (arg: any, t: any) => [arg(address, t.Address)]
		});
		return getUserNFTIDsResult;
	} catch (e) {
		const errorMsg = (e as Error).message;
		console.log('Error when fetching user NFT IDs:', errorMsg);
	}
};

