//
//  SettingsSteps.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 11/17/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit


struct SettingsStepsView: View {
    
    var guide: Guide
    
    var body: some View {
            
        VStack {
            
            Text("Steps To Enable Feature").font(.title)
            .lineLimit(nil)
            .padding()
            
            VStack(alignment: .leading){
                
                ForEach(guide.Steps, id: \.self) { line in
                    
                    Text("• " + line)
                    .font(.body) //gotta fix this later
                    .minimumScaleFactor(0.01)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                   
                    }
                 .padding()
            }
            
        }
    
    }
    
}

//func openSettings(alert: UIAlertAction!) {
//    if let url = URL.init(string: UIApplication.openSettingsURLString) {
//        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//    }
//}
//
//let alert = UIAlertController(title: "Settings",
//                              message: "Please modify your settings",
//                              preferredStyle: .alert)
//
//alert.addAction(UIAlertAction(title: "Open Settings",
//                              style: UIAlertAction.Style.default,
//                              handler: openSettings))
//alert.addAction(UIAlertAction(title: "Cancel",
//                              style: UIAlertAction.Style.default,
//                              handler: nil))
//
//viewController.present(alert, animated: true, completion: nil)

