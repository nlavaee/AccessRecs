//
//  LandingPage.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 9/29/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

//struct LandingP: View {
//
//}
class LandingPageView: UIViewController, UINavigationControllerDelegate{

    
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.delegate = self
        let home_icon = UIImage(named: "home_icon")
        self.navigationController?.navigationBar.backIndicatorImage = home_icon
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = home_icon
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        
        // Title of App
        let appName = UILabel(frame: CGRect(x:self.view.frame.width/2 - 100, y: 125, width: 200, height: 100))
        appName.isAccessibilityElement = true
        appName.textColor = UIColor.black
        appName.font = .boldSystemFont(ofSize: 24.0)
        appName.text = "Smart Accessibility Recommendations"
        appName.lineBreakMode = .byWordWrapping
        appName.numberOfLines = 0
        appName.textAlignment = .center
        
        // First Button Option
        let button1 = UIButton(frame: CGRect(x: self.view.frame.width/2 - 100, y: 456 - 25, width:200, height: 50))
        button1.setTitle("Mobility", for: .normal)
        button1.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button1.addTarget(self, action: #selector(MobilityAction), for: .touchUpInside)
        button1.backgroundColor = UIColor.red
        button1.layer.cornerRadius = 20
        button1.isAccessibilityElement = true
        button1.accessibilityLabel = "Mobility"
        
        // Second Button Option
        let button2 = UIButton(frame: CGRect(x: self.view.frame.width/2 - (100), y: 506, width: 200, height: 50))
        button2.setTitle("Vision", for: .normal)
        button2.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button2.addTarget(self, action: #selector(VisionAction), for: .touchUpInside)
        button2.backgroundColor = UIColor.blue
        button2.layer.cornerRadius = 20
        
        let button3 = UIButton(frame: CGRect(x: self.view.frame.width/2 - (100), y: 506 + 75, width: 200, height: 50))
        button3.setTitle("Guide", for: .normal)
        button3.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button3.addTarget(self, action: #selector(GoToGuide), for: .touchUpInside)
        button3.backgroundColor = UIColor.brown
        button3.layer.cornerRadius = 20;
        
        let appLogo = UIImage(named: "appLogo.png")
        let logoImageView = UIImageView(image: appLogo!)
        logoImageView.frame = CGRect(x: self.view.frame.width/2 - 50, y: 255, width: 100, height: 100)
    
        
        
//         add each of these views into the app
        self.view.addSubview(appName)
        self.view.addSubview(logoImageView)
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
    }
    
    @objc func MobilityAction(sender: UIButton!){
        print("Mobility button tapped") // replace eventually to take to first test
        
        // ideally this could be a sandbox so we could re-direct to an existing test but not sure how to get those results back
    }
    
    @objc func VisionAction(sender: UIButton!){
        print("Vision button tapped")
        let testVC = TestList()
//        let testCtrl = UIHostingController(rootView: testVC)
        self.present(testVC, animated: true, completion: nil)
    }
    
    @objc func GoToGuide(sender: UIButton!){
        let guideVC = GuideList()
        let viewCtrl = UIHostingController(rootView: guideVC)
        
        
        navigationController?.pushViewController(viewCtrl, animated: true)
        
    }
}


//}
