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

//Find out how to pass in name of image and correct answer, then use that and a
// assets to load multiple tests in a row

var answerField : UITextField = UITextField(frame: CGRect(x: 0, y: 505, width: 150, height: 50))
var finishedButton: UIButton = UIButton(frame: CGRect(x: 200 - (100), y: 575, width: 200, height: 50))
var testText: String = "The quick brown fox jumped over the lazy dog. The slow, lazy dog sat under the jumping, quick brown fox."
class MobilityTypingTest : UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
    //        self.scrollView.contentSize = CGSize(width:2000, height: 5678)
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 150)
            self.scrollView.isScrollEnabled = true
            self.scrollView.contentOffset = CGPoint(x: view.frame.origin.x, y: view.frame.origin.y + 75)
            self.view.backgroundColor = UIColor.white
            
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
            answerField.textAlignment = .center
//            answerField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            
            
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
        let resultView = ResultView()
        var result = ""
        if(answerField.text == testText) {
            result = "Perfect!!"
        } else {
            result = "Fix your typing"
            resultView.steps = Resultdata[2]
        }
        resultView.result = result
        self.present(resultView, animated: true, completion: nil)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
//           if(answerField.text == "") {
//               finishedButton.isEnabled = false
//           }else {
//               finishedButton.isEnabled = true
//           }
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
