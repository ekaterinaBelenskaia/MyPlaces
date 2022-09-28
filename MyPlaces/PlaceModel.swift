import RealmSwift
import SwiftUI
import UIKit

class Place: Object {
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    @objc dynamic var rating = 0.0
    
    convenience init(name: String, location: String?, type: String?, imageData: Data?, rating: Double) {
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
        self.rating = rating
    }
//
//   let restarauntNames = ["AtoRamen", "AtoSushi", "Fermento", "Manekin", "Piana Wishnia", "The Brick", "Танчао", "Хинкальная"]
//
//     func savePlaces() {
//
//        for place in restarauntNames {
//
//            let image = UIImage(named: place)
//            guard let imageData = image?.pngData() else { return }
//
//            let newPlace = Place()
//
//            newPlace.name = place
//            newPlace.location = cityByPlace(place: place)
//            newPlace.type = "Restaurant"
//            newPlace.imageData = imageData
//
//            StorageManager.saveObject(newPlace)
//        }
//
//
//    }
     func cityByPlace(place: String) -> String {
        var ret: String = ""
        if (place == "Танчао") {
            ret = "Brest"
        } else if (place == "Хинкальная") {
            ret = "Brest"
        } else {
            ret = "Lodz"
        }
        return ret
    }
}

