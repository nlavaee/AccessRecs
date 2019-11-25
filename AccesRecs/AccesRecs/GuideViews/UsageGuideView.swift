//
//  UsageGuideView.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 11/19/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import SwiftUI


struct UsageGuideView: View {
    
    var guide:Guide
    
    var body: some View {
        
        VStack {
            
            Text("Usage Steps").font(.title)
            .lineLimit(nil)
            .padding()
            
    
              ScrollView(.vertical, showsIndicators: true){
                VStack(alignment: .leading){
                    
                    ForEach(guide.Usage, id: \.self) { line in
                        
                        Text("• " + line)
    //                    .font(.body)
                        .font(.body).fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
    //                    .minimumScaleFactor(0.01)
                        .multilineTextAlignment(.leading)
                       
                        }
                        .padding()
    //                .padding(.bottom, 20)
    //                .padding(.vertical, 40)
    //                .padding(.horizontal, 20)
    //                .minimumScaleFactor(0.01)
                }
            }
        }
    }
    
}
