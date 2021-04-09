//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Dino Martan on 08/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

protocol PlayerViewControllerDelegate: AnyObject {
    
    func didTapPlayPauseButton()
    func didTapNextButton()
    func didTapPreviousButton()
    func didChangeSlider(value: Float)
    
}

class PlayerViewController: UIViewController {
    
    //MARK: - IBOutlets

    @IBOutlet private weak var trackImageView: UIImageView!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var playPauseButton: UIButton!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var volumeSlider: UISlider!
    
    //MARK: - Public properties
    
    weak var dataSource: PlayerDataSource?
    weak var delegate: PlayerViewControllerDelegate?
    
    //MARK: - Private properties
    
    private var trackIsPlaying = true
    private let playImage = UIImage(systemName: "pause.fill")
    private let pauseImage = UIImage(systemName: "play.fill")
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        trackIsPlaying = true
        configureUI()
    }
    
    private func setupView() {
        //configureUI()
    }
    
    func configureUI() {
        guard let image = dataSource?.imageUrl else { return }
        trackImageView.sd_setImage(with: image, completed: nil)
        trackNameLabel.text = dataSource?.songName
        artistNameLabel.text = dataSource?.subtitle
        configurePlayPauseButton()
    }
    
}

//MARK: - Private extensions -

private extension PlayerViewController {
    
    private func stopPlaying() {
        trackIsPlaying = false
    }
    
    private func startPlaying() {
        trackIsPlaying = true
    }
    
    private func configurePlayPauseButton() {
        if trackIsPlaying { playPauseButton.setImage(playImage, for: .normal) }
        else { playPauseButton.setImage(pauseImage, for: .normal) }
    }
    
}

//MARK: - IBActions -

//MARK: - Player

private extension PlayerViewController {
    
    @IBAction private func didTapPlayPauseButton(_ sender: Any) {
        if trackIsPlaying { stopPlaying() }
        else { startPlaying() }
        configurePlayPauseButton()
        delegate?.didTapPlayPauseButton()
    }
    
    @IBAction private func didTapPreviousButton(_ sender: Any) {
        delegate?.didTapPreviousButton()
    }
    
    @IBAction private func didTapNextButton(_ sender: Any) {
        delegate?.didTapNextButton()
    }
    
    @IBAction func didChangeSlider(_ sender: Any) {
        delegate?.didChangeSlider(value: volumeSlider.value)
    }
    
}


//MARK: - Navigation

private extension PlayerViewController {
    
    @IBAction private func didTapExitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func didTapShareButton(_ sender: Any) {
        // to do - share
    }
    
}