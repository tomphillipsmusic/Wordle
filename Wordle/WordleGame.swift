//
//  WordleGame.swift
//  Wordle
//
//  Created by Tom Phillips on 1/28/22.
//

import Foundation
import SwiftUI

class WordleGame: ObservableObject {
    static let wordLength = 5
    static let numberOfGuesses = 6
    @Published var mysteryWord: String
    @Published var guesses = [Guess](repeating: Guess(), count: numberOfGuesses)
    @Published var currentGuess = ""
    @Published var activeRowIndex = 0
    
    init() {
        mysteryWord = "WORDS"
    }
    
    func guess() {
        guard currentGuess.count == WordleGame.wordLength else { return }
        currentGuess = currentGuess.uppercased()
        
        evaluateGuess()
        
        if currentGuess == mysteryWord || activeRowIndex + 1 == WordleGame.numberOfGuesses {
            // Game Over
        } else {
            activeRowIndex += 1
        }
    }
    
    private func evaluateGuess() {
        var guess = Guess(word: currentGuess)
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
                }
            }

        }
        
        for index in 0..<WordleGame.wordLength {
            if guess.squares[index] == .preGuess {
                guess.squares[index] = .notUsed
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
    }
}

struct Guess {
    var word = ""
    var squares = [WordleGame.SquareState](repeating: .preGuess, count: WordleGame.wordLength)
}
