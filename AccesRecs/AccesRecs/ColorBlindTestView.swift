//
//  ColorBlindTestView.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 10/20/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

//Find out how to pass in name of image and correct answer, then use that and a
// assets to load multiple tests in a row
class ColorBlindTestViewController : UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    var idx = 0
    var testImageView : UIImageView!
    var tests : [ColorBlindTest]!
    var nextButton : UIButton = UIButton(frame: CGRect(x: 200 - (100), y: 575, width: 200, height: 50))
    var answerField : UITextField = UITextField(frame: CGRect(x: 0, y: 505, width: 150, height: 50))
    var score : Int = 0
//    var scoreLabel = UILabel(frame: CGRect(x: 100, y: 600, width: 100, height: 100))
//
//    @IBOutlet var scrollView: UIScrollView!
    
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
//        self.scrollView.contentSize = CGSize(width:2000, height: 5678)
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 150)
        self.scrollView.isScrollEnabled = true
        self.scrollView.contentOffset = CGPoint(x: view.frame.origin.x, y: view.frame.origin.y + 75)
        
        
        self.view.backgroundColor = UIColor.white
        
        nextButton.setTitle("Next Question", for: .normal)
        nextButton.addTarget(self, action: #selector(NextQuestion), for: .touchUpInside)
        nextButton.backgroundColor = UIColor.red
        nextButton.layer.cornerRadius = 20
        nextButton.frame = CGRect(x: self.view.frame.width / 2 - 100, y:self.view.frame.height / 2 + 200, width: 200, height: 50)
        
        
        let testImage = UIImage(named: tests[idx].imageName)
        testImageView = UIImageView(image: testImage!)
        testImageView.frame = CGRect(x: self.view.frame.width / 2 - 125, y: self.view.frame.height / 2 - 250, width: 250, height: 250)
        
        let prompt = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 2 + 25, width: 200, height: 100))
        prompt.textColor = UIColor.black
        prompt.font = .preferredFont(forTextStyle: UIFont.TextStyle.title3)
        prompt.text = "Enter the number you see"
        prompt.lineBreakMode = .byWordWrapping
        prompt.numberOfLines = 0
        prompt.textAlignment = .center
        prompt.adjustsFontSizeToFitWidth = true
        
//        scoreLabel.textColor = UIColor.black
//        scoreLabel.text = "Score: " + String(score)
        
        answerField.frame = CGRect(x: self.view.frame.width / 2 - 75, y: self.view.frame.height / 2 + prompt.frame.height + 10, width: 150, height: 50)
        answerField.delegate = self
        answerField.borderStyle = UITextField.BorderStyle.line
        answerField.layer.borderColor = UIColor.gray.cgColor
        answerField.keyboardType = .numberPad
        answerField.textAlignment = .center

        self.view.addSubview(scrollView)
        
        scrollView.addSubview(testImageView)
        scrollView.addSubview(prompt)
        scrollView.addSubview(answerField)
        scrollView.addSubview(nextButton)

        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillOpen(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillClose(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillOpen(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
    
    @objc func CompleteTest(sender: UIButton!) {
        let resultView = ResultView()
        var result = ""
        if(score > 3) {
            result = "You don't need to update any color settings on your phone"
        } else {
            result = "You might want to change the color filters on your phone"
            resultView.steps = Resultdata[0]
        }
        resultView.result = result
        
//        let resultCtrl = UIHostingController(rootView: resultView)
        self.present(resultView, animated: true, completion: nil)
//        navigationController?.pushViewController(resultView, animated: true)
    }
    
    @objc func NextQuestion(sender: UIButton!) {
        self.hideKeyboard()
        if(answerField.text == String(tests[idx].answer)) {
            score = score + 1
        }
        answerField.text = ""
        if(idx < (tests.count - 1)) {
            idx = idx + 1
            testImageView.image = UIImage(named: tests[idx].imageName)
        }
        if(idx == tests.count-1) {
            nextButton.setTitle("Complete Test", for: .normal)
            nextButton.addTarget(self, action: #selector(CompleteTest), for: .touchUpInside)
        }
        
    }
}
struct ColorBlindTestView: View {
    @State private var guess:String = ""
    @State private var idx: Int = 0
    @State private var score: Int = 0
    @State private var image: String = Testdata[0].tests[0].imageName
    @State private var name: String = Testdata[0].tests[0].name
    @State private var correct: String = String(Testdata[0].tests[0].answer)
    @State private var id: Int = Testdata[0].tests[0].id
    @State private var finished = false

    var body: some View {
        //VStack(alignment: .center){
            VStack() {

            HStack(alignment: .top) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: CGFloat(250.00), height: CGFloat(250.00), alignment: .top)
            }
//            Spacer()
//                .frame(height: 200)

            VStack(alignment: .center) {
                Text("Enter the number you see")

                TextField("", text: $guess)
                    .font(.subheadline)
                    .frame(width: 80, height: 40, alignment: .center)
                    .border(Color.gray, width: 2)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)

                if(finished) {
                    Button(action:{self.finish()}) {
                        Text("Complete Test")
                    }
                } else {
                    Button(action:{self.nextQuestion()}) {
                        Text("Next Question")
                    }
                }

                Spacer()
                    .frame(height: 150)

//                Text("Score: \(score)")

                Spacer()
                .frame(height: 50)
            }
        }
    .padding()
    }

    func nextQuestion() {
        idx = idx + 1
        if guess == correct {
            score += 1
        }

        if(idx == Testdata[0].tests.count) {
            finished = true
        } else {
            name = Testdata[0].tests[idx].name
            correct = String(Testdata[0].tests[idx].answer)
            id = Testdata[0].tests[idx].id
            image = Testdata[0].tests[idx].imageName
            guess = ""
        }
    }

    func finish() {
        //Send to results view
    }

}
