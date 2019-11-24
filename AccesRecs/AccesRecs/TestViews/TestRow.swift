//
//  GuideRow.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 10/9/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import SwiftUI

// creating each of the separate rows for the Guide

//struct TestRow: View {
//
//    var test: Test
//
//    var body: some View {
//
//        HStack {
//            Text(test.name)
//            Spacer() // push all the way to the edges
//        }
//    }
//}
//
//struct TestRow_Previews: PreviewProvider {
//    static var previews: some View {
//
//        TestRow(test: Testdata[0])
//    }
//}

class TestRow : UITableViewCell {
    var titleArea : UILabel = UILabel(frame: CGRect(x: 30, y: 5, width: 200, height: 44))
    var test : Test! {
        didSet {
            titleArea.numberOfLines = 0
            titleArea.text = test.name
            contentView.addSubview(titleArea)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
