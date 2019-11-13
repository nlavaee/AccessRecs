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

class ResultView: UIViewController, UINavigationControllerDelegate {
    var result : String = ""
    var steps: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.navigationItem.hidesBackButton = false
        let x_button = UIImage(named: "x_button")
        
        
        self.navigationController?.navigationBar.backIndicatorImage = x_button
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = x_button
        
         self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: #selector(dissmissView))
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: x_button, style: .done, target: self, action: #selector(dissmissView))
  
        
//        let maxFrameHeight = self.view.frame.height
//        self.navigationController?.delegate = self
//             let home_icon = UIImage(named: "home_icon")
//             self.navigationController?.navigationBar.backIndicatorImage = home_icon
//             self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = home_icon
//             self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.view.backgroundColor = UIColor.white
        let maxFrameHeight = self.view.frame.height

        
        let resultLabel = UILabel(frame: CGRect(x:187.5 - 100, y: 20, width: 200, height: 100))
        resultLabel.center.x = self.view.center.x
        resultLabel.textColor = UIColor.black
        resultLabel.font = .boldSystemFont(ofSize: 18.0)
        resultLabel.text = result
        resultLabel.lineBreakMode = .byWordWrapping
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        
        let stepsLabel = UILabel(frame: CGRect(x:187.5 - 100, y: resultLabel.frame.maxY + 15, width: 200, height: 25))
        stepsLabel.textColor = UIColor.black
        stepsLabel.font = .boldSystemFont(ofSize: 16.0)
        stepsLabel.text = "Steps:"
        
        let yStart = Double(stepsLabel.frame.maxY) - 15.0
        var offset = 0.0
        var max = 0.0
        for step in steps {
            let stepLabel = UILabel(frame: CGRect(x: 187.5 - 100, y: yStart + offset, width: 200, height: 75))
            stepLabel.center.x = self.view.center.x
            stepLabel.textColor = UIColor.black
            stepLabel.font = .systemFont(ofSize: 16.0)
            stepLabel.text = "• " + step
            stepLabel.lineBreakMode = .byWordWrapping
            stepLabel.numberOfLines = 0
            self.view.addSubview(stepLabel)
            offset = offset + 75
            max = yStart + offset - 75
        }
            
        
        
        self.view.addSubview(resultLabel)
        if(steps.count > 0) {
            self.view.addSubview(stepsLabel)
        }
        
        let guideButton = UIButton(frame: CGRect(x: 0, y: (Double(maxFrameHeight) + max) / 2 - 50, width: 250, height: 100))
        guideButton.setTitle("Check out the guide for more accessibility settings", for: .normal)
        guideButton.addTarget(self, action: #selector(bringToGuide), for: .touchUpInside)
        guideButton.backgroundColor = UIColor.red
        guideButton.titleLabel?.lineBreakMode = .byWordWrapping
        guideButton.titleLabel?.numberOfLines = 0
        guideButton.titleLabel?.textAlignment = .center
        guideButton.center.x = self.view.center.x

        guideButton.layer.cornerRadius = 30
        
        self.view.addSubview(guideButton)
    }
    
    @objc func bringToGuide(sender: UIButton!) {
        let guideVC = GuideList()
        let guideView = UIHostingController(rootView: guideVC)
//        navigationController?.pushViewController(guideView, animated: true)
       present(guideView, animated: true, completion: nil)
        
    }
    
    @objc func dissmissView(sender: UIButton!) {
        
        self.dismiss(animated: false, completion: nil)
    }
}
