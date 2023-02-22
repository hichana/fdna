import * as fcl from '@onflow/fcl';
import { configureFCL } from './config';
import { browser } from '$app/environment';
import { user } from './stores';
import { replaceCDCImports } from './helpers';
import GET_NFT_IDS_IN_ACCOUNT from '#queries/NFTCatalog/get_nft_ids_in_account.cdc?raw';
import GET_NFTS_IN_ACCOUNT_FROM_IDS from '#queries/NFTCatalog/get_nfts_in_account_from_ids.cdc?raw';

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

function createNFTIDBatches(array: number[], batchSize: number): number[][] {
    // Determine the number of batches needed to hold the entire array, based on the specified batch size.
    const numBatches = Math.ceil(array.length / batchSize);

    // Split the array into batches of the specified size.
    const batches = Array.from({ length: numBatches }, (_, i) => {
        const start = i * batchSize;
        const end = start + batchSize;
        return array.slice(start, end);
    });

    return batches;
}

export const getUserNFTs = async (userAddr: string, collectionName: string, nftIDs: number[]) => {
    
    const getUserNFTsScriptCode = replaceCDCImports(GET_NFTS_IN_ACCOUNT_FROM_IDS)

    try {
        const CHUNK = 25
        const nftIDBatches: number[][] = createNFTIDBatches(nftIDs, CHUNK)
        let nfts: any = {};
        for (const nftIDBatch of nftIDBatches) {
            const currentNFTBatch = await fcl.query({
                cadence: getUserNFTsScriptCode,
                args: (arg: any, t: any) => [
                    arg(userAddr, t.Address),
                    arg([
                        {key: collectionName, value: nftIDBatch}
                    ], 
                    t.Dictionary({key: t.String, value: t.Array(t.UInt64)})
                    )
                ]
            })
            nfts = {
            ...currentNFTBatch,
            ...nfts
            }
        }
        console.log("nfts:", nfts);
        
        return nfts[collectionName]
    } catch (e) {
		const errorMsg = (e as Error).message;
		console.log('Error when fetching user NFT data:', errorMsg);
    }
}

