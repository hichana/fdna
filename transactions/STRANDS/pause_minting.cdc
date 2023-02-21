import STRANDS from "../../contracts/STRANDS.cdc"

transaction() {

    let admin: &STRANDS.Admin

    prepare(signer: AuthAccount) {
        self.admin = signer.borrow<&STRANDS.Admin>(from: STRANDS.AdminStoragePath)
            ?? panic("Account does not store an object at the specified path")
    }

    execute {
        self.admin.pauseMinting()
    }
}
 