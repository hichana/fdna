package main

import (
	o "github.com/bjartek/overflow"
)

func main() {

	flow_network := "emulator"
	// flow_network := "embedded"

	// create the overflow client
	c := o.Overflow(o.WithNetwork(flow_network), o.WithFlowForNewUsers(1000.0))

	// SERVICE ACCOUNT SELF-INITIALIZES FOR DEMO NFTS
	c.Tx(
		"ExampleNFTs/initialize_account_all_demo_nfts",
		o.WithSigner("account")).
		Print()

	// SERVICE ACCOUNT SELF SETS UP WITH ROYALTY RECEIVER
	c.Tx(
		"ExampleNFTs/set_up_royalty_receiver",
		o.WithArg("vaultPath", "/storage/flowTokenVault"),
		o.WithSigner("account")).
		Print()

	// create royalty receiver data
	cuts := []float64{
		0.05}
	royalty_descriptions := []string{
		"Royalty description"}
	royalty_beneficiaries := []string{"account"}

	// SERVICE ACCOUNT MINTS 2 DEMO NFTS FOR EACH DEMO CONTRACT TO SELF
	// Cats
	c.Tx(
		"ExampleNFTs/mint_cats",
		o.WithArg("recipient", "account"),
		o.WithArg("name", "Cats NFT"),
		o.WithArg("description", "Cats are cute but sometimes unpredictable."),
		o.WithArg("thumbnail", "https://cdn.theatlantic.com/thumbor/W544GIT4l3z8SG-FMUoaKpFLaxE=/0x131:2555x1568/1600x900/media/img/mt/2017/06/shutterstock_319985324/original.jpg"),
		o.WithArg("cuts", cuts),
		o.WithArg("royaltyDescriptions", royalty_descriptions),
		o.WithAddresses("royaltyBeneficiaries", royalty_beneficiaries...),
		o.WithSigner("account")).
		Print()
	c.Tx(
		"ExampleNFTs/mint_cats",
		o.WithArg("recipient", "account"),
		o.WithArg("name", "Cats NFT"),
		o.WithArg("description", "Cats are cute but sometimes unpredictable."),
		o.WithArg("thumbnail", "https://cdn.theatlantic.com/thumbor/W544GIT4l3z8SG-FMUoaKpFLaxE=/0x131:2555x1568/1600x900/media/img/mt/2017/06/shutterstock_319985324/original.jpg"),
		o.WithArg("cuts", cuts),
		o.WithArg("royaltyDescriptions", royalty_descriptions),
		o.WithAddresses("royaltyBeneficiaries", royalty_beneficiaries...),
		o.WithSigner("account")).
		Print()

	// Dogs
	c.Tx(
		"ExampleNFTs/mint_dogs",
		o.WithArg("recipient", "account"),
		o.WithArg("name", "Dogs NFT"),
		o.WithArg("description", "Dogs are our best friend!!!"),
		o.WithArg("thumbnail", "https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-732x549.jpg"),
		o.WithArg("cuts", cuts),
		o.WithArg("royaltyDescriptions", royalty_descriptions),
		o.WithAddresses("royaltyBeneficiaries", royalty_beneficiaries...),
		o.WithSigner("account")).
		Print()
	c.Tx(
		"ExampleNFTs/mint_dogs",
		o.WithArg("recipient", "account"),
		o.WithArg("name", "Dogs NFT"),
		o.WithArg("description", "Dogs are our best friend!!!"),
		o.WithArg("thumbnail", "https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-732x549.jpg"),
		o.WithArg("cuts", cuts),
		o.WithArg("royaltyDescriptions", royalty_descriptions),
		o.WithAddresses("royaltyBeneficiaries", royalty_beneficiaries...),
		o.WithSigner("account")).
		Print()

	// Apples
	c.Tx(
		"ExampleNFTs/mint_apples",
		o.WithArg("recipient", "account"),
		o.WithArg("name", "Apples NFT"),
		o.WithArg("description", "Apples are smarter than you'd think..."),
		o.WithArg("thumbnail", "https://www.collinsdictionary.com/images/full/apple_158989157.jpg"),
		o.WithArg("cuts", cuts),
		o.WithArg("royaltyDescriptions", royalty_descriptions),
		o.WithAddresses("royaltyBeneficiaries", royalty_beneficiaries...),
		o.WithSigner("account")).
		Print()
	c.Tx(
		"ExampleNFTs/mint_apples",
		o.WithArg("recipient", "account"),
		o.WithArg("name", "Apples NFT"),
		o.WithArg("description", "Apples are smarter than you'd think..."),
		o.WithArg("thumbnail", "https://www.collinsdictionary.com/images/full/apple_158989157.jpg"),
		o.WithArg("cuts", cuts),
		o.WithArg("royaltyDescriptions", royalty_descriptions),
		o.WithAddresses("royaltyBeneficiaries", royalty_beneficiaries...),
		o.WithSigner("account")).
		Print()

	// Oranges
	c.Tx(
		"ExampleNFTs/mint_oranges",
		o.WithArg("recipient", "account"),
		o.WithArg("name", "Oranges NFT"),
		o.WithArg("description", "Oranges are best consumd fresh!"),
		o.WithArg("thumbnail", "https://i5.walmartimages.ca/images/Enlarge/234/6_r/6000191272346_R.jpg"),
		o.WithArg("cuts", cuts),
		o.WithArg("royaltyDescriptions", royalty_descriptions),
		o.WithAddresses("royaltyBeneficiaries", royalty_beneficiaries...),
		o.WithSigner("account")).
		Print()
	c.Tx(
		"ExampleNFTs/mint_oranges",
		o.WithArg("recipient", "account"),
		o.WithArg("name", "Oranges NFT"),
		o.WithArg("description", "Oranges are best consumd fresh!"),
		o.WithArg("thumbnail", "https://i5.walmartimages.ca/images/Enlarge/234/6_r/6000191272346_R.jpg"),
		o.WithArg("cuts", cuts),
		o.WithArg("royaltyDescriptions", royalty_descriptions),
		o.WithAddresses("royaltyBeneficiaries", royalty_beneficiaries...),
		o.WithSigner("account")).
		Print()

	// Black
	c.Tx(
		"ExampleNFTs/mint_black",
		o.WithArg("recipient", "account"),
		o.WithArg("name", "Black NFT"),
		o.WithArg("description", "Black contains all the colors, amazing!"),
		o.WithArg("thumbnail", "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Black_Wallpaper.jpg/2560px-Black_Wallpaper.jpg"),
		o.WithArg("cuts", cuts),
		o.WithArg("royaltyDescriptions", royalty_descriptions),
		o.WithAddresses("royaltyBeneficiaries", royalty_beneficiaries...),
		o.WithSigner("account")).
		Print()
	c.Tx(
		"ExampleNFTs/mint_black",
		o.WithArg("recipient", "account"),
		o.WithArg("name", "Black NFT"),
		o.WithArg("description", "Black contains all the colors, amazing!"),
		o.WithArg("thumbnail", "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Black_Wallpaper.jpg/2560px-Black_Wallpaper.jpg"),
		o.WithArg("cuts", cuts),
		o.WithArg("royaltyDescriptions", royalty_descriptions),
		o.WithAddresses("royaltyBeneficiaries", royalty_beneficiaries...),
		o.WithSigner("account")).
		Print()

	// White
	c.Tx(
		"ExampleNFTs/mint_white",
		o.WithArg("recipient", "account"),
		o.WithArg("name", "White NFT"),
		o.WithArg("description", "White is the absense of color!"),
		o.WithArg("thumbnail", "https://i.ytimg.com/vi/QggJzZdIYPI/mqdefault.jpg"),
		o.WithArg("cuts", cuts),
		o.WithArg("royaltyDescriptions", royalty_descriptions),
		o.WithAddresses("royaltyBeneficiaries", royalty_beneficiaries...),
		o.WithSigner("account")).
		Print()
	c.Tx(
		"ExampleNFTs/mint_white",
		o.WithArg("recipient", "account"),
		o.WithArg("name", "White NFT"),
		o.WithArg("description", "White is the absense of color!"),
		o.WithArg("thumbnail", "https://i.ytimg.com/vi/QggJzZdIYPI/mqdefault.jpg"),
		o.WithArg("cuts", cuts),
		o.WithArg("royaltyDescriptions", royalty_descriptions),
		o.WithAddresses("royaltyBeneficiaries", royalty_beneficiaries...),
		o.WithSigner("account")).
		Print()

	// REGISTER ALL DEMO NFT CONTRACTS WITH NFT CATALOG
	c.Tx(
		"NFTCatalog/add_to_nft_catalog_admin",
		o.WithArg("collectionIdentifier", "Cats Collection"),
		o.WithArg("contractName", "Cats"),
		o.WithArg("contractAddress", "account"),
		o.WithArg("nftTypeIdentifer", "A.f8d6e0586b0a20c7.Cats"),
		o.WithArg("addressWithNFT", "account"),
		o.WithArg("nftID", 0),
		o.WithArg("publicPathIdentifier", "catsCollection"),
		o.WithSigner("account")).
		Print()
	c.Tx(
		"NFTCatalog/add_to_nft_catalog_admin",
		o.WithArg("collectionIdentifier", "Dogs Collection"),
		o.WithArg("contractName", "Dogs"),
		o.WithArg("contractAddress", "account"),
		o.WithArg("nftTypeIdentifer", "A.f8d6e0586b0a20c7.Dogs"),
		o.WithArg("addressWithNFT", "account"),
		o.WithArg("nftID", 0),
		o.WithArg("publicPathIdentifier", "dogsCollection"),
		o.WithSigner("account")).
		Print()
	c.Tx(
		"NFTCatalog/add_to_nft_catalog_admin",
		o.WithArg("collectionIdentifier", "Apples Collection"),
		o.WithArg("contractName", "Apples"),
		o.WithArg("contractAddress", "account"),
		o.WithArg("nftTypeIdentifer", "A.f8d6e0586b0a20c7.Apples"),
		o.WithArg("addressWithNFT", "account"),
		o.WithArg("nftID", 0),
		o.WithArg("publicPathIdentifier", "applesCollection"),
		o.WithSigner("account")).
		Print()
	c.Tx(
		"NFTCatalog/add_to_nft_catalog_admin",
		o.WithArg("collectionIdentifier", "Oranges Collection"),
		o.WithArg("contractName", "Oranges"),
		o.WithArg("contractAddress", "account"),
		o.WithArg("nftTypeIdentifer", "A.f8d6e0586b0a20c7.Oranges"),
		o.WithArg("addressWithNFT", "account"),
		o.WithArg("nftID", 0),
		o.WithArg("publicPathIdentifier", "orangesCollection"),
		o.WithSigner("account")).
		Print()
	c.Tx(
		"NFTCatalog/add_to_nft_catalog_admin",
		o.WithArg("collectionIdentifier", "Black Collection"),
		o.WithArg("contractName", "Black"),
		o.WithArg("contractAddress", "account"),
		o.WithArg("nftTypeIdentifer", "A.f8d6e0586b0a20c7.Black"),
		o.WithArg("addressWithNFT", "account"),
		o.WithArg("nftID", 0),
		o.WithArg("publicPathIdentifier", "blackCollection"),
		o.WithSigner("account")).
		Print()
	c.Tx(
		"NFTCatalog/add_to_nft_catalog_admin",
		o.WithArg("collectionIdentifier", "White Collection"),
		o.WithArg("contractName", "White"),
		o.WithArg("contractAddress", "account"),
		o.WithArg("nftTypeIdentifer", "A.f8d6e0586b0a20c7.White"),
		o.WithArg("addressWithNFT", "account"),
		o.WithArg("nftID", 0),
		o.WithArg("publicPathIdentifier", "whiteCollection"),
		o.WithSigner("account")).
		Print()

	strand_a_identifiers_names := []string{
		"Dogs",
		"Cats"}

	strand_a_ids := []uint64{0, 0}

	strand_b_identifiers_names := []string{
		"Apples",
		"Oranges"}

	strand_b_ids := []uint64{0, 0}

	// SERVICE ACCOUNT MINTS A STRANDS NFT
	c.Tx(
		"STRANDS/mint_nft_emulator_only",
		o.WithArg("strandA", strand_a_identifiers_names),
		o.WithArg("strandAIDs", strand_a_ids),
		o.WithArg("strandB", strand_b_identifiers_names),
		o.WithArg("strandBIDs", strand_b_ids),
		o.WithArg("mintPrice", 10.0),
		o.WithSigner("account")).
		Print()

	// SERVICE ACCOUNT PAUSES AND RESUMES MINTING
	c.Tx(
		"STRANDS/pause_minting",
		o.WithSigner("account")).
		Print()
	c.Tx(
		"STRANDS/resume_minting",
		o.WithSigner("account")).
		Print()

	// get metadata
	c.Script(
		"STRANDS/get_nft_metadata",
		o.WithArg("address", "account"),
		o.WithArg("id", 0)).
		Print()

	// get metadata
	c.Script(
		"STRANDS/get_strand_registry_timestamp",
		o.WithArg("strandID", "A.f8d6e0586b0a20c7.Apples.NFT.0,A.f8d6e0586b0a20c7.Oranges.NFT.0")).
		Print()

	// get mint price
	c.Script(
		"STRANDS/get_mint_price").
		Print()

}
