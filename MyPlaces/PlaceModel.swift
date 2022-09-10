import Foundation

struct Place {
    var name: String
    var location: String
    var type: String
    var image: String
    
   static let restarauntNames = ["AtoRamen", "AtoSushi", "Fermento", "Manekin", "Piana Wishnia", "The Brick", "Танчао", "Хинкальная"]
    
    static func getPlaces() -> [Place] {
        var places = [Place]()

        for place in restarauntNames {
            places.append(Place(name: place, location: cityByPlace(place: place), type: "Restaurant", image: place))
        }
        
        return places
        
    }
    static func cityByPlace(place: String) -> String {
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

