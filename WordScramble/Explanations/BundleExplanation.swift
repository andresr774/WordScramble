//
//  BundleExplanation.swift
//  WordScramble
//
//  Created by Andres camilo Raigoza misas on 15/02/22.
//

import SwiftUI

struct BundleExplanation: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func loadFile() {
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                // We loaded the file into the string
            }
        }
    }
}

struct BundleExplanation_Previews: PreviewProvider {
    static var previews: some View {
        BundleExplanation()
    }
}
