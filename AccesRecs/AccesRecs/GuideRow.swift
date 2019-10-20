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
    
//    ForEach(self.data.filter {
//        self.searchTerm.isEmpty ? true :
//            $0.localizedCaseInsensitiveContains(self.searchTerm)
//    }, id: \.self){ item in
//
//        data_trash.append((item))
//
//    }
    var body: some View {
        
        HStack {
            
            guide.image.resizable().frame(width: 50, height: 55)
            Text(guide.name)
                .lineLimit(nil)
                .frame(width: 200, height:44, alignment: .leading)
            Spacer() // push all the way to the edges
        }
    }
}

//struct GuideRow_Previews: PreviewProvider {
//    static var previews: some View {
//
//        GuideRow(guide: Guidedata[0])
//    }
//}
