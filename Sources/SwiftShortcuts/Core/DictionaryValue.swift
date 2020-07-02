public enum DictionaryValue {
    case string(Text)
    case number(Text)
    case boolean(VariableValue<Bool>)
    case dictionary([(key: Text, value: DictionaryValue)])
    case array([DictionaryValue])
}

extension DictionaryValue {
    public static func boolean(_ variable: Variable) -> DictionaryValue {
        .boolean(VariableValue(variable))
    }

    public static func boolean(_ value: Bool) -> DictionaryValue {
        .boolean(VariableValue(value))
    }

    public static func number(_ value: Number) -> DictionaryValue {
        .number("\(literal: value)")
    }
}

extension DictionaryValue: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(KeyedValue(key: nil, value: self))
    }
}

extension DictionaryValue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: DictionaryValue...) {
        self = .array(elements)
    }
}

extension DictionaryValue: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .boolean(.init(value))
    }
}

extension DictionaryValue: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (Text, DictionaryValue)...) {
        self = .dictionary(elements)
    }
}

extension DictionaryValue: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .number("\(literal: value)")
    }
}

extension DictionaryValue: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .number("\(literal: value)")
    }
}

extension DictionaryValue: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .string(Text(value))
    }
}

extension DictionaryValue: ExpressibleByStringInterpolation {
    public init(stringInterpolation: Text.StringInterpolation) {
        self = .string(Text(stringInterpolation: stringInterpolation))
    }
}
