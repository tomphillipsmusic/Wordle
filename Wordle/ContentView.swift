//
//  ContentView.swift
//  Wordle
//
//  Created by Tom Phillips on 1/28/22.
//

import SwiftUI

struct ContentView: View {
    @State private var guess = ""
    @StateObject var game = WordleGame()
    
    var body: some View {
        VStack {
            Text("WORLDLE")
                .font(.largeTitle)
            Divider()
                .padding(.bottom, 20)
            
            ForEach(0..<WordleGame.numberOfGuesses) { index in
                WordleRow(guess: $game.guesses[index])
            }

            TextField("Input", text: $guess)
            
            Button("Guess") {
                game.guess(word: guess)
            }
            .disabled(guess.count != WordleGame.wordLength)
            Spacer()
        }        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
