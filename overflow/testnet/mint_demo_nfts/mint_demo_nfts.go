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
}
