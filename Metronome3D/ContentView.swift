//
//  ContentView.swift
//  Metronome3D
//
//  Created by Raymond Chen on 3/1/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var enlarge = false

    var body: some View {
        VStack {
            RealityView { content in
                // Add the initial RealityKit content
                if let metronomeEntity = try? await Entity(named: "Metronome", in: realityKitContentBundle), let environment = try? await EnvironmentResource(named: "studio") {
                    
                    metronomeEntity.components.set(ImageBasedLightComponent(source: .single(environment)))
                    metronomeEntity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: metronomeEntity))
                    metronomeEntity.components.set(GroundingShadowComponent(castsShadow: true))
            
                    content.add(metronomeEntity)
                }
            }
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
