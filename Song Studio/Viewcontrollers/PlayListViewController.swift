//
//  ViewController.swift
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//

import UIKit

class PlayListViewController: UIViewController {

    @IBOutlet weak var playListTableView: UITableView!
    @IBOutlet weak var miniPlayerView: UIView!
    @IBOutlet weak var miniPlayerCoverImageView: UIImageView!
    @IBOutlet weak var miniPlayerTitleLabel: UILabel!
    @IBOutlet weak var miniPlayerArtistNameLabel: UILabel!
    @IBOutlet weak var miniPlayerControlButton: UIButton!
    
    var playlist: [Song] = []
    var selectedItem: Song?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(getSongs), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playListTableView.refreshControl = refreshControl
        getSongs()
        styleUI()
        styleControlButton()
    }
    
    //MARK: UI Styles & Data
    private func styleUI() {
        miniPlayerView.applyShadowAndCorner()
    }
    
    private func populateMiniPlayerData(_ playItem: Song) {
        miniPlayerView.isHidden = false
        miniPlayerTitleLabel.text = playItem.song
        miniPlayerArtistNameLabel.text = playItem.artists
        miniPlayerCoverImageView.kf.setImage(with: URL(string: playItem.coverImage))
    }
    
    private func styleControlButton() {
        guard AudioPlayer.shared.isPlaying else {
            miniPlayerControlButton.setImage(UIImage(named: "play-blue"), for: .normal)
            return
        }
        miniPlayerControlButton.setImage(UIImage(named: "pause-blue"), for: .normal)
    }
    
    //MARK: Load View
    private func presentPlayer(with song: Song){
        let playerVC = storyboard?.instantiateViewController(withIdentifier: "playerViewController") as! PlayerViewController
        playerVC.playlist = playlist
        playerVC.playItem = song
        playerVC.delegate = self
        playerVC.modalPresentationStyle = .overCurrentContext
        self.present(playerVC, animated: true, completion: nil)
    }
    
    
    private func presentSubscibtionVC() {
        let purchaseVC = storyboard?.instantiateViewController(withIdentifier: "purchaseViewController") as! PurchaseViewController
        purchaseVC.delegate = self
        self.present(purchaseVC, animated: true, completion: nil)
    }
    
    //MARK: Subscription
    private func verifySubscriptionStatus() -> Bool {
        guard DefaultWrapper().isSubscribed() else {
            return false
        }
        return true
    }
    
    //MARK: Gesture & Button actions
    @IBAction func miniPlayerControlTapped(_ sender: UIButton) {
        guard AudioPlayer.shared.isPlaying else {
            AudioPlayer.shared.playAudio()
            miniPlayerControlButton.setImage(UIImage(named: "pause-blue"), for: .normal)
            return
        }
        AudioPlayer.shared.pauseAudio()
        miniPlayerControlButton.setImage(UIImage(named: "play-blue"), for: .normal)
    }
    
    @IBAction func miniPlayerGestureTapped(_ sender: UITapGestureRecognizer) {
        guard let song = AudioPlayer.shared.song else { return  }
        self.presentPlayer(with: song)
    }
    

    //MARK: Webservice
    @objc private func getSongs() {
        StudioSongManager().getSongs { (response) in
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                
                switch response {
                    
                case .success(let songs):
                    self.playlist = songs
                    AudioPlayer.shared.setPlaylist(songs)
                    self.playListTableView.reloadData()
                    
                case .failure(let error):
                    print("Error: ", error)
                }
            }
        }
    }
}

//MARK: Table view Data Source
extension PlayListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playListItemCell", for: indexPath) as! PlayListItemCell
        cell.coverImageUrl = playlist[indexPath.row].coverImage
        cell.playListName = playlist[indexPath.row].song
        cell.artistName = playlist[indexPath.row].artists
        return cell
    }
}

//MARK: Table view Delegate
extension PlayListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "header") as! HeaderCell
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = playlist[indexPath.row]
        guard verifySubscriptionStatus() else {
            presentSubscibtionVC()
            return
        }
        populateMiniPlayerData(playlist[indexPath.row])
        AudioPlayer.shared.setUpPlayer(playlist[indexPath.row])
        styleControlButton()
    }
}

//MARK: Player delegate
extension PlayListViewController: PlayerUIDelegate {
    func updateUI(_ playItem: Song) {
        DispatchQueue.main.async {
            self.populateMiniPlayerData(playItem)
            self.styleControlButton()
        }
        
    }
}

//MARK: Purchase Delegate
extension PlayListViewController: PurchaseDelegate {
    func didPurchased() {
        guard let playItem = selectedItem else { return  }
        populateMiniPlayerData(playItem)
        AudioPlayer.shared.setUpPlayer(playItem)
        styleControlButton()
    }
    
}
