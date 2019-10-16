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

class ResultView: UIViewController {
    var result : String = ""
    var steps: [String] = []
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        let resultLabel = UILabel(frame: CGRect(x:187.5 - 100, y: 75, width: 200, height: 100))
        resultLabel.center.x = self.view.center.x
        resultLabel.textColor = UIColor.black
        resultLabel.font = .boldSystemFont(ofSize: 18.0)
        resultLabel.text = result
        resultLabel.lineBreakMode = .byWordWrapping
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        
        let stepsLabel = UILabel(frame: CGRect(x:187.5 - 100, y: 175, width: 200, height: 100))
        stepsLabel.textColor = UIColor.black
        stepsLabel.font = .boldSystemFont(ofSize: 16.0)
        stepsLabel.text = "Steps:"
        
        let yStart = 220.0
        var offset = 0.0
        for step in steps {
            let stepLabel = UILabel(frame: CGRect(x: 187.5 - 100, y: yStart + offset, width: 200, height: 100))
            stepLabel.center.x = self.view.center.x
            stepLabel.textColor = UIColor.black
            stepLabel.font = .systemFont(ofSize: 16.0)
            stepLabel.text = "• " + step
            stepLabel.lineBreakMode = .byWordWrapping
            stepLabel.numberOfLines = 0
            self.view.addSubview(stepLabel)
            offset = offset + 75
            
        }
            
        
        
        self.view.addSubview(resultLabel)
        if(steps.count > 0) {
            self.view.addSubview(stepsLabel)
        }
        
        let guideButton = UIButton(frame: CGRect(x: 0, y: 600, width: 250, height: 100))
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
        let guideVC = GuideVC()
        self.present(guideVC, animated: true, completion: nil)
    }
}
