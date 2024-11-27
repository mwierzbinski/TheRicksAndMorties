import Foundation

struct Character: Codable, Equatable {
        let id: Int
        let name, status, species, type: String
        let gender: String
        let origin, location: Location
        let image: String
        let episode: [String]
        let url: String
        let created: String
}
