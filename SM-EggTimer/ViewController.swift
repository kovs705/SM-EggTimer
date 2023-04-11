//
//  ViewController.swift
//  SM-EggTimer
//
//  Created by Kovs on 10.04.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    // var secondsRemaining = 60
    var timer = Timer()
    
    var player = AVAudioPlayer()
    
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timeText: UILabel!
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        
        timer.invalidate()
        // updates the timer
        let hardness = sender.currentTitle!
        // takes the number from each egg
        totalTime = eggTimes[hardness]!
        // puts this number in totalTime
        
        progressBar.progress = 0.0
        secondsPassed = 0
        // updates progress bar and seconds
        timeText.text = hardness
        // shows the chosen egg above
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        // timer that uses @objc function each second and repeats until the end in function
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            timeText.text = "DONE!"
            playAlarm(soundName: "alarm_sound")
        }
    }
    
    func playAlarm(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    // soft egg - 5 min
    // medium egg - 8 min
    // hard egg - 12 min
}

