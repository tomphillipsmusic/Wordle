//
//  WordleSquare.swift
//  Wordle
//
//  Created by Tom Phillips on 1/28/22.
//

import SwiftUI

struct WordleSquare: View {
    @State private var borderColor = Color.secondary
    @State private var character = "A"
    @Binding var squareState: WordleGame.SquareState
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(squareState.color)
                .background(.primary)
                .border(squareState.color)
                .frame(width: 40, height: 40)
            Text(character)
                .foregroundColor(.white)
                .bold()
        }
    }
}

struct WordleSquare_Previews: PreviewProvider {
    static var previews: some View {
        WordleSquare(squareState: .constant(.notUsed))
    }
}
