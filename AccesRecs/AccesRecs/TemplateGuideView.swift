//
//  TemplateGuideView.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 10/9/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

//
//  TemplateGuideView.swift
//  AccesRecs
//
//  Created by Amaris Sim on 10/7/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

import SwiftUI


struct TemplateGuideView: View {
    @State private var toggleTrue = false
    var body: some View {
        
        VStack(){
            
//          line 23 - 36
//          title, toggle button, description
//          note: padding to apply goes to outside
            VStack(alignment: .leading){
                HStack(){
                    Text("Reduce Transparency")
                        .font(.system(size: 30))
                     Spacer()
                     Toggle(isOn: $toggleTrue){
                         Text("Before Reduce Transparency")
                     }
                     .labelsHidden()
                    }
                Text("Description about how reduce transparency works here")
                    .font(.subheadline)
                    .lineLimit(0)
            }
            .padding()
            Spacer()

//          line 43-52
//          before text box and image
            Text("Before")
                .frame(alignment:.center)
                .padding([.horizontal])
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray, lineWidth:2)
                )
            Image("BeforeReduceTransparencyDock")
                .resizable()
                .aspectRatio(contentMode: .fit)

            Spacer()
                .frame(height:50)
            
           if toggleTrue {
            Text("After")
                .padding([.horizontal])
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray, lineWidth:2)
                )
            Image("AfterReduceTransparencyDock")
                .resizable()
                .aspectRatio(contentMode: .fit)
           }
        }
        .padding()
    }
}

#if DEBUG
struct TemplateGuideView_Preview: PreviewProvider {
    static var previews: some View {
        TemplateGuideView()
    }
}
#endif
