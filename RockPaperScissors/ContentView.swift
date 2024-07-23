//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Enzo Ficoseco on 22/07/2024.
// Challenge 2

import SwiftUI

struct ContentView: View {
    
    let options = ["🪨", "🧻", "✂️"]
    let winningOptions = ["🧻", "✂️", "🪨"]
    @State private var appChoice = ""
    @State private var shouldWin = false
    @State private var playerScore = 0
    @State private var currentRound = 0
    @State private var showingScore = false
    
    
    // Initialize the game
    func newRound() {
        appChoice = options[Int.random(in: 0..<options.count)]
        shouldWin = Bool.random()
    }
    
    func resetGame(){
        playerScore = 0
        currentRound = 0
    }
    
    // Check the player's move
    func playerTapped(_ move: String) {
        let winMoves = ["🪨": "🧻", "🧻": "✂️", "✂️": "🪨"]
        let loseMoves = ["🪨": "✂️", "🧻": "🪨", "✂️": "🧻"]
        
        if shouldWin && move == winMoves[appChoice] || !shouldWin && move == loseMoves[appChoice] {
            playerScore += 1
        } else {
            playerScore -= 1
        }
        
        currentRound += 1
        
        if currentRound == 10 {
            showingScore = true
        } else {
            newRound()
        }
        
    }
    
    var body: some View {
        ZStack{
            
            Color(red: 0.7, green: 1.0, blue: 0.8)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Score: \(playerScore)")
                    .font(.largeTitle)
                
                Text("App's move: \(appChoice)")
                    .font(.title)
                
                Text( shouldWin ? "Try to Win!" : "Try to Lose!")
                    .font(.headline)
                
                HStack(spacing: 20) {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            playerTapped(option)
                        }) {
                            Text(option)
                                .font(.system(size: 60))
                                .padding()
                                .background(.mint)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .alert(isPresented: $showingScore) {
                Alert(
                    title: Text("Game Over"),
                    message: Text("Your final score is: \(playerScore)"),
                    dismissButton: .default(Text("Play Again")) {
                        // Reset the Game
                        resetGame()
                        newRound()
                    }
                )
            }
            .onAppear(perform: newRound)
            .padding()
        }
    }
}


#Preview {
    ContentView()
}
