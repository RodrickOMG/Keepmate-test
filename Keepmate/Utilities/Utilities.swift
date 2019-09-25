//
//  Utilities.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/9/17.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import Foundation


class Utilities{
    
    static func isPasswordValid(_ password : String) -> Bool {
        let txt = password
        if txt.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil {
            return false
        }
        else if txt.rangeOfCharacter(from: CharacterSet.lowercaseLetters) == nil {
            return false
        }
        else if txt.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil {
            return false
        }
        else if txt.count < 8 {
            return false
        }
        else {
            return true
        }
    }
    
}

