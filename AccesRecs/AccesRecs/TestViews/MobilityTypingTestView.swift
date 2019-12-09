//
//  MobilityTestView.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 11/3/19.
//  Copyright © 2019 Daniel Haines. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import FuzzyMatchingSwift

var testTextList = ["The quick brown fox jumped over the lazy dog.", "I love eating toasted cheese and tuna sandwiches.", "He didn’t want to go to the dentist, yet he went anyway.", "Last Friday I saw a spotted striped blue worm", "They got there early, and they got really good seats.", "I really want to go to work, but I am too sick to drive.", "We have a lot of rain in June.", "She was too short to see over the fence.", "I'd rather be a bird than a fish.", "It was getting dark, and we weren’t there yet.", "The book is in front of the table."]

//Find out how to pass in name of image and correct answer, then use that and a
// assets to load multiple tests in a row

var answerField : UITextField = UITextField(frame: CGRect(x: 0, y: 505, width: 150, height: 50))
var finishedButton: UIButton = UIButton(frame: CGRect(x: 200 - (100), y: 575, width: 200, height: 50))
var start = DispatchTime.now()
var finish = DispatchTime.now()
// In the future, we should randomly generate a list of phrases that the user can type in.
// If the text appears the same, but registers as incorrect, check if any escape characters were automatically added into one of the strings (' vs \')
var id:Int = Int.random(in: 0 ..< testTextList.count)
var testText: String = testTextList[id]
var testTimer: Timer = Timer()
class MobilityTypingTest : UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        override func viewDidLoad() {
            
            super.viewDidLoad()
    //        self.scrollView.contentSize = CGSize(width:2000, height: 5678)
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 150)
            self.scrollView.isScrollEnabled = true
            self.scrollView.contentOffset = CGPoint(x: view.frame.origin.x, y: view.frame.origin.y + 75)
            self.view.backgroundColor = UIColor.white
            
            //start = DispatchTime.now()
            
            
            id = Int.random(in: 0 ..< testTextList.count)
            testText = testTextList[id]
            let prompt = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 100, y: 50, width: 200, height: 100))
            prompt.textColor = UIColor.black
            prompt.font = .preferredFont(forTextStyle: UIFont.TextStyle.title3)
            prompt.text = "Type the following text:"
            prompt.lineBreakMode = .byWordWrapping
            prompt.numberOfLines = 0
            prompt.textAlignment = .center
            prompt.adjustsFontSizeToFitWidth = true
            
            
            //let temp = Testdata
            let text = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 100, y: prompt.frame.maxY + 50, width: 200, height: 150))
            text.textColor = UIColor.black
            text.font = .preferredFont(forTextStyle: UIFont.TextStyle.title3)
            text.text = testText
            text.lineBreakMode = .byWordWrapping
            text.numberOfLines = 0
            text.textAlignment = .center
            text.adjustsFontSizeToFitWidth = true
            
            answerField = UITextField(frame: CGRect(x: 0, y: 505, width: 150, height: 50))
            answerField.frame = CGRect(x: self.view.frame.width / 2 - 75, y: self.view.frame.height / 2 + prompt.frame.height + 10, width: 150, height: 50)
            answerField.delegate = self
            answerField.borderStyle = UITextField.BorderStyle.line
            answerField.layer.borderColor = UIColor.gray.cgColor
            answerField.autocorrectionType = .no
            answerField.textAlignment = .center
            answerField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.touchDown)
            
            
            finishedButton.setTitle("Done", for: .normal)
            finishedButton.addTarget(self, action: #selector(DoneTyping), for: .touchUpInside)
            finishedButton.backgroundColor = UIColor.red
            finishedButton.layer.cornerRadius = 20
            finishedButton.frame = CGRect(x: self.view.frame.width / 2 - 100, y:self.view.frame.height / 2 + 200, width: 200, height: 50)
            //finishedButton.isEnabled = false
            
            
            self.view.addSubview(prompt)
            self.view.addSubview(text)
            self.view.addSubview(answerField)
            self.view.addSubview(finishedButton)
            
            
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillOpen(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillClose(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillOpen(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func DoneTyping(sender: UIButton!) {
        self.hideKeyboard()
        finish = DispatchTime.now()
        let resultView = ResultView()
        var result = ""

        let threshold = 0.05
        // Compute time to take test in seconds
        let totalTime = ((finish.uptimeNanoseconds - start.uptimeNanoseconds) / 1000000000)
        let score = computeScore()
        
        if(score.isLess(than: threshold) && totalTime < 60) {
            result = "Perfect!!"
                    } else {
            result = "We have recommendations for you:"
            let recsRequest = RecsRequest(featid:24)
            recsRequest.displayRecs(resultView: resultView)
            
//                let group = DispatchGroup()
//
//                group.enter()
//
//                recsRequest.getRecs{
//                    result in
//                    switch result {
//                    case .failure(let error):
//                        print(error)
//                    case.success(let recs):
//                        resultView.recs = recs.map({ $0.rec_name })
//                        group.leave()
//                    }
//                }
//                group.wait()
        }
        
        resultView.result = result
        resultView.resultType = "Motion"

        navigationController?.popViewController(animated: false)

        self.present(resultView, animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
           if(answerField.text == "") {
                start = DispatchTime.now()
            testTimer = Timer.scheduledTimer(timeInterval: 90, target: self, selector: #selector(self.DoneTyping), userInfo: nil, repeats: false)
           }
       }

    func computeScore() -> Double {
        var score = 0.0
        
        // Checking user answer is within ~15% of the length of the real answer
        if(abs(testText.count - answerField.text!.count) > (testText.count / 7)) {
            score = 1.0
        } else {
            score = Double(testText.confidenceScore(answerField.text!)! )
        }
        
        return score
    }
    
    func hideKeyboard() {
        answerField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        answerField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillOpen(notification: Notification) {
        view.frame.origin.y = -75
    }
    
    @objc func keyboardWillClose(notification: Notification) {
        view.frame.origin.y = 0
    }
}
