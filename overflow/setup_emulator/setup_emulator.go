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

}