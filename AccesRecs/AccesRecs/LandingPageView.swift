//
//  LandingPage.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 9/29/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
// login/apple sign in from https://www.youtube.com/watch?v=vuygdr0EcGM

import Foundation
import UIKit
import SwiftUI
import AuthenticationServices


class LandingPageView: UIViewController, UINavigationControllerDelegate{

    
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        performExistingAccountSetupFlows()
//        navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.delegate = self
        let home_icon = UIImage(named: "home_icon")
        self.navigationController?.navigationBar.backIndicatorImage = home_icon
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = home_icon
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        
        // Title of App
        let appName = UILabel(frame: CGRect(x:self.view.frame.width/2 - 100, y: self.view.frame.height/2 - 225, width: 200, height: 100))
        appName.isAccessibilityElement = true
        appName.textColor = UIColor.black
        appName.font = .boldSystemFont(ofSize: 24.0)
        appName.text = "Smart Accessibility Recommendations"
        appName.lineBreakMode = .byWordWrapping
        appName.numberOfLines = 0
        appName.textAlignment = .center
        
        // logo
        let appLogo = UIImage(named: "appLogo.png")
        let logoImageView = UIImageView(image: appLogo!)
        logoImageView.frame = CGRect(x: self.view.frame.width/2 - 50, y: self.view.frame.height/2 - 75, width: 100, height: 100)
        
        // First Button Option
        let button1 = UIButton()
        button1.setTitle("Mobility", for: .normal)
        button1.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button1.addTarget(self, action: #selector(MobilityAction), for: .touchUpInside)
        button1.backgroundColor = UIColor.red
        button1.layer.cornerRadius = 20
        button1.isAccessibilityElement = true
        button1.accessibilityLabel = "Mobility"
        
        // Second Button Option
//        let button2 = UIButton(frame: CGRect(x: self.view.frame.width/2 - (100), y: self.view.frame.height - 190, width: 200, height: 50))
        let button2 = UIButton()
        button2.setTitle("Vision", for: .normal)
        button2.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button2.addTarget(self, action: #selector(VisionAction), for: .touchUpInside)
        button2.backgroundColor = UIColor.blue
        button2.layer.cornerRadius = 20
        
        let button3 = UIButton()
        button3.setTitle("Guide", for: .normal)
        button3.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button3.addTarget(self, action: #selector(GoToGuide), for: .touchUpInside)
        button3.backgroundColor = UIColor.brown
        button3.layer.cornerRadius = 20;
        
//      login button
        let loginButton = ASAuthorizationAppleIDButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
//        loginButton.widthAnchor.constraint(equalToConstant: 200).isActive
//        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive
          
        loginButton.cornerRadius = 15;
        
        let stackView = UIStackView(arrangedSubviews: [button1, button2, button3, loginButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    
//      add each of these views into the app
        self.view.addSubview(appName)
        self.view.addSubview(logoImageView)
        self.view.addSubview(stackView)
//        self.view.addSubview(button1)
//        self.view.addSubview(button2)
//        self.view.addSubview(button3)
//        self.view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
//
//
        ])

        
    }

    @objc func didTapAppleButton() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
    }
    
    private func performExistingAccountSetupFlows(){
        let requests = [ASAuthorizationAppleIDProvider().createRequest(), ASAuthorizationPasswordProvider().createRequest() ]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

        
    @objc func MobilityAction(sender: UIButton!){
        print("Mobility button tapped") // replace eventually to take to first test
        let testVC = MobilityTypingTest()
        navigationController?.pushViewController(testVC, animated: true)
        
    }
    
    @objc func VisionAction(sender: UIButton!){
        print("Vision button tapped")
        let testVC = TestList()
//        let testCtrl = UIHostingController(rootView: testVC)
//        self.present(testVC, animated: true, completion: nil)
        navigationController?.pushViewController(testVC, animated: true)
    }
    
    @objc func GoToGuide(sender: UIButton!){
        let guideVC = GuideList()
        let viewCtrl = UIHostingController(rootView: guideVC)
        
        
        navigationController?.pushViewController(viewCtrl, animated: true)
        
    }
    
    
}

extension LandingPageView: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("login error")
        
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            _ = User(credentials: credentials)
            
        default:
            break
        
        }
    }
}

extension LandingPageView: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
