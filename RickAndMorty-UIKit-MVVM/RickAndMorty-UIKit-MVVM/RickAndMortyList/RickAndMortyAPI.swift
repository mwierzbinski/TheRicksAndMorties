import Foundation

class RickAndMortyAPI {
	let urlSession: URLSession
	let errorHandler: ErrorHandler
	
	enum API {
		static let baseUrl = "https://rickandmortyapi.com/api"
		static let characters = "/character"
		static let episodes = "/episode"
		static let locations = "/location"
	}
	
	init(
		urlSession: URLSession = URLSession.shared,
		errorHandler: ErrorHandler = .init()
	) {
		self.urlSession = urlSession
		self.errorHandler = errorHandler
	}
	
	func getCharacters(onCompletion: @escaping ([Character]) -> Void) {
		print("Fetching characters...")
		guard let url = URL(string: API.baseUrl + API.characters) else {
			errorHandler.log(error: "URL not created")
			return
		}
		
		urlSession.dataTask(with: URLRequest(url: url)) { [weak self] data, _, error in
			guard let data else {
				self?.errorHandler.log(error: "Empty data")
				return
			}
			
			do {
				let jsonResult = try JSONDecoder().decode(Welcome.self, from: data)
				
				DispatchQueue.main.async {
					onCompletion(jsonResult.results)
				}
				
			} catch {
				self?.errorHandler.log(error: error.localizedDescription)
			}
			
			onCompletion([])
		}.resume()
	}
	
}

struct ErrorHandler {
	
	func log(error: String) {
		print("⚠️ Error: \(error)")
	}
}


import Foundation

// MARK: - Welcome
struct Welcome: Codable {
		let info: Info
		let results: [Character]
}

// MARK: - Info
struct Info: Codable {
		let count, pages: Int
		let next, prev: String?
}

// MARK: - Result
struct Character: Codable {
		let id: Int
		let name, status, species, type: String
		let gender: String
		let origin, location: Location
		let image: String
		let episode: [String]
		let url: String
		let created: String
}

// MARK: - Location
struct Location: Codable {
		let name: String
		let url: String
}
