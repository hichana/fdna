package main

import (
	o "github.com/bjartek/overflow"
)

func main() {

	// flow_network := "emulator"
	flow_network := "embedded"

	// create the overflow client
	c := o.Overflow(o.WithNetwork(flow_network))

	// test script
	c.Script(
		"STRAND/helloStrand").
		Print()

	// user1 self-initializes for demo NFTs
	c.Tx(
		"ExampleNFTs/initialize_account",
		o.WithSigner("user1")).
		Print()

	// service account self sets up with royalty receiver
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

	// service account mints NFTs to user1
	// Cats
	c.Tx(
		"ExampleNFTs/mint_nfts",
		o.WithArg("recipient", "user1"),
		o.WithArg("name", "Cats NFT"),
		o.WithArg("description", "Cats are cute but sometimes unpredictable."),
		o.WithArg("thumbnail", "https://cdn.theatlantic.com/thumbor/W544GIT4l3z8SG-FMUoaKpFLaxE=/0x131:2555x1568/1600x900/media/img/mt/2017/06/shutterstock_319985324/original.jpg"),
		o.WithArg("cuts", cuts),
		o.WithArg("royaltyDescriptions", royalty_descriptions),
		o.WithAddresses("royaltyBeneficiaries", royalty_beneficiaries...),
		o.WithSigner("account")).
		Print()

}
