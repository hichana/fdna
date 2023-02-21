pub contract STRAND {

    pub let greeting: String

    init() {
        self.greeting = "Hello, STRAND!"
    }

    pub fun helloStrand(): String {
        return self.greeting
    }
}
