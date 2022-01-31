//
//  CreditCardFilter.swift
//  VacasaPractice
//
//  Created by Tony Mu on 1/02/22.
//

import Foundation

struct CreditCardFilter {
    private let kSeperators = [" ", "-"]
    
    enum Pattern: String {
        case creditCard = "(\\d[ \\u2014\\u2013-]*){11,}"
        case digit = "\\d"
        case last4Digit = "(\\d[ \\u2014\\u2013-]*){4}$"
        case mask = "#"
        case asBankNumber = "^(012)|^(12)"
    }
    
    func consorString(_ string : String) -> String {
        guard let regex = try? NSRegularExpression(pattern: Pattern.creditCard.rawValue) else { return string }
        let range = NSRange(location: 0, length: string.utf16.count)
        let matches = regex.matches(in: string, options: [], range: range)
        var newString = string
        for match in matches {
            if let range = Range(match.range, in: string) {
                let creditCard = String(string[range]).trimmingCharacters(in: .whitespacesAndNewlines)
                guard !isASBankNumber(number: creditCard) else { continue }
                let maskedCreditCard = applyMask(creditCard)
                newString = newString.replacingOccurrences(of: creditCard, with: maskedCreditCard, options: [], range: range)
            }
        }
        return newString
    }
    
    /**
     * example ->
     * 2232-3333-2323-3333 -> ####-####-####-3333
     * 2222222222222222-> ############2222
     * 2222 2222 2222 2222 -> #### #### #### 2222
     * 11 22 33 44 55 66 77 88 99 -> ## ## ## ## ## ## ## ## 99
     **/
    private func applyMask(_ creditCard: String) -> String {
        let maskOffset = getLast4DigitOffset(creditCard)
        guard creditCard.count > maskOffset, let regex = try? NSRegularExpression(pattern: Pattern.digit.rawValue) else { return creditCard }
        let range = NSRange(location: 0, length: creditCard.utf16.count - maskOffset)
        let newString = regex.stringByReplacingMatches(in: creditCard, options: [], range: range, withTemplate: Pattern.mask.rawValue)
        return newString
    }
    
    private func getLast4DigitOffset(_ creditCard: String) -> Int {
        guard let regex = try? NSRegularExpression(pattern: Pattern.last4Digit.rawValue) else { return 0 }
        let range = NSRange(location: 0, length: creditCard.utf16.count)
        if let match = regex.firstMatch(in: creditCard, options: [], range: range) {
            return match.range.length
        }
        return 0
    }
    
    private func isASBankNumber(number: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: Pattern.asBankNumber.rawValue) else { return false }
        let numberOnly = number.replaceText(kSeperators, with: "")
        let range = NSRange(location: 0, length: numberOnly.utf16.count)
        return regex.firstMatch(in: numberOnly, options: [], range: range) != nil
    }
}

extension String {
    func replaceText(_ texts: [String], with: String) -> String {
        var result = self
        for text in texts {
            result = result.replacingOccurrences(of: text, with: with)
        }
        return result
    }
}
