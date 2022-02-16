//
//  ListExplanation.swift
//  WordScramble
//
//  Created by Andres camilo Raigoza misas on 15/02/22.
//

import SwiftUI

struct ListExplanation: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        List {
            Section("Section 1") {
                Text("Static row 1")
                Text("Static row 2")
            }
            Section("Section 2") {
                ForEach(people, id: \.self) {
                    Text("Dynamic row \($0)")
                }
            }
            Section("Section 3") {
                Text("Static row 3")
                Text("Static row 4")
            }
        }
        .listStyle(.grouped)
    }
}

struct ListExplanation_Previews: PreviewProvider {
    static var previews: some View {
        ListExplanation()
    }
}
