//
//  ContentView.swift
//  WordScramble
//
//  Created by Andres camilo Raigoza misas on 15/02/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ContentModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $vm.newWord)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
                
                Section {
                    Text("Score: \(vm.score)")
                        .font(.headline)
                    ForEach(vm.usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement()
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")
                    }
                }
            }
            .navigationTitle(vm.rootWord)
            .onSubmit(vm.addNewWord)
            .onAppear {
                if vm.gameJustOpened {
                    vm.startGame()
                    vm.gameJustOpened = false
                }
            }
            .alert(vm.errorTitile, isPresented: $vm.showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(vm.errorMessage)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Change Word") {
                        vm.startGame()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(isActive: $vm.showHistoryView) {
                        ScoreHistoryView(vm: vm)
                    } label: {
                        Text("History")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
