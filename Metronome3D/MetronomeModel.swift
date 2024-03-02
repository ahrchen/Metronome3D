//
//  MetronomeModel.swift
//  Metronome3D
//
//  Created by Raymond Chen on 3/1/24.
//

import AVKit
import SwiftUI
import RealityKit

@Observable
class MetronomeModel {
    static let defaultBPM: Double = 90
    static let tigeLeft = simd_quatf(angle: -0.5, axis: [0,0,1])
    static let tigeRight = simd_quatf(angle: 0.5, axis: [0,0,1])
    static let tigePosition: SIMD3<Float> = [-0.053, 1.904, 0.828]
    var swingRight: FromToByAnimation<Transform> {
        FromToByAnimation(name: "swingRight",
                          from: .init(.init(rotation: MetronomeModel.tigeLeft,
                                            translation: MetronomeModel.tigePosition)),
                          to: .init(.init(rotation: MetronomeModel.tigeRight,
                                          translation: MetronomeModel.tigePosition)),
                          duration: 53 / bpm,
                          bindTarget: .transform
        )
    }
    var animateSwingRight: AnimationResource {
        try! AnimationResource.generate(with: swingRight)
    }
    var swingLeft: FromToByAnimation<Transform> {
        FromToByAnimation(name: "swingRight",
                          from: .init(.init(rotation: MetronomeModel.tigeRight,
                                            translation: MetronomeModel.tigePosition)),
                          to: .init(.init(rotation: MetronomeModel.tigeLeft,
                                          translation: MetronomeModel.tigePosition)),
                          duration: 53 / bpm,
                          bindTarget: .transform
        )
    }
    var animateSwingLeft: AnimationResource {
        try! AnimationResource.generate(with: swingLeft)
    }
    let player = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "metronomeSound", withExtension: "mp3")!)
    var isPlaying = false {
        didSet {
            player.prepareToPlay()
        }
    }
    var bpm: Double = defaultBPM {
        didSet {
            timer = Timer.publish(every: 60 / bpm, on: .main, in: .common).autoconnect()
        }
    }
    
    var timer = Timer.publish(every: 60 / defaultBPM, on: .main, in: .common).autoconnect()
}
