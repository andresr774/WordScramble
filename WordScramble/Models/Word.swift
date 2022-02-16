//
//  Word.swift
//  WordScramble
//
//  Created by Andres camilo Raigoza misas on 16/02/22.
//

import Foundation

struct Word: Identifiable {
    let id = UUID().uuidString
    let word: String
    let score: Int
    let usedWords: [String]
}

struct WordsDataMock {
    static let words = [
        Word(word: "dribble", score: 100, usedWords: ["ble", "drib", "rible"]),
        Word(word: "automatic", score: 120, usedWords: ["auto", "matic", "mauto"]),
        Word(word: "mathematic", score: 200, usedWords: ["math", "matic", "cima"])
    ]
}
