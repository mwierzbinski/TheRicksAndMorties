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
                DispatchQueue.main.async {
                    onCompletion([])
                }
				return
			}
			
			do {
				let jsonResult = try JSONDecoder().decode(Welcome.self, from: data)
				
				DispatchQueue.main.async {
					onCompletion(jsonResult.results)
				}
				
			} catch {
				self?.errorHandler.log(error: error.localizedDescription)
                DispatchQueue.main.async {
                    onCompletion([])
                }
			}

		}.resume()
	}
	
}

struct ErrorHandler {
	
	func log(error: String) {
		print("⚠️ Error: \(error)")
	}
}
