//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Zeth Thomas on 11/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionsCounter = 0
    
    
    
    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ],
                center: .top,
                startRadius: 200,
                endRadius: 700
            )

                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .foregroundStyle(.white)
                    .font(.title.weight(.heavy))
                VStack (spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text (countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach (0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score:\(score)")
                    .foregroundStyle(.white)
                    .font(.title.weight(.heavy))
                Spacer()
                
                
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if questionsCounter < 8 {
                Button("Next Question", action: askQuestion)
            }  else {
                Button("Finish", action: resetGame)
            }
        } message: {
            Text("\(score)")
        }
     
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "You got it!"
            showingScore = true
            score += 10
        } else {
            scoreTitle = "Wrong! That was \(countries[number])."
            showingScore = true
        }
    }
    
    func askQuestion() {
        if questionsCounter < 8 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            questionsCounter += 1
        }
    }
    
    func resetGame(){
        score = 0
        questionsCounter = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        scoreTitle = "Winner!"
        showingScore = true
    }
}

#Preview {
    ContentView()
}
