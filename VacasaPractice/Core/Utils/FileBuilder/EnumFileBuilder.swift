//
//  EnumFileBuilder.swift
//  VacasaPractice
//
//  Created by Tony Mu on 18/03/22.
//

import Foundation
import UIKit

final class StringEnumBuilder {
    enum AccessLevel {
        case `public`
        case `internal`

        var modifier: String {
            switch self {
            case .public:
                return "public"
            case .internal:
                return "internal"
            }
        }
    }

    private let stringSpecifier = "%@"
    private let argumentPrefix = "p"
    private let enumNamePlaceholder = "{enumName}"
    private let moudleNamePlaceholder = "{moduleName}"
    private let elementsPlaceholder = "{enumElements}"
    private let accessModifierPlaceholder = "{accessModifier}"

    private let template: String
    private let enumName: String
    private let moduleName: String
    private let accessLevel: AccessLevel

    private var elements: String = ""

    init(template: String, enumName: String = "Strings", moduleName: String, accessLevel: AccessLevel = .public) {
        self.template = template
        self.enumName = enumName
        self.moduleName = moduleName
        self.accessLevel = accessLevel
    }

    @discardableResult
    func addComment(_ value: String) -> StringEnumBuilder {
        self.elements.append("\(comment: value)")
        return self
    }

    @discardableResult
    func addNewLine(_ number: Int = 1) -> StringEnumBuilder {
        elements.append("\(repeating: "\n", number: number)")
        return self
    }

    @discardableResult
    func addTab(_ number: Int = 1) -> StringEnumBuilder {
        elements.append("\(repeating: "\t", number: number)")
        return self
    }

    @discardableResult
    func addElement(_ string: String, for key: String) -> StringEnumBuilder {
        let arguments = getSubStringArguments(from: string)
        elements.append(getEnumElement(for: key, arguments: arguments))
        return self
    }

    func build() -> String {
        var result = template
        result.replaceOccurrences(of: enumNamePlaceholder, with: enumName)
        result.replaceOccurrences(of: moudleNamePlaceholder, with: moduleName)
        result.replaceOccurrences(of: accessModifierPlaceholder, with: accessLevel.modifier)
        result.replaceOccurrences(of: elementsPlaceholder, with: elements)
        return "\(result)"
    }

    /// Convert number of '%@' to [p1:String, p2:String]
    func getSubStringArguments(from string: String) -> [String:String] {
        guard string.contains(stringSpecifier) else { return [:] }
        var arguments = [String:String]()
        (1...string.numberOfOccurrencesOf(string: stringSpecifier)).forEach { i in
            let key = "\(argumentPrefix)\(i)"
            let type = "String"
            arguments.updateValue(type, forKey: key)
        }
        return arguments
    }

    private func getEnumElement(for key: String, arguments: [String:String]) -> String {
        if arguments.isEmpty {
            return "\(property: key, enumName: enumName, accessModifier: accessLevel.modifier)"
        }
        return "\(function: key, enumName: enumName, accessModifier: accessLevel.modifier, arguments: arguments)"
    }
}

extension String.StringInterpolation {
    /// Convert the string in comment format
    mutating func appendInterpolation(comment value: String) {
        appendLiteral("/// \(value)")
    }

    /// Repeat the string for number of times
    mutating func appendInterpolation(repeating: String, number: Int) {
        let count = number > 0 ? number : 1
        appendLiteral(String(repeating: repeating, count: count))
    }

    /// Convert the given key to a enum string property
    mutating func appendInterpolation(property key: String, enumName: String, accessModifier: String) {
        appendLiteral("\(accessModifier) static let \(key) = \(enumName).tr(\"Localizable\", \"\(key)\")")
    }

    /// Convert the given key and arguments to string func with parameters
    mutating func appendInterpolation(function key: String, enumName: String, accessModifier: String, arguments: [String:String]) {
        let params = Array(arguments.keys)
        appendLiteral("\(accessModifier) static func \(key)(\(typeParams: arguments)) -> String { return \(enumName).tr(\"Localizable\", \"\(key)\", \(params: params)) }")
    }

    // Convert dict to 'key1: value1, key2: value2,...' format
    mutating func appendInterpolation(typeParams: [String:String]) {
        let result =  typeParams.sorted(by: {$0.0 < $1.0})
                                .compactMap({(key, value) -> String in return "\(key): \(value)"})
                                .joined(separator: ", ")
        appendLiteral(result)
    }

    // Convert arrary of strings to 'value1, value2, ...' format
    mutating func appendInterpolation(params: [String]) {
        appendLiteral(params.sorted(by: {$0 < $1}).joined(separator: ", "))
    }
}

extension String {
    mutating func replaceOccurrences(of target: String,
                            with replacement: String) {
        self = self.replacingOccurrences(of: target, with: replacement)
    }

    func numberOfOccurrencesOf(string: String) -> Int {
        return self.components(separatedBy:string).count - 1
    }
}

extension StringEnumBuilder {
   static var defaultTemlate: String {
        """
        import Foundation

        {accessModifier} enum {enumName} {
            {accessModifier} enum {moduleName} {
            {enumElements}
            }
        }

        extension {enumName} {
            private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
                let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
                return String(format: format, locale: Locale.current, arguments: args)
            }
        }

        private final class BundleToken {
            static let bundle: Bundle = {
                #if SWIFT_PACKAGE
                    return Bundle.module
                #else
                    return Bundle(for: BundleToken.self)
                #endif
            }()
        }
        """
    }
}
