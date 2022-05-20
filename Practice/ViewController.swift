//
//  ViewController.swift
//  Practice
//
//  Created by Zhanagul on 10.04.2022.
//

import UIKit
import AVFoundation

enum Constants {
    static let message: String = "How do you like your eggs?"
    static let doneMessage: String = "DONE"
    static let soundName: String = "alarm_sound"
    static let soundType: String = "mp3"
}

final class ViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var progressBar: UIProgressView!
    
    // MARK: - Private Properties
    
    private var timer: Timer?
    private var player: AVAudioPlayer?
    private let eggSeconds: [String: Int] = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Actions

private extension ViewController {
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let currentSeconds = eggSeconds[sender.currentTitle!] else { return }
        reset()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateProgress(with: currentSeconds)
        }
    }
}

// MARK: - Private

private extension ViewController {
    
    func updateProgress(with currentSeconds: Int) {
        let result = 1.0 / Float(currentSeconds)
        progressBar.progress += result
        if progressBar.progress == 1 {
            timer?.invalidate()
            messageLabel.text = Constants.doneMessage
            playAlarm()
        }
    }
    
    func playAlarm() {
        guard let path = Bundle.main.path(forResource: Constants.soundName, ofType: Constants.soundType),
              let url = URL(string: path) else { return }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    func reset() {
        progressBar.progress = 0
        messageLabel.text = Constants.message
        timer?.invalidate()
    }
}



