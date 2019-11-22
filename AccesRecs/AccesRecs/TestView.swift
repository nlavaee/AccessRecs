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
        _ = navigationController?.popViewController(animated: false)
        self.present(resultView, animated: true, completion: nil)
    }
    
    @objc func cantRead(sender: UIButton!) {
        textSize += 2
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

