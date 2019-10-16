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

struct LargeTextTestView: View {
    @State private var textSize: Int = 6
    var body: some View {
        VStack(){
            Text("Can you easily read the text below?")
            Spacer()
            Text("This is a sentence")
                .font(Font.system(size: CGFloat(textSize)))
                .multilineTextAlignment(.center)
            
                HStack() {
                    Button(action:{self.canRead(flag: true)}) {
                        Text("Yes")
                    }
                    
                    Spacer()
                    Button(action:{self.canRead(flag: false)})
                    {
                        Text("No")
                    }
                    
                    
                }
                } .padding()
        }
    
    func canRead(flag: Bool) {
        if flag {
            
        } else {
            textSize += 2
        }
    }

}

class LargeTextTestViewController : UIViewController {
    var sentenceLabel : UILabel = UILabel()
    var textSize : Int = 6 {
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
        
        let prompt = UILabel(frame: CGRect(x: 0, y: 50, width: view.frame.size.width, height: 100))
        prompt.center.x = self.view.center.x
        prompt.textAlignment = .center
        prompt.textColor = UIColor.black
        prompt.text = "Can you easily read the text below?"
        
        
        let yesButton = UIButton(frame: CGRect(x: 50, y: 600, width: 100, height: 100))
        let noButton = UIButton(frame: CGRect(x: 250, y: 600, width: 100, height: 100))
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
        if(textSize > 10) {
            result = "You might want to increase the text size on your phone"
            resultView.steps = Resultdata[1]
        } else {
            result = "You don't need to increase the text size on your phone"
        }
        resultView.result = result
//        let resultCtrl = UIHostingController(rootView: resultView)
        self.present(resultView, animated: true, completion: nil)
    }
    
    @objc func cantRead(sender: UIButton!) {
        textSize += 2
    }
}


//Find out how to pass in name of image and correct answer, then use that and a
// assets to load multiple tests in a row

class ColorBlindTestViewController : UIViewController, UITextFieldDelegate {
    var idx = 0
    var testImageView : UIImageView!
    var tests : [ColorBlindTest]!
    var nextButton : UIButton = UIButton(frame: CGRect(x: 200 - (100), y: 575, width: 200, height: 50))
    var answerField : UITextField = UITextField(frame: CGRect(x: 125, y: 505, width: 149, height: 50))
    var score : Int = 0
//    var scoreLabel = UILabel(frame: CGRect(x: 100, y: 600, width: 100, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        nextButton.setTitle("Next Question", for: .normal)
        nextButton.addTarget(self, action: #selector(NextQuestion), for: .touchUpInside)
        nextButton.backgroundColor = UIColor.red
        nextButton.layer.cornerRadius = 20
        
        
        let testImage = UIImage(named: tests[idx].imageName)
        testImageView = UIImageView(image: testImage!)
        testImageView.frame = CGRect(x: 80, y: 180, width: 250, height: 250)
        
        let prompt = UILabel(frame: CGRect(x: 100, y: 420, width: 200, height: 100))
        prompt.textColor = UIColor.black
        prompt.font = .preferredFont(forTextStyle: UIFont.TextStyle.title3)
        prompt.text = "Enter the number you see"
        prompt.lineBreakMode = .byWordWrapping
        prompt.numberOfLines = 0
        prompt.textAlignment = .center
        prompt.adjustsFontSizeToFitWidth = true
        
//        scoreLabel.textColor = UIColor.black
//        scoreLabel.text = "Score: " + String(score)
        
        answerField.delegate = self
        answerField.borderStyle = UITextField.BorderStyle.line
        answerField.layer.borderColor = UIColor.gray.cgColor
        answerField.keyboardType = .numberPad
        answerField.textAlignment = .center

        self.view.addSubview(testImageView)
        self.view.addSubview(prompt)
        self.view.addSubview(answerField)
        self.view.addSubview(nextButton)
//        self.view.addSubview(scoreLabel)
        
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
        view.frame.origin.y = -250
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




#if DEBUG
struct ColorBlindTestView_Preview: PreviewProvider {
    static var previews: some View {
        ColorBlindTestView() // Add something here??
    }
}
#endif

#if DEBUG
struct LargeTextTestView_Preview: PreviewProvider {
    static var previews: some View {
        LargeTextTestView() // Add something here??
    }
}
#endif


