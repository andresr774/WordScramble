//
//  ScoreHistoryView.swift
//  WordScramble
//
//  Created by Andres camilo Raigoza misas on 16/02/22.
//

import SwiftUI

struct ScoreHistoryView: View {
    @ObservedObject var vm: ContentModel
    
    var body: some View {
        List {
            ForEach(vm.wordsHistory) { item in
                Section {
                    HStack {
                        Text(item.word)
                        Spacer()
                        Text("Score: \(item.score)")
                    }
                    .font(.headline)
                    ForEach(item.usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                    Button("Add Word") {
                        vm.addNewWordInHistory(item: item)
                    }
                }
            }
        }
        .navigationTitle("History")
    }
}

struct ScoreHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScoreHistoryView(vm: ContentModel())
        }
    }
}
