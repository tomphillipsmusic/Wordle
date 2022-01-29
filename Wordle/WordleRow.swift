//
//  WordleRow.swift
//  Wordle
//
//  Created by Tom Phillips on 1/28/22.
//

import SwiftUI

struct WordleRow: View {
    @Binding var guess: Guess
    
    var body: some View {
        HStack {
            ForEach(0..<WordleGame.wordLength) { index in
                let character = guess.word.count > index ? guess.word[index] : " "
                
                let squareState = guess.squares.count > index ? guess.squares[index] : WordleGame.SquareState.preGuess
                
                WordleSquare(character:  character, squareState: squareState)
            }
        }
    }
}

struct WordleRow_Previews: PreviewProvider {
    static var previews: some View {
        WordleRow(guess: .constant(Guess()))
    }
}
