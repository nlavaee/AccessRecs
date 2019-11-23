//
//  TestView.swift
//  AccesRecs
//
//  Created by Daniel Haines on 10/9/19.
//  Copyright © 2019 Daniel Haines. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class LargeTextTestViewController : UIViewController {
    var sentenceLabel : UILabel = UILabel()
    var textSize : Int = 4 {
        didSet {
            sentenceLabel.font = .systemFont(ofSize: CGFloat(textSize))
        }
    }
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        sentenceLabel.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200)
        sentenceLabel.center = self.view.center
        sentenceLabel.center.x = self.view.center.x
        sentenceLabel.center.y = self.view.center.y - 50
        sentenceLabel.textAlignment = .center
        sentenceLabel.lineBreakMode = .byWordWrapping
        sentenceLabel.numberOfLines = 0
//        sentenceLabel.sizeToFit()
        sentenceLabel.text = "This is a sentence."
        sentenceLabel.textColor = UIColor.black
        sentenceLabel.font = .systemFont(ofSize: CGFloat(textSize))
        
        let prompt = UILabel(frame: CGRect(x: 0, y: 75, width: view.frame.size.width, height: 100))
        prompt.center.x = self.view.center.x
        prompt.textAlignment = .center
        prompt.textColor = UIColor.black
        prompt.font = .systemFont(ofSize: 24.0)
        prompt.text = "Can you easily read the text below?"
        
        
        // screen is 667 & 375
        let yesButton = UIButton(frame: CGRect(x: self.view.frame.width - 50 - 250 - 25, y: self.view.frame.height - 200, width: 100, height: 100))
        let noButton = UIButton(frame: CGRect(x: self.view.frame.width - 50 - 100, y: self.view.frame.height - 200, width: 100, height: 100))
        yesButton.setTitle("Yes", for: .normal)
        noButton.setTitle("No", for: .normal)
        noButton.addTarget(self, action: #selector(cantRead), for: .touchUpInside)
        yesButton.addTarget(self, action: #selector(canRead), for: .touchUpInside)
        noButton.backgroundColor = UIColor.red
        yesButton.backgroundColor = UIColor.green
        noButton.layer.cornerRadius = 20
        yesButton.layer.cornerRadius = 20
        
        
        self.view.addSubview(sentenceLabel)
        self.view.addSubview(prompt)
        self.view.addSubview(yesButton)
        self.view.addSubview(noButton)
        

        
    }
    
    @objc func canRead(sender: UIButton!) {
        let resultView = ResultView()
        var result = ""
        if(textSize > 18) {
            result = "You might want to increase the text size on your phone"
            resultView.steps = Resultdata[1]
        } else {
            result = "You don't need to increase the text size on your phone"
        }
        resultView.result = result
//        let resultCtrl = UIHostingController(rootView: resultView)
//        navigationController?.pushViewController(resultView, animated: true)
//        _ = navigationController?.popViewController(animated: false)
//        let navController = UINavigationController(rootViewController: resultView) // Creating a navigation controller with VC1 at the root of the navigation stack.
//        let x_button = UIImage(named: "x_button")
//
//        navController.navigationBar.backIndicatorImage = x_button
//        navController.navigationBar.backIndicatorTransitionMaskImage = x_button
//        navController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: #selector(dismissView))
//        navController.isNavigationBarHidden = false
//
//
//        self.present(navController, animated:true, completion: nil)
        navigationController?.popViewController(animated: false)
//        navigationController?.pushViewController(resultView, animated: false)
//        self.show(resultView, sender: nil)
        self.present(resultView, animated: true, completion: nil)
        

//        resultView.navigationController?.isToolbarHidden = true
        
    }
    
    @objc func cantRead(sender: UIButton!) {
        textSize += 2
    }
    
    @objc func dismissView(sender: UIButton!) {
        
        self.dismiss(animated: false, completion: nil)
    }
}

class GridViewController : UIViewController {
    override func viewDidLoad() {
        let sentenceLabel : UILabel = UILabel()
        let testImage = UIImage(named: "amslerGrid")
        let testImageView = UIImageView(image: testImage!)
        testImageView.frame = CGRect(x: 0, y: self.view.frame.height / 4, width: self.view.frame.width, height: self.view.frame.height / 2)

            self.view.backgroundColor = UIColor.white
            sentenceLabel.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 50)
            sentenceLabel.center = self.view.center
            sentenceLabel.center.x = self.view.center.x
            sentenceLabel.center.y = 130
            sentenceLabel.textAlignment = .center
            sentenceLabel.lineBreakMode = .byWordWrapping
            sentenceLabel.numberOfLines = 0
    //        sentenceLabel.sizeToFit()
            sentenceLabel.text = "Stare at the dot for 30 seconds...\n Did you see any curved or blurry lines?"
            sentenceLabel.textColor = UIColor.black
            //sentenceLabel.font = .systemFont(ofSize: CGFloat(textSize))
        
        
        let yesButton = UIButton(frame: CGRect(x: self.view.frame.width - 325, y: self.view.frame.height - 125, width: 100, height: 100))
        let noButton = UIButton(frame: CGRect(x: self.view.frame.width - 150, y: self.view.frame.height - 125, width: 100, height: 100))
        yesButton.setTitle("Yes", for: .normal)
        noButton.setTitle("No", for: .normal)
        noButton.addTarget(self, action: #selector(noBlurs), for: .touchUpInside)
        yesButton.addTarget(self, action: #selector(sawBlurs), for: .touchUpInside)
        noButton.backgroundColor = UIColor.red
        yesButton.backgroundColor = UIColor.blue
        noButton.layer.cornerRadius = 20
        yesButton.layer.cornerRadius = 20
        
        self.view.addSubview(sentenceLabel)
        self.view.addSubview(testImageView)
        self.view.addSubview(yesButton)
        self.view.addSubview(noButton)
    }
    
    @objc func noBlurs(sender: UIButton!) {
        let resultView = ResultView()
        let result = "We have no recommendations for you!"
        resultView.result = result
        self.present(resultView, animated: true, completion: nil)
    }
    
    @objc func sawBlurs(sender: UIButton!) {
        let resultView = ResultView()
               var result = ""
              result = "We have recommendations for you:"
              resultView.steps = Resultdata[4]
              resultView.result = result
              self.present(resultView, animated: true, completion: nil)
    }
}

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

class AstigmatismViewController : UIViewController {
    override func viewDidLoad() {
        let sentenceLabel : UILabel = UILabel()
        let testImage = UIImage(named: "stigma")
        let testImageView = UIImageView(image: testImage!)
        testImageView.frame = CGRect(x: 0, y: self.view.frame.height / 4 + 20, width: self.view.frame.width, height: self.view.frame.height / 2)

            self.view.backgroundColor = UIColor.white
            sentenceLabel.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 100)
            sentenceLabel.center = self.view.center
            sentenceLabel.center.x = self.view.center.x
            sentenceLabel.center.y = 130
            sentenceLabel.textAlignment = .center
            sentenceLabel.lineBreakMode = .byWordWrapping
            sentenceLabel.numberOfLines = 0
    //        sentenceLabel.sizeToFit()
            sentenceLabel.text = "Cover your left eye and look at the image\nNext, cover your right eye\n\nAre some lines lighter than others?"
            sentenceLabel.textColor = UIColor.black
            //sentenceLabel.font = .systemFont(ofSize: CGFloat(textSize))
        
        
        let yesButton = UIButton(frame: CGRect(x: self.view.frame.width - 325, y: self.view.frame.height - 125, width: 100, height: 100))
        let noButton = UIButton(frame: CGRect(x: self.view.frame.width - 150, y: self.view.frame.height - 125, width: 100, height: 100))
        yesButton.setTitle("Yes", for: .normal)
        noButton.setTitle("No", for: .normal)
        noButton.addTarget(self, action: #selector(noDiff), for: .touchUpInside)
        yesButton.addTarget(self, action: #selector(sawDiff), for: .touchUpInside)
        noButton.backgroundColor = UIColor.red
        yesButton.backgroundColor = UIColor.blue
        noButton.layer.cornerRadius = 20
        yesButton.layer.cornerRadius = 20
        
        self.view.addSubview(sentenceLabel)
        self.view.addSubview(testImageView)
        self.view.addSubview(yesButton)
        self.view.addSubview(noButton)
        self.view.bringSubviewToFront(sentenceLabel)
    }
    
    @objc func noDiff(sender: UIButton!) {
        let resultView = ResultView()
        let result = "We have no recommendations for you!"
        resultView.result = result
        self.present(resultView, animated: true, completion: nil)
    }
    
    @objc func sawDiff(sender: UIButton!) {
        let resultView = ResultView()
               var result = ""
              result = "We have recommendations for you:"
              resultView.steps = Resultdata[5]
              resultView.result = result
              self.present(resultView, animated: true, completion: nil)
    }
}

