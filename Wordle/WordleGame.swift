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
    @Published var currentGuess = ""
    @Published var activeRowIndex = 0
    @Published var isGuessInvalid = false
    @Published var isGameOver = false
    let library: WordleLibrary
    
    static let daysSinceStart: Int? =  {
        var dateComponents = DateComponents()
        dateComponents.month = 6
        dateComponents.day = 19
        dateComponents.year = 2021
        let firstDay = Calendar.current.date(from: dateComponents)
        return Calendar.current.dateComponents([.day], from: firstDay!, to: .now).day
    }()
    
    init(library: WordleLibrary) {
        self.library = library
        WordleGame.wordLength = library.wordLength
        mysteryWord = library.possibleMysteryWords[WordleGame.daysSinceStart!].uppercased()
    }
    
    func guess() {
        guard currentGuess.count == WordleGame.wordLength else { return }
        
        guard library.possibleMysteryWords.contains(currentGuess.lowercased()) ||
              library.validGuesses.contains(currentGuess.lowercased()) else {
            isGuessInvalid = true
            return
        }
        
        evaluateGuess()
        
        if currentGuess.uppercased() == mysteryWord || activeRowIndex + 1 == WordleGame.numberOfGuesses {
            isGameOver = true
            activeRowIndex = 0
        } else {
            activeRowIndex += 1
        }
        
        currentGuess = ""
    }
    
    private func evaluateGuess() {
        var guess = Guess(word: currentGuess.uppercased())
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
    }
}

struct Guess {
    var word = ""
    var squares = [WordleGame.SquareState](repeating: .preGuess, count: WordleGame.wordLength)
}
