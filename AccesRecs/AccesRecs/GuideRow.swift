//
//  GuideRow.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 10/9/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import SwiftUI

// creating each of the separate rows for the Guide

struct GuideRow: View {
    
    var guide: Guide
    
    var body: some View {
        
        HStack {
            
            guide.image.resizable().frame(width: 50, height: 50)
            Text(guide.name)
            Spacer() // push all the way to the edges
        }
    }
}

struct GuideRow_Previews: PreviewProvider {
    static var previews: some View {
        
        GuideRow(guide: Guidedata[0])
    }
}
