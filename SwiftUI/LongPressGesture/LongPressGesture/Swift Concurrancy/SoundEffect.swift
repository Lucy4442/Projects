//
//  SoundEffect.swift
//  LongPressGesture
//
//  Created by mac on 02/04/24.
//

import SwiftUI
import AVKit

class SoundManager {
    
    static let instance = SoundManager()
    
    var player : AVAudioPlayer?
    
    enum SoundOption : String {
        case Dog = "Dog-barking-sound"
        case Bell = "school-bell-sound"
    }
    
    func playSound(sound : SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }
        catch let error{
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

struct SoundEffect: View {
    var body: some View {
        VStack(spacing: 40)
        {
            Button("Play sound 1")
            {
                SoundManager.instance.playSound(sound: .Dog)
            }
            
            Button("Play sound 2")
            {
                SoundManager.instance.playSound(sound: .Bell)
            }
        }
    }
}

struct SoundEffect_Previews: PreviewProvider {
    static var previews: some View {
        SoundEffect()
    }
}
