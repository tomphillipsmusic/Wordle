//
//  WordleGame.swift
//  Wordle
//
//  Created by Tom Phillips on 1/28/22.
//

import Foundation
import SwiftUI

class WordleGame: ObservableObject {
    static var wordLength = 5
    static let numberOfGuesses = 6
    @Published var mysteryWord: String
    @Published var guesses = [Guess](repeating: Guess(), count: numberOfGuesses)
    @Published var currentGuess: TextLimiter
    @Published var activeRowIndex = 0
    @Published var isGuessInvalid = false
    @Published var isGameOver = false
    let library: WordleLibrary
    
    init(library: WordleLibrary) {
        self.library = library
        WordleGame.wordLength = library.wordLength
        mysteryWord = library.selectMysteryWord()
        currentGuess = TextLimiter(limit: library.wordLength)
    }
    
    private func announceGuessSummary() {
        if UIAccessibility.isVoiceOverRunning {
            UIAccessibility.post(notification: .screenChanged, argument: "Row \(activeRowIndex + 1).  \(guesses[activeRowIndex].guessSummary).")
        }
    }
    
    func guess() {
        guard currentGuess.value.count == WordleGame.wordLength else {
            isGuessInvalid = true
            return
            
        }
        
        guard library.possibleMysteryWords.contains(currentGuess.value.lowercased()) ||
              library.validGuesses.contains(currentGuess.value.lowercased()) else {
            isGuessInvalid = true
            return
        }
        
        evaluateGuess()
        announceGuessSummary()
        
        if currentGuess.value.uppercased() == mysteryWord || activeRowIndex + 1 == WordleGame.numberOfGuesses {
            isGameOver = true
            activeRowIndex = 0
        } else {
            activeRowIndex += 1
        }
        
        currentGuess.value = ""
    }
    
    private func evaluateGuess() {
        var guess = Guess(word: currentGuess.value.uppercased())
        var usedIndexes = Set<Int>()
        
        for index in 0..<WordleGame.wordLength {
            if mysteryWord[index] == guess.word[index] {
                guess.squares[index] = .right
                usedIndexes.update(with: index)
            }
        }
        
        for index in 0..<WordleGame.wordLength {
            if guess.squares[index] == .preGuess {
                if mysteryWord.contains(guess.word[index]) {
                    for characterIndex in 0..<mysteryWord.count {
                        if mysteryWord[characterIndex] == guess.word[index] {
                            if !usedIndexes.contains(characterIndex) {
                                guess.squares[index] = .wrongLocation
                                usedIndexes.update(with: characterIndex)
                            }
                        }
                    }
                } else {
                    guess.squares[index] = .notUsed

                }
            }

        }
        
        guesses[activeRowIndex] = guess
    }
    
    enum GameState {
        case playing, gameOver
    }
    
    enum SquareState {
        case right
        case notUsed
        case wrongLocation
        case preGuess
        
        var foregroundColor: Color {
            switch self {
            case .right:
                return .correct
            case .notUsed:
                return .notUsed
            case .wrongLocation:
                return .wrongLocation
            case .preGuess:
                return .black
            }
        }
        
        var borderColor: Color {
            switch self {
            case .right:
                return .correct
            case .notUsed:
                return .notUsed
            case .wrongLocation:
                return .wrongLocation
            case .preGuess:
                return .border
            }
        }
        
        var description: String {
            switch self {
            case .right:
                return "Correct. "
            case .notUsed:
                return "Not used. "
            case .preGuess:
                return ""
            case .wrongLocation:
                return "Wrong location."
            }
        }
    }
}

struct Guess {
    var word = ""
    var squares = [WordleGame.SquareState](repeating: .preGuess, count: WordleGame.wordLength)
    
    var guessSummary: String {
        
        var summary = ""
        
        if word.isEmpty {
            summary.append("No guess yet.")
        } else {
            summary.append("You guessed \(word). ")
        }
        
        for (index, letter) in word.enumerated() {
            let squareStatus = squares[index].description
            summary.append("\(letter), \(squareStatus)")
        }
        
        return summary
    }
}
