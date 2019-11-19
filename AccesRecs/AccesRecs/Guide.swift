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
    var category: Category
    fileprivate var imageName: String
    fileprivate var imageBefore: String
    fileprivate var imageAfter: String
    var Description: String
    var Steps: Array<String>
    var Usage: Array<String>

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
    var imgBefore: Image {
        ImageStore.shared.image(name: imageBefore)
    }
    var imgAfter: Image {
        ImageStore.shared.image(name: imageAfter)
    }
}
