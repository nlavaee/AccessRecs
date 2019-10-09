//
//  Test.swift
//  AccesRecs
//
//  Created by Audrey Jones on 10/9/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import Foundation

struct Test : Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var category: Category
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case vision = "Vision"
        case mobility = "Mobility"
    }
}
