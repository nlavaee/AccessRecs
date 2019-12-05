/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The model for an individual guide.
*/

import SwiftUI
import CoreLocation

struct ColorBlindTest: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var answer: Int
    var imageName: String

}
    
extension ColorBlindTest {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}
