import Foundation

protocol CharactersAPIProtocol {
    typealias CompletionHandler = (_ data: [Character]?, _ error: ClientAPI.Error?) -> Void
    
    func getCharacters(onCompletion: @escaping CompletionHandler)
}

final class ClientAPI {

    enum API {
        static let baseUrl = "https://rickandmortyapi.com/api"
        static let characters = "/character"
        static let episodes = "/episode"
        static let locations = "/location"
    }
    
    enum Error: LogableError {
        case invalidURL
        case invalidData
        case invalidJSON
        
        func errorHandlerDescription() -> String {
            switch self {
                
            case .invalidURL:
                return "Invalid URL"
            case .invalidData:
                return "Invalid Data"
            case .invalidJSON:
                return "Invalid JSON"
            }
        }
    }
    
	private let urlSession: RMURLSession
	private let errorHandler: ErrorHandlerProtocol

	init(
		urlSession: RMURLSession = URLSession.shared,
		errorHandler: ErrorHandlerProtocol = ErrorHandler()
	) {
		self.urlSession = urlSession
		self.errorHandler = errorHandler
	}
}

extension ClientAPI: CharactersAPIProtocol {
    
    func getCharacters(onCompletion: @escaping ([Character]?, ClientAPI.Error?) -> Void) {
        print("🚀 Fetching characters...")
        guard let url = URL(string: API.baseUrl + API.characters) else {
            errorHandler.log(error: ClientAPI.Error.invalidURL)
            return
        }
        
        urlSession.dataTask(with: URLRequest(url: url)) { [weak self] data, _, error in
            guard let data else {
                DispatchQueue.main.async { [weak self] in
                    self?.errorHandler.log(error: ClientAPI.Error.invalidData)
                    onCompletion(nil, ClientAPI.Error.invalidData)
                }
                return
            }
            
            do {
                let jsonResult = try JSONDecoder().decode(Welcome.self, from: data)
                
                DispatchQueue.main.async {
                    print("🚀 Characters found!")
                    onCompletion(jsonResult.results, nil)
                }
                
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.errorHandler.log(error: ClientAPI.Error.invalidJSON)
                    onCompletion(nil, ClientAPI.Error.invalidJSON)
                }
            }

        }.resume()
    }
}
