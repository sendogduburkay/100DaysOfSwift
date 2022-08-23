//
//  ViewController.swift
//  Project2
//
//  Created by Muhammed Burkay Şendoğdu on 19.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var barButton: UIBarButtonItem!
    var countries = [String]()
    var score = 0{
        didSet{
            barButton.title = "Score: \(score)"
        }
    }
    var correctAnswer = 0
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Show Score", style: .done, target: self, action: #selector(showScore))
        
        button1.addBorder(color: .black, width: 1)
        button2.addBorder(color: .black, width: 1)
        button3.addBorder(color: .black, width: 1)
        
        askQuestion()
    }
    
    @objc func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = "\(countries[correctAnswer].uppercased())"
    
    }
    @objc func restartGame(action: UIAlertAction! = nil){
        score = 0
        counter = 0
        askQuestion()
    }
    
    @objc func showScore(){
        let ac = UIAlertController(title: nil, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
    
    func checkQuestion(title: String){
        if counter == 5{
            let ac = UIAlertController(title: "Final!", message: "Your score is: \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart Game", style: .default, handler: restartGame(action:)))
            present(ac,animated: true)
        }
        else{
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default,handler: askQuestion))
            present(ac,animated: true)
        }
    }

    /* Bir önceki projenin içinde async ile delay atılmış orayı da incelemekte fayda var!*/
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String = ""
        UIView.animate(withDuration: 1, delay: 0, options: []) {
            sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        } completion: { finishedFirst in
            UIView.animate(withDuration: 1, delay: 0, options: []) {
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: { finishedSecond in
                self.counter += 1
                if sender.tag == self.correctAnswer{
                        title = "Correct Answer"
                        self.score += 1
                    self.checkQuestion(title: title)
                        }
                        else{
                            title = "Wrong Answer! That's flag of \(self.countries[sender.tag].uppercased())"
                            self.score -= 1
                            self.checkQuestion(title: title)
                        }
            }
        }
    }
} /* class bitişi*/




extension UIButton{
    func addBorder(color: UIColor,width: CGFloat){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        
    }
    
}

