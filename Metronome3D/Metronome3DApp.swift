//
//  Metronome3DApp.swift
//  Metronome3D
//
//  Created by Raymond Chen on 3/1/24.
//

import SwiftUI

@main
struct Metronome3DApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(MetronomeModel())
        }.windowStyle(.volumetric)
    }
}
