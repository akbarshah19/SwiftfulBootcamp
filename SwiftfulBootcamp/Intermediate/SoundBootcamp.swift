//
//  SoundBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 4/21/24.
//

import SwiftUI
import AVKit

enum SoundType {
    case ding, tada
}

class SoundManager {
    static let shared = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound(type: SoundType) {
        guard let url = Bundle.main.url(forResource: "\(type)", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print(error)
        }
    }
}

struct SoundBootcamp: View {
    
    var body: some View {
        VStack(spacing: 40) {
            Button {
                SoundManager.shared.playSound(type: .ding)
            } label: {
                Text("Play Ding")
            }
            
            Button {
                SoundManager.shared.playSound(type: .tada)
            } label: {
                Text("Play Tada")
            }
        }
    }
}

#Preview {
    SoundBootcamp()
}
