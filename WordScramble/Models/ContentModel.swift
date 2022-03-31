//
//  ContentModel.swift
//  WordScramble
//
//  Created by Andres camilo Raigoza misas on 16/02/22.
//

import Foundation
import SwiftUI

class ContentModel: ObservableObject {
    
    @Published var usedWords = [String]()
    @Published var rootWord = ""
    @Published var newWord = ""
    
    @Published var errorTitile = ""
    @Published var errorMessage = ""
    @Published var showingError = false
    
    @Published var score = 0
    @Published var gameJustOpened = true
    @Published var wordsHistory = [Word]()
    @Published var showHistoryView = false
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 2 else {
            wordError(title: "Word too short", message: "It must be at least 3 characters long!")
            return
        }
        guard answer != rootWord else {
            wordError(title: "Word not allowed", message: "You can't use the same word!")
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        calculateScore(word: answer)
        addToHistory()
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = getNewWord(allWords: allWords)
                usedWords.removeAll()
                score = 0
                newWord = ""
                return
            }
        }
        fatalError("Coudn't load start.txt from bundle.")
    }
    
    func getNewWord(allWords: [String]) -> String {
        
        var isNewWord = false
        var isRepeatedWord = false
        var randomWord = allWords.randomElement() ?? "silkworm"
        while !isNewWord {
            for item in wordsHistory {
                if item.word == randomWord {
                    isRepeatedWord = true
                    randomWord = allWords.randomElement() ?? "silkworm"
                    break
                }
            }
            if !isRepeatedWord {
                isNewWord = true
            }
        }
        return randomWord
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitile = title
        errorMessage = message
        showingError = true
    }
    
    func calculateScore(word: String) {
        let itemNumber = 10 * usedWords.count
        let lettersCount = word.count
        score += itemNumber + lettersCount
    }
    
    func addToHistory() {
        let word = Word(word: rootWord, score: score, usedWords: usedWords)
        if let index = wordsHistory.firstIndex(where: { $0.word == rootWord }) {
            // This root word already exists in words history so remove the old one and add the replacement
            wordsHistory.remove(at: index)
            wordsHistory.insert(word, at: index)
        } else {
            // This is a new word
            wordsHistory.append(word)
        }
    }
    
    func addNewWordInHistory(item: Word) {
        showHistoryView = false
        rootWord = item.word
        score = item.score
        usedWords = item.usedWords
    }
}
