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
            places.append(Place(name: place, location: "Lodz", type: "Restaurant", image: place))
        }
        
        if Place.restarauntNames.contains("Танчао") {
            places[6].location = "Brest" 
        }
        
        if Place.restarauntNames.contains("Хинкальная") {
            places[7].location = "Brest"
        }
        return places
    }
}

