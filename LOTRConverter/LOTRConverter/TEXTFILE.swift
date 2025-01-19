//
//  TEXTFILE.swift
//  LOTRConverter
//
//  Created by Alvin on 1/16/25.
//

// Complete a function to convert the given Int value to a Double, and then divide it by 3 and return a String of the result.
//
// The returned String should only contain digits after the decimal place if they are something other than 0,
// and it should not return more than two digits after the decimal place.
//
//  Your solution should work for both positive and negative numbers.
//  For zero, just do what we did in the lessons and return an empty string.
//
//  Any cases that have no possible solution should return an empty string.
//                                                                            
//                                                                            
//                                                                            
// Example 1:
// Given Int: 9
// Converted Double: 9.0
// Divided by three: 3.0
// Returned String: "3"
//
//
// Example 2:
// Given Int: 5
// Converted Double: 5.0
// Divided by three: 1.666666667
// Returned String: "1.67"

import Foundation

class ConvertExercise {
    func convert(_ intValue: Int) -> String {
        // your conversion code here
        let doubleAmount = Double(intValue)
        
        let convertedAmount = doubleAmount / 3.0
        
        var convertedString = String(format: "%.2f", convertedAmount)
        
        if (String(convertedString.suffix(2)) == "00") {
            return String(convertedString.removeLast(3)) ?? 
        } else {
            return convertedString
        }
    }
}

// Coding Challenges

// 1: Add sixth currency
// 2: Persist user currency selection, when app is closed and opened
//      UserDefaults
// 3: Dismiss the keyboard
//      User taps outside the keyboard
//      FocusState
// 4: Refactor Currency Conversion Section
