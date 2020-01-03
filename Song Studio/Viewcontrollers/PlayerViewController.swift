//
//  PlayerViewController.swift
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//

import UIKit

protocol PlayerUIDelegate: class {
    func updateUI(_ playItem: Song)
}

class PlayerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playerCoverImageView: UIImageView!
    @IBOutlet weak var playerTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var playerControlButton: UIButton!
    
    var playlist: [Song]?
    var playItem: Song? = AudioPlayer.shared.song
    weak var delegate: PlayerUIDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
        populateUIData()
        stylePlayControlButton()
    }
    
    @IBAction func previousTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            AudioPlayer.shared.previousAudio()
            self.playItem = AudioPlayer.shared.song
            self.populateUIData()
            self.stylePlayControlButton()
            self.containerView.layoutIfNeeded()
        }
    }
    
    @IBAction func playerControlTapped(_ sender: UIButton) {
        guard AudioPlayer.shared.isPlaying else {
            AudioPlayer.shared.playAudio()
            playerControlButton.setImage(UIImage(named: "pause-xx-blue"), for: .normal)
            return
        }
        AudioPlayer.shared.pauseAudio()
        playerControlButton.setImage(UIImage(named: "play-xx-blue"), for: .normal)
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            AudioPlayer.shared.nextAudio()
            self.playItem = AudioPlayer.shared.song
            self.populateUIData()
            self.stylePlayControlButton()
            self.containerView.layoutIfNeeded()
        }
    }
    @IBAction func dismissPlayer(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        guard let song = self.playItem else {
            return
        }
        delegate?.updateUI(song)

    }

    //MARK: UI
    private func styleUI() {
        self.containerView.applyShadowAndCorner()
        self.playerControlButton.applyShadow()
    }
    
    private func populateUIData() {
        guard let item = playItem else { return }
        playerTitleLabel.text = item.song
        artistNameLabel.text = item.artists
        playerCoverImageView.kf.setImage(with: URL(string: item.coverImage))
    }
    
    private func stylePlayControlButton() {
        guard AudioPlayer.shared.isPlaying else {
            playerControlButton.setImage(UIImage(named: "play-xx-blue"), for: .normal)
            return
        }
        playerControlButton.setImage(UIImage(named: "pause-xx-blue"), for: .normal)
    }
    
}
