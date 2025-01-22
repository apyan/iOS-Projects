//Given an array of non-empty String values, remove all the strings that start with a vowel (a, e, i, o, u),
//regardless of case, and sort the remaining strings, again regardless of case, by descending alphabetical order (z to a).
//
//Return whatever is left in the filtered and sorted array.
//
//Example 1:
//
//Given array: ["Alan", "Timothy", "Kevin", "Ethan", "Matthew"]
//Filtered array: ["Timothy", "Kevin", "Matthew"]
//Sorted array (final result): ["Timothy", "Matthew", "Kevin"]
//
//
//
//Example 2:
//
//Given array: ["lion", "tiger", "bear", "eagle", "Big Bird", "raccoon", "skunk", "Toothless", "aardvark", "baboon", "Old Yeller"]
//Filtered array: ["lion", "tiger", "bear", "Big Bird", "raccoon", "skunk", "Toothless", "baboon"]
//Sorted array (final result): ["Toothless", "tiger", "skunk", "raccoon", "lion", "Big Bird", "bear", "baboon"]

import Foundation

class SortAndFilterExercise {
    func sortAndFilter(_ stringArray: [String]) -> [String] {
        
        let vowels: [Character] = ["a", "e", "i", "o", "u"]
        
        var filterArray : [String] = []
        
        // Filter by start of vowels
        filterArray = stringArray.filter { name in
            !vowels.contains(name.lowercased().first!)
        }
        
        // Alphabetically descending
        filterArray.sort { name1, name2 in
            name2.lowercased() < name1.lowercased()
        }
        
        return filterArray
    }
}

// Coding Challenge
// 1. Dinosaur image on the detail screen tappable -> Goes to screen with dinosaur image only
// 2. Display info card when the dinosaur map annotation is tapped
// 3. Add filter by movie
// 4. Delete dinosaur permanently on the list
