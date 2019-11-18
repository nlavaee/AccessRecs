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
        navigationController?.pushViewController(resultView, animated: false)
        self.show(resultView, sender: nil)
//        self.present(resultView, animated: true, completion: nil)
        

//        resultView.navigationController?.isToolbarHidden = true
        
    }
    
    @objc func cantRead(sender: UIButton!) {
        textSize += 2
    }
    
    @objc func dismissView(sender: UIButton!) {
        
        self.dismiss(animated: false, completion: nil)
    }
}


//Find out how to pass in name of image and correct answer, then use that and a
// assets to load multiple tests in a row



//
//
//#if DEBUG
//struct ColorBlindTestView_Preview: PreviewProvider {
//    static var previews: some View {
//        ColorBlindTestView() // Add something here??
//    }
//}
//#endif

#if DEBUG
struct LargeTextTestView_Preview: PreviewProvider {
    static var previews: some View {
        LargeTextTestView() // Add something here??
    }
}
#endif


