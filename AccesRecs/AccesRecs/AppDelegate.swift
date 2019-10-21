//
//  AppDelegate.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 9/27/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

//    @property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
//    @property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
    
    var window: UIWindow?
    
  
    var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        self.window = UIWindow(frame: UIScreen.main.bounds)
////        let homeViewController = UIViewController()
////        homeViewController.view.backgroundColor = UIColor.red
//        window!.rootViewController = LandingPageView()
//        window!.makeKeyAndVisible()
        
         window = UIWindow(frame: UIScreen.main.bounds)
         
         if let window = window {
             let mainVC = LandingPageView()
             navigationController = UINavigationController(rootViewController: mainVC)
             window.rootViewController = navigationController
             window.makeKeyAndVisible()
         }
        //
        ////        // Use a UIHostingController as window root view controller.
             
        return true
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

