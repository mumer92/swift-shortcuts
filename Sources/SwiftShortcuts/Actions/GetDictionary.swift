public struct GetDictionary: Shortcut {
    let value: [(key: Text, value: DictionaryValue)]

    public var body: some Shortcut {
        Action(identifier: "is.workflow.actions.dictionary", parameters: Parameters(base: self))
    }

    public init(_ value: KeyValuePairs<Text, DictionaryValue>) {
        self.value = Array(value)
    }
}

extension GetDictionary {
    struct Parameters: Encodable {
        enum CodingKeys: String, CodingKey {
            case items = "WFItems"
        }

        let base: GetDictionary

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(OuterDictionary(dictionary: base.value), forKey: .items)
        }
    }
}
