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

    @State private var isPlaying = false
    @State private var bpm: Double = 90.0
    
    var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                metronome
                metronomeControls
            }
        }
    }
    
    var metronome: some View {
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
    
    var metronomeControls: some View {
        VStack {
            Button {
                Task {
                    isPlaying.toggle()
                }
            } label: {
                Label(isPlaying ? "Play" : "Pause", systemImage: isPlaying ? "play" : "pause")
            }
            .frame(width: 400)
            .buttonStyle(.borderless)
            .labelStyle(.iconOnly)
            .font(.system(size: 80))
            .glassBackgroundEffect(in: .rect(cornerRadius: 50))
            
            VStack {
                Slider(value: $bpm, in: 40...134, step: 1)
            }
            .controlSize(.extraLarge)
            Text("\(Int(bpm)) BPM")
                .font(.largeTitle)
        }
        .frame(width: 400, height: 500)
        .offset(y: -250)
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
