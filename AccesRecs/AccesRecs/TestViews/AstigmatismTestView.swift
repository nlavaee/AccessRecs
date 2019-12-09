//
//  AstigmatismTestView.swift
//  AccesRecs
//
//  Created by Amaris Sim on 11/24/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import Foundation
import UIKit

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
        resultView.resultType = "Vision"

        navigationController?.popViewController(animated: false)

        self.present(resultView, animated: true, completion: nil)
    }
    
    @objc func sawDiff(sender: UIButton!) {
        let resultView = ResultView()
        var result = ""
        result = "We have recommendations for you:"
        let recsRequest = RecsRequest(featid:6)
        recsRequest.displayRecs(resultView: resultView)
        resultView.result = result
        resultView.resultType = "Vision"

        navigationController?.popViewController(animated: false)

              self.present(resultView, animated: true, completion: nil)
    }
}

