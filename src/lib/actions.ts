import * as fcl from '@onflow/fcl';
import { configureFCL } from './config';
import { browser } from '$app/environment';
import { get } from 'svelte/store';
import { user, strandA, strandB } from './stores';
import { constructNFTCollectionCode, replaceCDCImports } from './helpers';
import GET_NFT_IDS_IN_ACCOUNT from '#queries/NFTCatalog/get_nft_ids_in_account.cdc?raw';
import GET_NFTS_IN_ACCOUNT_FROM_IDS from '#queries/NFTCatalog/get_nfts_in_account_from_ids.cdc?raw';
import GET_STRAND_REGISTRY_TIMESTAMP from '#queries/STRANDS/get_strand_registry_timestamp.cdc?raw';
import MINT_NFT_INTERPOLATE from '#mutations/STRANDS/mint_nft_interpolate.cdc?raw';

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

export const getStrandRegistryTimestamp = async (strand: string) => {
	const scriptCode = replaceCDCImports(GET_STRAND_REGISTRY_TIMESTAMP);

	try {
		const getStrandRegistryTimestampResult = await fcl.query({
			cadence: scriptCode,
			args: (arg: any, t: any) => [arg(strand, t.String)]
		});
		return getStrandRegistryTimestampResult;
	} catch (e) {
		const errorMsg = (e as Error).message;
		console.log('Error when fetching stand registry timestamp:', errorMsg);
	}
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
	const getUserNFTsScriptCode = replaceCDCImports(GET_NFTS_IN_ACCOUNT_FROM_IDS);

	try {
		const CHUNK = 25;
		const nftIDBatches: number[][] = createNFTIDBatches(nftIDs, CHUNK);
		let nfts: any = {};
		for (const nftIDBatch of nftIDBatches) {
			const currentNFTBatch = await fcl.query({
				cadence: getUserNFTsScriptCode,
				args: (arg: any, t: any) => [
					arg(userAddr, t.Address),
					arg(
						[{ key: collectionName, value: nftIDBatch }],
						t.Dictionary({ key: t.String, value: t.Array(t.UInt64) })
					)
				]
			});
			nfts = {
				...currentNFTBatch,
				...nfts
			};
		}
		console.log('nfts:', nfts);

		return nfts[collectionName];
	} catch (e) {
		const errorMsg = (e as Error).message;
		console.log('Error when fetching user NFT data:', errorMsg);
	}
};

export const buySTRAND = async (mintPrice: string) => {
	const strandANfts = get(strandA);
	const strandBNfts = get(strandB);

	const importStrings: string[] = [];
	const collectionBorrowBlocks: string[] = [];
	const fullyQualifiedIdentifierPairs: string[][] = [];

	strandANfts.forEach((nft: any) => {
		// construct the import string
		const collectionTypeID = nft.publicLinkedType.type.type.typeID;
        const collectionTypeMembers = collectionTypeID.split(".")
        collectionTypeMembers.pop()
        const fullyQualifiedIdentifier = collectionTypeMembers.join(".").concat(`.NFT.${nft.nftID}`);
		fullyQualifiedIdentifierPairs.push([fullyQualifiedIdentifier]);
		const collectionTypeIDParts = collectionTypeID.split('.');
		const importString = `import ${collectionTypeIDParts[2]} from 0x${collectionTypeIDParts[1]}`;

		// if the import string is not already in the array, add it
		!importStrings.includes(importString) && importStrings.push(importString);

		collectionBorrowBlocks.push(
			constructNFTCollectionCode(
				'strandA',
				nft.publicLinkedType.type.typeID,
				nft.storagePath.identifier,
				nft.nftID
			)
		);
	});

	strandBNfts.forEach((nft: any, index: number) => {
		// construct the import string
		const collectionTypeID = nft.publicLinkedType.type.type.typeID;
        const collectionTypeMembers = collectionTypeID.split(".")
        collectionTypeMembers.pop()
        const fullyQualifiedIdentifier = collectionTypeMembers.join(".").concat(`.NFT.${nft.nftID}`);
		fullyQualifiedIdentifierPairs[index].push(fullyQualifiedIdentifier);
		const collectionTypeIDParts = collectionTypeID.split('.');
		const importString = `import ${collectionTypeIDParts[2]} from 0x${collectionTypeIDParts[1]}`;

		// if the import string is not already in the array, add it
		!importStrings.includes(importString) && importStrings.push(importString);

		collectionBorrowBlocks.push(
			constructNFTCollectionCode(
				'strandB',
				nft.publicLinkedType.type.typeID,
				nft.storagePath.identifier,
				nft.nftID
			)
		);
	});

	// prettier-ignore
	const doubleHelixSegments: string[] = [`
//    ##  ###  #       ## ### ##   #  ### ##   ## 
//    # # # # # #     #    #  # # # # # # # # #   
//    # # # # ###      #   #  ##  ### # # # #  #  
//    # # # # # #       #  #  # # # # # # # #   # 
//    ##  # # # #     ##   #  # # # # # # ##  ##  
//
//
//    ##  ###  #       ## ### ##   #  ### ##   ## 
//    # # # # # #     #    #  # # # # # # # # #   
//    # # # # ###      #   #  ##  ### # # # #  #  
//    # # # # # #       #  #  # # # # # # # #   # 
//    ##  # # # #     ##   #  # # # # # # ##  ##  
//
//
//    ##  ###  #       ## ### ##   #  ### ##   ## 
//    # # # # # #     #    #  # # # # # # # # #   
//    # # # # ###      #   #  ##  ### # # # #  #  
//    # # # # # #       #  #  # # # # # # # #   # 
//    ##  # # # #     ##   #  # # # # # # ##  ##  
//
//
    `]

	// prettier-ignore
	fullyQualifiedIdentifierPairs.forEach((pair) => {
        doubleHelixSegments.push(
                `
 //               '-.'. ,',-'
 //                   _,-'"
 //               ,-',' '.'-.
 //               '-.'. ,',-'
 //                   _,-'"
 //               ,-',' '.'-.
 //               '-.'. ,',-'
 //                   _,-'"
 //               ,-',' '.'-.
// A: ${pair[0]}
// B: ${pair[1]}
 //               '-.'. ,',-'
 //                   _,-'"
 //               ,-',' '.'-.
 //               '-.'. ,',-'
 //                   _,-'"
 //               ,-',' '.'-.
 //               '-.'. ,',-'
 //                   _,-'"
 //               ,-',' '.'-.`
        )
    });

	const allDoubleHelixSegments = doubleHelixSegments.map((segment) => `${segment}\n`).join('');
	const doubleHelixInectedTxCode = MINT_NFT_INTERPOLATE.replace(
		/\/\/ <dna>\n/g,
		allDoubleHelixSegments
	);

	const allImportStrings = importStrings.map((block) => `${block}\n`).join('');
	const allCollectionBorrowBlocks = collectionBorrowBlocks.map((block) => `${block}\n`).join('');
	const importsInectedTxCode = doubleHelixInectedTxCode.replace(
		/\/\/ <imports>\n/g,
		allImportStrings
	);
	const collectionBorrowBlocksInectedTxCode = importsInectedTxCode.replace(
		/\/\/ <collections>\n/g,
		allCollectionBorrowBlocks
	);
	const txCode = replaceCDCImports(collectionBorrowBlocksInectedTxCode);

	const transactionId = await fcl.mutate({
		cadence: txCode,
		args: (arg: any, t: any) => [arg(mintPrice, t.UFix64)],
		payer: fcl.authz,
		proposer: fcl.authz,
		authorizations: [fcl.authz]
	});

	fcl
		.tx(transactionId)
		.subscribe(
			(res: { errorMessage: string | null; statusCode: number | null; status: number | null }) => {
				console.log('Buy NFT transaction response:', res);
			}
		);
};
