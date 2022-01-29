//
//  WordleSquare.swift
//  Wordle
//
//  Created by Tom Phillips on 1/28/22.
//

import SwiftUI

struct WordleSquare: View {
    var character: String
    var squareState: WordleGame.SquareState
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(squareState.foregroundColor)
                .background(.primary)
                .border(squareState.borderColor)
                .frame(width: 40, height: 40)
            Text(character)
                .foregroundColor(.white)
                .bold()
        }
    }
}

struct WordleSquare_Previews: PreviewProvider {
    static var previews: some View {
        WordleSquare(character: "A", squareState: .right)
    }
}
