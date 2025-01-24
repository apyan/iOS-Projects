//
//  Char.swift
//  BBQuotes
//
//  Created by Alvin on 1/23/25.
//

import Foundation

struct Char: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    // Swift comes with built-in converter for String to URL
    let images: [URL]
    let aliases: [String]
    let status: String
    let portrayedBy: String
    // The ? will automatically set it to nil (null), hence var is needed to change
    var death: Death?
    
    // Text(myName ?? "Unknown"), if myName is an Optional, myName?
    // Text(myName!), forcefully use it, force unwrapping
    // if let newProperty = myName { ... }
    // guard let newProperty = myName else { ... }
    
    // Concurrency = running more than one computing task at the same time
    // UI should be the fastest priority
    
    // async, tell app that function might take a while to run, hence change 'lanes'
    // func unwrapGift() async { ... }
    // hence await, a sibling word to async
    // await friend.unwrapGift(), tell other functions and code to happen while this function isn't finished yet
}
