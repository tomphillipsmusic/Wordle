//
//  WordleGame.swift
//  Wordle
//
//  Created by Tom Phillips on 1/28/22.
//

import Foundation
import SwiftUI

class WordleGame: ObservableObject {
    var mysteryWord: String
    var guesses: [String] = []
    var activeRowIndex = 0
    
    init() {
        mysteryWord = "PIESCI"
    }
    
    func guess(word: String) {
        guesses.append(word)
        
        
    }
    
    enum SquareState {
        case right
        case notUsed
        case wrongLocation
        case preGuess
        
        var color: Color {
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
    }
}
