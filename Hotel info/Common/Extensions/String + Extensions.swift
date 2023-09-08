//
//  String.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 05.09.2023.
//

import Foundation

extension String {
    enum ValidTypes {
        case name
        case email
        case numbers
    }
    
    enum Regex: String {
        case name = "[a-zA-Z]{1,}"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case numbers = "[0-9.]"
    }
    
    func isValid(validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        case .name: regex = Regex.name.rawValue
        case .email: regex = Regex.email.rawValue
        case .numbers: regex = Regex.numbers.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
    
    func separate() -> String {
        let string = self
        var count = 0
        var result = ""
        
        for char in string.reversed() {
            if count % 3 == 0 && count != 0 {
                result = " " + result
            }
            result = "\(char)" + result
            count += 1
        }
        
        return result
    }
}
