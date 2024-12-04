import Foundation

struct Character: Codable, Equatable {
        let id: Int
        let name, species, type: String
        let status: String
        let gender: String
        let origin, location: Location
        let image: String
        let episode: [String]
        let url: String
        let created: String
}

enum CharacterStatus: String, Codable, Equatable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}
