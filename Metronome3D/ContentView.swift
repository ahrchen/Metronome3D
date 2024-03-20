//
//  ContentView.swift
//  Metronome3D
//
//  Created by Raymond Chen on 3/1/24.
//

import SwiftUI
import RealityKit
import RealityKitContent


var metronomeEntity = Entity()
struct ContentView: View {
    @Environment(MetronomeModel.self) private var metronomeModel
    @Environment(\.openWindow) private var openWindow
    @State var isLoading = true
    
    var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                metronome
                metronomeControls
                Button {
                    openWindow(id: "credits")
                } label: {
                    Label(isLoading ? "Loading Assets" : "Credits", systemImage: "")
                }
                .offset(y: isLoading ? -300 : -200)
                .buttonStyle(.borderless)
                .labelStyle(.titleOnly)
            }
        }
        .progressViewStyle(.circular)
        .onReceive(metronomeModel.timer) { _ in
            if metronomeModel.isPlaying {
                metronomeModel.player.play()
                metronomeModel.player.prepareToPlay()
            }
        }
    }
    
    var metronome: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let metronome = try? await Entity(named: "Metronome", in: realityKitContentBundle), let environment = try? await EnvironmentResource(named: "studio") {
                metronomeEntity = metronome
                metronomeEntity.components.set(ImageBasedLightComponent(source: .single(environment)))
                metronomeEntity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: metronomeEntity))
                metronomeEntity.components.set(GroundingShadowComponent(castsShadow: true))
                
                content.add(metronomeEntity)
            }
            isLoading = false
        }
        .onReceive(metronomeModel.timer) { _ in
            if let tige = metronomeEntity.findEntity(named: "Tige_1") {
                if metronomeModel.isPlaying {
                    if tige.transform.rotation == .init(angle: 0.5, axis: [0,0,1]) {
                        tige.transform.rotation = .init(angle: -0.5, axis: [0,0,1])
                        tige.playAnimation(metronomeModel.animateSwingLeft)
                    } else {
                        tige.transform.rotation = .init(angle: 0.5, axis: [0,0,1])
                        tige.playAnimation(metronomeModel.animateSwingRight)
                    }
                }
            }
        }
    }
    
    var metronomeControls: some View {
        @Bindable var model = metronomeModel
        return VStack {
            Button {
                Task {
                    metronomeModel.isPlaying.toggle()
                }
            } label: {
                Label(metronomeModel.isPlaying ? "Pause" : "Play", systemImage: metronomeModel.isPlaying ? "pause" : "play")
            }
            .frame(width: 400)
            .buttonStyle(.borderless)
            .labelStyle(.iconOnly)
            .font(.system(size: 80))
            .glassBackgroundEffect(in: .rect(cornerRadius: 50))
            
            VStack {
                Slider(value: $model.bpm, in: 40...134, step: 1)
            }
            .controlSize(.extraLarge)
            Text("\(Int(model.bpm)) BPM")
                .font(.largeTitle)
        }
        .frame(width: 400, height: 550)
        .offset(y: -250)
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
