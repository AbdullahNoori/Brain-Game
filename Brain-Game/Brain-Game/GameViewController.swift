//
//  GameViewController.swift
//  Brain-Game
//
//  Created by abdul  on 3/3/20.
//  Copyright © 2020 Makeschool. All rights reserved.

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    
    var timer: Timer?
    
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel?
    @IBOutlet weak var colorTextLabel: UILabel!
    @IBOutlet weak var colorLabelBox: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    var highScore: Int = 0
    var timerCount: Int = 10
    var message: String = "Game Over!"
    
    let colors:[String:UIColor] = [
        "red": .red,
        "green": .green,
        "yellow": .yellow,
        "black": .black,
        "blue": .blue,
    ]
        

    var score: Int = 0
    
    var colorText: String = ""
    var color: UIColor = .white
    var randomColorText: String = ""
    
    @IBOutlet weak var color2Label: UILabel!
    
    // view will appear
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       // hide navbar
       navigationController?.setNavigationBarHidden(true, animated: animated)
        if let resultImage = resultImageView {
            resultImage.isHidden = true
        }
        playAgainButton?.isHidden = true
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        runTimer()

    }
        
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func updateGame(){
    
        scoreLabel.text = "Score "+String(score)

        colorText = colors.randomElement()!.key
        color = colors.randomElement()!.value

        self.colorTextLabel.text = colorText
        self.colorLabelBox.backgroundColor = color
        
    }
    
// pass high score to result view
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "gameResult" {
           if let resultViewController = segue.destination as? GameResultViewController {
                   resultViewController.highScore = self.highScore
                   resultViewController.message = self.message
               
           }
       }
   }
    
    
    @IBAction func yesButtonAction(_ sender: Any) {
        if (colors[colorText] == color) {
            score += 10
            timerCount = 10
        }
        else {
            score -= 10
        }

        self.updateGame()
    }
    @IBAction func noButtonAction(_ sender: Any) {
        if (colors[colorText] == color) {
            score -= 10

        }
        else {
            score += 10
            timerCount = 10
        }

        self.updateGame()

    }
    
    func showGameOver() {
        noButton?.isHidden = true
        yesButton?.isHidden = true
        
        colorTextLabel?.isHidden = true
        colorLabelBox?.isHidden = true
//        scoreLabel?.isHidden = true
        messageLabel?.isHidden = true
        
        if let resultImage = resultImageView {
            if score < 0 {
                resultImage.image = UIImage(named: "lose.png")!
            }
            else {
                resultImage.image = UIImage(named: "win.png")!
            }
            resultImage.isHidden = false
        }
        playAgainButton?.isHidden = false
    }

    
    func runTimer() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            self.timerCount -= 1
            
            if let label = self.timerLabel {
                label.text = "Timer "+String(self.timerCount)
            }
            
            if self.timerCount == 0 {
                self.timerCount = 0
                timer.invalidate()
                self.showGameOver()

            }
                        
        }
    }

}
