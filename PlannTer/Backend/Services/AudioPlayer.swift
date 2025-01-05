//
//  AudioPlayer.swift
//  PlannTer
//
//  Created by Anna Sidor on 02/01/2025.
//

import AVFoundation

class AudioPlayer {
    static let instance = AudioPlayer()
    
    private var audioPlayer: AVAudioPlayer?
    
    func playSound(soundName: String) {
           if let path = Bundle.main.path(forResource: soundName, ofType: "wav") {
               let url = URL(fileURLWithPath: path)
               do {
                   audioPlayer = try AVAudioPlayer(contentsOf: url)
                   audioPlayer?.play()
               } catch {
                   print("Error: \(error.localizedDescription)")
               }
           }
       }
}
