/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The model for an individual guide.
*/

import SwiftUI
import CoreLocation

struct Test: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var tests: [ColorBlindTest]
//    var category: Category
//
//    enum Category: String, CaseIterable, Codable, Hashable {
//        case vision = "Vision"
//        case mobility = "Mobility"
//    }
}

