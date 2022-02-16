//
//  workingWithStrings.swift
//  WordScramble
//
//  Created by Andres camilo Raigoza misas on 15/02/22.
//

import SwiftUI

struct workingWithStrings: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func test() {
        let input = "a b c"
        let letters = input.components(separatedBy: " ")
        let input2 = """
                        a
                        b
                        c
                     """
        let letters2 = input2.components(separatedBy: "\n")
        let letter = letters2.randomElement()
        
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let word = "swift"
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        let allGood = misspelledRange.location == NSNotFound
    }
}

struct workingWithStrings_Previews: PreviewProvider {
    static var previews: some View {
        workingWithStrings()
    }
}
