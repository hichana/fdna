package main

import (
	o "github.com/bjartek/overflow"
)

func main() {

	flow_network := "testnet"

	// create the overflow client
	c := o.Overflow(o.WithNetwork(flow_network), o.WithFlowForNewUsers(1000.0))

	// USER1 SELF-INITIALIZES FOR DEMO NFTS
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
		o.WithArg("recipient", "user1"),
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
		o.WithArg("recipient", "user1"),
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
		o.WithArg("recipient", "user1"),
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
		o.WithArg("recipient", "user1"),
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
		o.WithArg("recipient", "user1"),
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
		o.WithArg("recipient", "user1"),
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
		o.WithArg("recipient", "user1"),
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
		o.WithArg("recipient", "user1"),
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
		o.WithArg("recipient", "user1"),
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
		o.WithArg("recipient", "user1"),
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
		o.WithArg("recipient", "user1"),
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
		o.WithArg("recipient", "user1"),
		o.WithArg("name", "White NFT"),
		o.WithArg("description", "White is the absense of color!"),
		o.WithArg("thumbnail", "https://i.ytimg.com/vi/QggJzZdIYPI/mqdefault.jpg"),
		o.WithArg("cuts", cuts),
		o.WithArg("royaltyDescriptions", royalty_descriptions),
		o.WithAddresses("royaltyBeneficiaries", royalty_beneficiaries...),
		o.WithSigner("account")).
		Print()

}
