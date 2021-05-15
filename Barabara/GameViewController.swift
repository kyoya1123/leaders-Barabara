//
//  GameViewController.swift
//  Barabara
//
//  Created by Yamaguchi Kyoya on 2021/05/15.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView3: UIImageView!
    
    @IBOutlet var resultLabel: UILabel!
    
    var timer: Timer!
    var score = 1000
    let defaults = UserDefaults.standard
    
    let width = UIScreen.main.bounds.size.width
    var positionX: [CGFloat] = [0, 0, 0]
    var dx: [CGFloat] = [1, 0.5, -1]

    override func viewDidLoad() {
        super.viewDidLoad()
        positionX = [width/2, width/2, width/2]
        self.start()
        // Do any additional setup after loading the view.
    }
    
    func start() {
        resultLabel.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(up), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func up() {
        for i in 0..<3 {
            if positionX[i] > width || positionX[i] < 0 {
                dx[i] *= -1
            }
            positionX[i] += dx[i]
        }
        imageView1.center.x = positionX[0]
        imageView2.center.x = positionX[1]
    }
    
    @IBAction func stop() {
        if timer.isValid == true {
            timer.invalidate()
        }
        
        for i in 0..<3 {
            score = score - abs(Int(width/2 - positionX[i])) * 2
        }
        resultLabel.text = "Score: " + String(score)
        resultLabel.isHidden = false
        
        let highScore1 = defaults.integer(forKey: "score1")
        let highScore2 = defaults.integer(forKey: "score2")
        let highScore3 = defaults.integer(forKey: "score3")
        
        if score > highScore1 {
            defaults.set(score, forKey: "score1")
            defaults.set(highScore1, forKey: "score2")
            defaults.set(highScore2, forKey: "score3")
        } else if score > highScore2 {
            defaults.set(score, forKey: "score2")
            defaults.set(highScore2, forKey: "score3")
        } else if score > highScore3 {
            defaults.set(score, forKey: "score3")
        }
        defaults.synchronize()
    }
    
    @IBAction func retry() {
        score = 1000
        positionX = [width / 2, width / 2, width / 2]
        if timer.isValid == false {
            start()
        }
    }
    
    @IBAction func toTop() {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
