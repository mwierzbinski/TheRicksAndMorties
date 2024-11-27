
class RickAndMortyViewModel {
	
	private let api: CharactersAPIProtocol
	var items: [Character] = []
	
	init(api: CharactersAPIProtocol) {
		self.api = api
	}
	
	func fetchData(onCompletion: @escaping ([Character]) -> Void) {
        api.getCharacters { [weak self] data, error  in
            guard let data else { return }
			print("Received data \(data)")
			self?.items = data
			onCompletion(data)
		}
	}
}
