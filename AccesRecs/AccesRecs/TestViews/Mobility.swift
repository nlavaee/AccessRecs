//
//  Mobility.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 10/20/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class Mobility: UIViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad(){

        super.viewDidLoad()
        let sentenceLabel : UILabel = UILabel()
        sentenceLabel.text = "Mobility tests coming soon!"
        sentenceLabel.frame = CGRect(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 2 - 50, width: 200, height: 100)
        sentenceLabel.numberOfLines = 0
        sentenceLabel.lineBreakMode = .byWordWrapping
        sentenceLabel.center.x = self.view.center.x
        sentenceLabel.textAlignment = .center
        sentenceLabel.font = .systemFont(ofSize: 32)
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(sentenceLabel)
            
    }
}
