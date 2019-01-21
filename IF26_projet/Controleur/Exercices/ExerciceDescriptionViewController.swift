//
//  ExerciceDescriptionViewController.swift
//  IF26_projet
//
//  Created by Tom Hache on 19/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit

class ExerciceDescriptionViewController: UIViewController {

    var seconds = 60 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false
    var test = 0
    
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var imageExo: UIImageView!
    @IBOutlet weak var titreExo: UILabel!
    @IBOutlet weak var serie: UILabel!
    @IBOutlet weak var reps: UILabel!
    
    @IBOutlet weak var descriptionExo: UITextView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
          imageExo?.image = UIImage(named: (exerciceArray[indexDescription].getTitle() + ".jpg"))
        titreExo?.text = exerciceArray[indexDescription].getTitle()
        descriptionExo?.text = exerciceArray[indexDescription].getDescription()
        serie?.text = String(exerciceArray[indexDescription].getSerie())
        reps?.text = String(exerciceArray[indexDescription].getRepetition())
        timerButton.setTitle( "\(seconds)" , for: .normal)
        
    }
    
    @IBAction func startTimerButton(_ sender: UIButton) {
        
        if(test == 0){
            runTimer()
            test = test + 1
        }
        else{
            timer.invalidate()
            seconds = 60
            test = 0
            timerButton.setTitle( "\(seconds)" , for: .normal)//This will update the label.
        }
        
    }
    
    func runTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1,
    target: self,
    selector: #selector(updateTimer),
    userInfo: nil,
    repeats: true)
    }
    
    @objc func updateTimer() {
        if(seconds > 0){
        seconds -= 1     //This will decrement(count down)the seconds.
        timerButton.setTitle( "\(seconds)" , for: .normal)//This will update the label.
       print(seconds)
        }
        else{
            timer.invalidate()
            seconds = 60
            test = 0
            timerButton.setTitle( "\(seconds)" , for: .normal)//This will update the label.
        }
    }

}
