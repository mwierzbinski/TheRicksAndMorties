
class RickAndMortyViewModel {
	
	private let api: ClientAPI
	var items: [Character] = []
	
	init(api: ClientAPI) {
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
