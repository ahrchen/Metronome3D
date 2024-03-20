//
//  CreditsView.swift
//  Metronome3D
//
//  Created by Raymond Chen on 3/2/24.
//

import SwiftUI

struct CreditsView: View {
    @Environment(\.dismissWindow) private var dismissWindow
    let url = URL(string: "https://knowselfdaily.netlify.app/")!
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Credits")
                .font(.title)
            VStack(alignment: .leading) {
                Text("Developer")
                    .font(.headline)
                Link(destination: url) {
                    Text("Raymond Chen")
                        .font(.subheadline)
                        .accessibilityLabel("Raymond Chen")
                        .accessibilityValue("Links to Developer's Homepage")
                }
                Text("Assets")
                    .font(.headline)
                Text("Vintage Metronome (https://skfb.ly/o9K7o) by Weekless is licensed under Creative Commons Attribution (http://creativecommons.org/licenses/by/4.0/).")
                    .font(.subheadline)
            }
            Button {
                dismissWindow(id: "credits")
            } label: {
                Label("dismiss", systemImage: "x.circle")
                    .labelStyle(.titleOnly)
            }
        }
        
        

    }
}

#Preview {
    CreditsView()
        .frame(width: 300, height: 300)
}
