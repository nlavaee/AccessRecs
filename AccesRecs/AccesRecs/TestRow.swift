//
//  GuideRow.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 10/9/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import SwiftUI

// creating each of the separate rows for the Guide

struct TestRow: View {
    
    var test: Test
    
    var body: some View {
        
        HStack {
            Text(test.name)
            Spacer() // push all the way to the edges
        }
    }
}

struct TestRow_Previews: PreviewProvider {
    static var previews: some View {
        
        TestRow(test: Testdata[0])
    }
}
