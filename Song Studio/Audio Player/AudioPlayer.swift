//
//  AudioPlayer.swift
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer {
    
    static let shared = AudioPlayer()
    
    var player: AVPlayer?
    var song: Song?
    var playlist: [Song]?
    
    var isPlaying: Bool {
        return player?.rate != 0 && player?.error == nil
    }
    
    var currentIndex: Int? {
        guard let playlist = playlist, let song = song else { return nil }
        if let index = playlist.firstIndex(where: {$0.url == song.url}) {
            return index
        }
        return nil
    }
    
    func setPlaylist(_ songs: [Song]) {
        self.playlist = songs
    }
    
    func setUpPlayer(_ song: Song?) {
        guard let song = song, let songUrl = URL(string: song.url) else { return }
        self.setAudio(songUrl)
        self.song = song
        print("*************Song", song)
    }
    
    func setAudio(_ url: URL) {
        player = AVPlayer(url: url)
        player?.play()
    }
    
    func playAudio() {
        guard !isPlaying else { return }
        player?.play()
    }
    
    func pauseAudio() {
        guard isPlaying else { return }
        player?.pause()
    }
    
    func nextAudio() {
        guard let index = currentIndex, let playlist = playlist  else { return  }
        guard index < playlist.count - 1 else {
            setUpPlayer(playlist[0])
            return
        }
        setUpPlayer(playlist[index + 1])
    }
    
    func previousAudio() {
        guard let index = currentIndex, let playlist = playlist  else { return  }
        guard index > 0 else {
            setUpPlayer(playlist[playlist.count - 1])
            return
        }
        setUpPlayer(playlist[index - 1])
    }
    
}
