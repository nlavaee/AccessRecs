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
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        let resultLabel = UILabel(frame: CGRect(x:187.5 - 100, y: 125, width: 200, height: 100))
        resultLabel.center.x = self.view.center.x
        resultLabel.textColor = UIColor.black
        resultLabel.font = .boldSystemFont(ofSize: 18.0)
        resultLabel.text = result
        resultLabel.lineBreakMode = .byWordWrapping
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        
        self.view.addSubview(resultLabel)
        
        let guideButton = UIButton(frame: CGRect(x: 0, y: 500, width: 250, height: 100))
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
