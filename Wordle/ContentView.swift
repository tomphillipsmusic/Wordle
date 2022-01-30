//
//  ContentView.swift
//  Wordle
//
//  Created by Tom Phillips on 1/28/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var game = WordleGame(library: Library())
    
    var body: some View {
        VStack {
            
            // Current answer for debugging purposes
            // Text(game.mysteryWord)
            Text("WORLDLE")
                .font(.largeTitle)
            Divider()
                .padding(.bottom, 20)
            
            ForEach(0..<WordleGame.numberOfGuesses) { index in
                WordleRow(guess: $game.guesses[index])
            }

            TextField("Input", text: $game.currentGuess.value)
                .border(Color.red,
                        width: $game.currentGuess.hasReachedLimit.wrappedValue ? 1 : 0 )
                .padding()
            
            Button("Guess", action: game.guess)
                .padding()
                .disabled(game.currentGuess.value.count != WordleGame.wordLength)
            Spacer()
        }
        .alert("Not in Word List", isPresented: $game.isGuessInvalid) {
            Button("OK", role: .cancel, action: {})
        }
        .alert("Game Over", isPresented: $game.isGameOver) {
            Button("OK", role: .none, action: {})
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
