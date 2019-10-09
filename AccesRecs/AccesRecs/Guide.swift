/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The model for an individual guide.
*/

import SwiftUI
import CoreLocation

struct Guide: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    fileprivate var imageName: String
    var category: Category

//    func image(forSize size: Int) -> Image {
//        ImageStore.shared.image(name: imageName)
//    }
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case vision = "Vision"
        case mobility = "Mobility"
    }
}

extension Guide {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}
