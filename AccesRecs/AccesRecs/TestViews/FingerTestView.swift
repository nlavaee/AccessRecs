//
//  FingerTestView.swift
//  AccesRecs
//
//  Created by Amaris Sim on 11/24/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import Foundation
import UIKit


class FingersViewController : UIViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        let sentenceLabel : UILabel = UILabel()
        let testImage = UIImage(named: "fingers")
        let testImageView = UIImageView(image: testImage!)
        testImageView.frame = CGRect(x: 0, y: self.view.frame.height / 4 + 20, width: 433, height: 324)
        sentenceLabel.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 100)
        sentenceLabel.center = self.view.center
        sentenceLabel.center.x = self.view.center.x
        sentenceLabel.center.y = 130
        sentenceLabel.textAlignment = .center
        sentenceLabel.lineBreakMode = .byWordWrapping
        sentenceLabel.numberOfLines = 0
        sentenceLabel.text = "How many fingers am I holding up?"
        sentenceLabel.textColor = UIColor.black
        self.view.addSubview(sentenceLabel)
        self.view.addSubview(testImageView)
        let button1 = UIButton(frame: CGRect(x: self.view.frame.width - 325, y: self.view.frame.height - 125, width: 100, height: 100))
        let button2 = UIButton(frame: CGRect(x: self.view.frame.width - 150, y: self.view.frame.height - 125, width: 100, height: 100))
        let button3 = UIButton(frame: CGRect(x: self.view.frame.width - 150, y: self.view.frame.height - 250, width: 100, height: 100))
        let button4 = UIButton(frame: CGRect(x: self.view.frame.width - 325, y: self.view.frame.height - 250, width: 100, height: 100))
        button1.setTitle("4", for: .normal)
        button2.setTitle("5", for: .normal)
        button3.setTitle("3", for: .normal)
        button4.setTitle("2", for: .normal)
        button1.addTarget(self, action: #selector(wrongAnswer), for: .touchUpInside)
        button2.addTarget(self, action: #selector(wrongAnswer), for: .touchUpInside)
        button3.addTarget(self, action: #selector(rightAnswer), for: .touchUpInside)
        button4.addTarget(self, action: #selector(wrongAnswer), for: .touchUpInside)
        button1.backgroundColor = UIColor.blue
        button2.backgroundColor = UIColor.blue
        button3.backgroundColor = UIColor.blue
        button4.backgroundColor = UIColor.blue
        button1.layer.cornerRadius = 20
        button2.layer.cornerRadius = 20
        button3.layer.cornerRadius = 20
        button4.layer.cornerRadius = 20
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
        self.view.addSubview(button4)
        
    }
    @objc func rightAnswer(sender: UIButton!) {
        let result = "Good job!"
        let resultView = ResultView()
        resultView.result = result
        resultView.resultType = "Vision"

        navigationController?.popViewController(animated: false)

        self.present(resultView, animated: true, completion: nil)
    }
    
    @objc func wrongAnswer(sender: UIButton!) {
        let wrongAnswerView = WrongAnswer()
        self.present(wrongAnswerView, animated: true, completion: nil)
    }
}

class WrongAnswer : UIViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        let testImage = UIImage(named: "fingers2")
        let testImageView = UIImageView(image: testImage!)
        testImageView.frame = CGRect(x: 0, y: self.view.frame.height / 4 + 20, width: self.view.frame.width, height: self.view.frame.height / 3)
        self.view.addSubview(testImageView)

    }
}
