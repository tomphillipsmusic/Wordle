//
//  ContentView.swift
//  Wordle
//
//  Created by Tom Phillips on 1/28/22.
//

import SwiftUI

struct ContentView: View {
    @State private var text = ""
    
    var body: some View {
        VStack {
            Text("WORLDLE")
                .font(.largeTitle)
            Divider()
                .padding(.bottom, 20)
            
            ForEach(0..<5) { _ in
                WordleRow()
            }

            TextField("Input", text: $text)
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
