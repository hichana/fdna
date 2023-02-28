import STRANDS from "../../contracts/STRANDS.cdc"

pub fun main(): UFix64 {
    return STRANDS.getMintPrice()
}