export function resolveImgStr(uri: string) {
	if (uri.slice(0, 4) === 'ipfs') {
		return `https://${uri.split('//')[1]}.ipfs.w3s.link`;
	} else {
		return uri;
	}
}

export function replaceCDCImports(str: string): string {
	const importsToAliases: { [key: string]: string } = {
		'"../../contracts/core/FlowToken.cdc"': '0xFlowToken',
		'"../../contracts/core/MetadataViews.cdc"': '0xMetadataViews',
		'"../../contracts/core/NonFungibleToken.cdc"': '0xNonFungibleToken',
		'"../../contracts/core/NFTCatalog.cdc"': '0xNFTCatalog',
		'"../../contracts/core/NFTRetrieval.cdc"': '0xNFTRetrieval',
		'"../../contracts/STRANDS.cdc"': '0xSTRANDS'
	};

	Object.keys(importsToAliases).forEach((key) => {
		const importToReplace = importsToAliases[key];
		str = str.replaceAll(key, importToReplace);
	});

	return str;
}

export function constructNFTCollectionCode(
	strand: string,
	typeID: string,
	storagePathIdentifier: string,
	nftID: string
) {
	// split the string at the opening curly brace
	const parts = typeID.split('{');

	// extract the first part into a separate variable
	const collectionIdentifierParts = parts[0].split('.');
	const collectionIdentifier = collectionIdentifierParts[2] + '.' + collectionIdentifierParts[3];
	const collectionConstantName =
		collectionIdentifierParts[2].toLowerCase() + collectionIdentifierParts[3];

	// split the second part (the comma-separated items) into an array
	const fullyQualifiedInterfaces = parts[1].split(',');

	// remove 'A.' and the following string between it and the next period from each item
	const transformedInterfaces = fullyQualifiedInterfaces.map((item) =>
		item.replace(/A\.[^.]+./g, '')
	);

	const interfacesList = transformedInterfaces.join(',');

	const qualifiedCollectionConstantName = `${collectionConstantName}${nftID}`;
	const qualifiedNFTConstantName = `${collectionConstantName}NFT${nftID}`;

	let strandRefsMember: string = '';
	if (strand === 'strandA') {
		strandRefsMember = 'strandARefs';
	} else if (strand === 'strandB') {
		strandRefsMember = 'strandBRefs';
	}

	// note, in the collection borrow code below, we purposfully omit the
	// closing curly brace "}" as it is left on the final interface string as a
	// result of the string splitting process

	return `
        let ${qualifiedCollectionConstantName} = signer.borrow<&${collectionIdentifier}{${interfacesList}>(
            from: /storage/${storagePathIdentifier}
        ) ?? panic("Cannot borrow ${collectionIdentifier} collection capability from signer")

        let ${qualifiedNFTConstantName} = ${qualifiedCollectionConstantName}.borrowNFT(id: ${nftID})

        if ${qualifiedNFTConstantName} != nil {
            self.${strandRefsMember}.append(${qualifiedNFTConstantName})
        }
    `;
}

export function scrollTo(selector: string) {
    // solution modified from SO: https://stackoverflow.com/questions/49820013/javascript-scrollintoview-smooth-scroll-and-offset
    const element = document.querySelector(selector);
    const offset = 145;
    const bodyRect = document.body.getBoundingClientRect().top;
    if (element !== null) {
        const elementRect = element.getBoundingClientRect().top;
        const elementPosition = elementRect - bodyRect;
        const offsetPosition = elementPosition - offset;

        window.scrollTo({
            top: offsetPosition,
            behavior: 'smooth'
        });
    }
}
