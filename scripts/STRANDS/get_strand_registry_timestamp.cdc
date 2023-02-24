import STRANDS from "../../contracts/STRANDS.cdc"

pub fun main(strandID: String): UFix64? {
    return STRANDS.getStrandRegistryTimestamp(strandID: strandID)
}