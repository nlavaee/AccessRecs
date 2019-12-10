//
//  ResultView.swift
//  AccesRecs
//
//  Created by Daniel Haines on 10/11/19.
//  Copyright © 2019 Daniel Haines. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct DismissModal : View {
    @Binding var showingModal:Bool

    var body: some View {
        Button(action: {
            self.showingModal = false
        }) {
            Text("Dismiss").frame(height: 60)
        }
    }
}

class ResultView: UIViewController, UINavigationControllerDelegate {
    var result : String = ""
    var recs: [String] = []
    var resultType: String = ""
    
//    var dismissModal: Bool = false
    @State var modalGone = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        dismissModal = true

        
        if traitCollection.userInterfaceStyle == .dark{
            self.view.backgroundColor = UIColor.black

        }
        else{
            self.view.backgroundColor = UIColor.white
        }
        
        let maxFrameHeight = self.view.frame.height

        
        let resultLabel = UILabel(frame: CGRect(x:187.5 - 100, y: 20, width: 200, height: 150))
        resultLabel.center.x = self.view.center.x
        
        if traitCollection.userInterfaceStyle == .dark{
            resultLabel.textColor = UIColor.white

        }
        else {
            resultLabel.textColor = UIColor.black
        }
        
        resultLabel.font = .boldSystemFont(ofSize: 24.0)
        resultLabel.text = result
        resultLabel.lineBreakMode = .byWordWrapping
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        
        let recsLabel = UILabel(frame: CGRect(x:187.5 - 100, y: resultLabel.frame.maxY + 15, width: 200, height: 25))
        if traitCollection.userInterfaceStyle == .dark{
            recsLabel.textColor = UIColor.white

        }
        else{
            recsLabel.textColor = UIColor.black
        }
        
        recsLabel.font = .boldSystemFont(ofSize: 16.0)
        recsLabel.text = "Recommendations: "
        
        let yStart = Double(recsLabel.frame.maxY) - 15.0
        var offset = 0.0
        var max = 0.0
        for rec in recs {
            let stepLabel = UILabel(frame: CGRect(x: 187.5 - 100, y: yStart + offset, width: 200, height: 75))
            stepLabel.center.x = self.view.center.x
            
            if traitCollection.userInterfaceStyle == .dark{
                stepLabel.textColor = UIColor.white
            }
            else{
                stepLabel.textColor = UIColor.black
                
            }
            
            stepLabel.font = .systemFont(ofSize: 16.0)
            stepLabel.text = "• " + rec
            stepLabel.lineBreakMode = .byWordWrapping
            stepLabel.numberOfLines = 0
            self.view.addSubview(stepLabel)
            offset = offset + 25
            max = yStart + offset - 25
        }
            
        
        
        self.view.addSubview(resultLabel)
        if(recs.count > 0) {
            self.view.addSubview(recsLabel)
        }
        
        
        // vision guide button
        
        if(resultType == "Vision") {
            let guideButton = UIButton(frame: CGRect(x: 0, y: (Double(maxFrameHeight) + max) / 2 - 100, width: 250, height: 100))
            guideButton.setTitle("Check out the Vision Guide", for: .normal)
            guideButton.addTarget(self, action: #selector(bringToGuide), for: .touchUpInside)
            guideButton.backgroundColor = UIColor.red
            guideButton.titleLabel?.lineBreakMode = .byWordWrapping
            guideButton.titleLabel?.numberOfLines = 0
            guideButton.titleLabel?.textAlignment = .center
            guideButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
            guideButton.center.x = self.view.center.x
            
            guideButton.layer.cornerRadius = 30
                  
            self.view.addSubview(guideButton)
        }
        
        if(resultType == "Motion"){
        // mobility guide button
    
            let guideButtonMotion = UIButton(frame: CGRect(x: 0, y: (Double(maxFrameHeight) + max) / 2  - 100, width: 250, height: 100))
            guideButtonMotion.setTitle("Check out the Motion Guide", for: .normal)
            guideButtonMotion.addTarget(self, action: #selector(bringToMotionGuide(sender:)), for: .touchUpInside)
            guideButtonMotion.backgroundColor = UIColor.red
            guideButtonMotion.titleLabel?.lineBreakMode = .byWordWrapping
            guideButtonMotion.titleLabel?.numberOfLines = 0
            guideButtonMotion.titleLabel?.textAlignment = .center
            guideButtonMotion.center.x = self.view.center.x
            
            guideButtonMotion.layer.cornerRadius = 30
                  
            self.view.addSubview(guideButtonMotion)
        
        }
        let dismissButton = UIButton(frame: CGRect(x: 0, y: (Double(maxFrameHeight) + max) / 2 + 50, width: 250, height: 100))
        dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        dismissButton.setTitle("Dismiss", for: .normal)
//        dismissButton.backgroundColor = UIColor.red
        dismissButton.setTitleColor(.systemBlue, for: .normal)
        dismissButton.titleLabel?.lineBreakMode = .byWordWrapping
        dismissButton.titleLabel?.numberOfLines = 0
        dismissButton.titleLabel?.textAlignment = .center
        dismissButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        dismissButton.center.x = self.view.center.x
        
        dismissButton.layer.cornerRadius = 30
        
        self.view.addSubview(dismissButton)

    }
    
    @objc func bringToGuide(sender: UIButton!) {
//        let guideVC = GuideList()
        let guideVC = GuideList(data: Guidedata)
        
        let guideView = UIHostingController(rootView: guideVC)
        self.present(guideView, animated: false)
//        navigationController?.pushViewController(guideView, animated: true)
//        navigationController?.pushViewController(nextView, animated: true)

//        let guideView = UIHostingController(rootView: guideVC)
        
//        self.dismiss(animated: true, completion: nil)

//        navigationController?.pushViewController(nextView, animated: true)
        
//        nextView.GoToGuide(sender: sender)
//
        
//        self.present(, animated: false)
        
       
        
    }
    
    @objc func bringToMotionGuide(sender: UIButton!) {
        
        
        let guideVC = GuideList(data: GuidedataMotion)

        let guideView = UIHostingController(rootView: guideVC)
        
//        navigationController?.pushViewController(guideView, animated: false)
//        self.presentingViewController?.present(guideView, animated: false, completion: nil)
        self.present(guideView, animated: false)
    }
    
    
    @objc func dismissView(sender: UIButton!) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
