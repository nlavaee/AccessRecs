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
            
    
            VStack(alignment: .leading) {
                ForEach(guide.Usage, id: \.self) { line in
                    
                   Text("• " + line)
                    .font(.body) //gotta fix this later
//                    .minimumScaleFactor(0.1)
                    .minimumScaleFactor(0.01)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    
                }
                .padding()
            }
        }
    }
    
}
