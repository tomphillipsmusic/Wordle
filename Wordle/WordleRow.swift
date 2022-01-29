//
//  WordleRow.swift
//  Wordle
//
//  Created by Tom Phillips on 1/28/22.
//

import SwiftUI

struct WordleRow: View {
    var body: some View {
        HStack {
            ForEach(0..<6) { _ in
                WordleSquare(squareState: .constant(.preGuess))
                
            }
        }
    }
}

struct WordleRow_Previews: PreviewProvider {
    static var previews: some View {
        WordleRow()
    }
}
