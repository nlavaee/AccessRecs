//
//  LargeTextTestView.swift
//  AccesRecs
//
//  Created by Amaris Sim on 11/24/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import Foundation
import UIKit

class LargeTextTestViewController : UIViewController {
    var sentenceLabel : UILabel = UILabel()
    var textSize : Int = 4 {
        didSet {
            sentenceLabel.font = .systemFont(ofSize: CGFloat(textSize))
        }
    }
    
    override func viewDidLoad() {
        if traitCollection.userInterfaceStyle == .dark{
            self.view.backgroundColor = UIColor.black

        }
        else{
            self.view.backgroundColor = UIColor.white

        }
        
        sentenceLabel.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200)
        sentenceLabel.center = self.view.center
        sentenceLabel.center.x = self.view.center.x
        sentenceLabel.center.y = self.view.center.y - 50
        sentenceLabel.textAlignment = .center
        sentenceLabel.lineBreakMode = .byWordWrapping
        sentenceLabel.numberOfLines = 0
        sentenceLabel.text = "This is a sentence."
        
        if traitCollection.userInterfaceStyle == .dark{
            sentenceLabel.textColor = UIColor.white
        }
        else{
            sentenceLabel.textColor = UIColor.black
        }
        sentenceLabel.font = .systemFont(ofSize: CGFloat(textSize))
        
        let prompt = UILabel(frame: CGRect(x: 0, y: 75, width: view.frame.size.width, height: 100))
        prompt.center.x = self.view.center.x
        prompt.textAlignment = .center
        

        prompt.font = .systemFont(ofSize: 30.0)
        prompt.text = "Can you easily read the text below?"
        
        if traitCollection.userInterfaceStyle == .dark{
            prompt.textColor = UIColor.white
        }
        else{
            prompt.textColor = UIColor.black
        }
        prompt.lineBreakMode = .byWordWrapping
        prompt.numberOfLines = 0
        
        // screen is 667 & 375
        let yesButton = UIButton(frame: CGRect(x: self.view.frame.width - 50 - 250 - 25, y: self.view.frame.height - 200, width: 100, height: 100))
        let noButton = UIButton(frame: CGRect(x: self.view.frame.width - 50 - 100, y: self.view.frame.height - 200, width: 100, height: 100))
        yesButton.setTitle("Yes", for: .normal)
        yesButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        noButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        noButton.setTitle("No", for: .normal)
        noButton.addTarget(self, action: #selector(cantRead), for: .touchUpInside)
        yesButton.addTarget(self, action: #selector(canRead), for: .touchUpInside)
        noButton.backgroundColor = UIColor.red
        yesButton.backgroundColor = UIColor.systemGreen
        noButton.layer.cornerRadius = 20
        yesButton.layer.cornerRadius = 20
        
        
        self.view.addSubview(sentenceLabel)
        self.view.addSubview(prompt)
        self.view.addSubview(yesButton)
        self.view.addSubview(noButton)
        
    }
    
    @objc func canRead(sender: UIButton!) {
        let resultView = ResultView()
        resultView.resultType = "Vision"
        var result = ""
        
        //api request
        let recsRequest = RecsRequest(featid:5)
        
        // async call (wait till data is recieved)
        recsRequest.displayRecs(resultView: resultView)
        
        
        if(textSize > 18) {
            result = "You might want to increase the text size on your phone"
        } else {
            result = "You don't need to increase the text size on your phone"
            resultView.recs = [String]()
        }
        resultView.result = result

        navigationController?.popViewController(animated: false)

        self.present(resultView, animated: true, completion: nil)
        
    }
    
    @objc func cantRead(sender: UIButton!) {
        if(textSize < 48) {
            textSize += 2
        }
        else {
            canRead(sender: UIButton())
        }
    }
    
    @objc func dismissView(sender: UIButton!) {
        
        self.dismiss(animated: false, completion: nil)
    }
}
