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
                .accessibilityHint("Welcome to Wordle, everyone's FAVORITE new word puzzle game! You have \(WordleGame.numberOfGuesses) guesses to guess the \(game.mysteryWord.count) letter mystery word")
            Divider()
                .padding(.bottom, 20)
            
            ForEach(0..<WordleGame.numberOfGuesses) { index in
                WordleRow(guess: $game.guesses[index])
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Row \(index + 1).  \(game.guesses[index].guessSummary)")
            }

            TextField("Input", text: $game.currentGuess.value)
                .border(Color.red,
                        width: $game.currentGuess.hasReachedLimit.wrappedValue ? 1 : 0 )
                .accessibilityHint("Type your guess for row \(game.activeRowIndex + 1). You have \(WordleGame.numberOfGuesses - game.activeRowIndex) guesses left")
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
