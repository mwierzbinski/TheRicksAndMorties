
class RickAndMortyViewModel {
	
	private let api: RickAndMortyAPI
	var items: [Character] = []
	
	init(api: RickAndMortyAPI) {
		self.api = api
	}
	
	func fetchData(onCompletion: @escaping ([Character]) -> Void) {
		api.getCharacters { [weak self] data in
			print("Received data \(data)")
			self?.items = data
			onCompletion(data)
		}
	}
}
