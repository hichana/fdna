export function replaceCDCImports(str: string): string {
	const importsToAliases: { [key: string]: string } = {
        '"../../contracts/core/MetadataViews.cdc"': "0xMetadataViews",
		'"../../contracts/core/NFTCatalog.cdc"': '0xNFTCatalog',
		'"../../contracts/core/NFTRetrieval.cdc"': '0xNFTRetrieval'
	};

	Object.keys(importsToAliases).forEach((key) => {
		const importToReplace = importsToAliases[key];
		str = str.replaceAll(key, importToReplace);
	});

	return str;
}
