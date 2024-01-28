//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 4, "Medium":7, "Hard":12 ]
    var totalTimes = 0
    var secondPassed = 0
    var player: AVAudioPlayer!
    
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var timer = Timer()

    @IBAction func onPressed(_ sender: UIButton) {
        
        timer.invalidate()
        // title of the button
        let hardness = sender.currentTitle!
        totalTimes = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondPassed = 0
        statusText.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
    }
    
    @objc func updateTimer(){
        if secondPassed < totalTimes {
            secondPassed += 1
            progressBar.progress = Float(secondPassed) / Float(totalTimes)
        } else {
            onceItDone()
        }
      
    }
    
    func onceItDone(){
        timer.invalidate()
        statusText.text = "Finish"
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
