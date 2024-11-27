
import UIKit

private enum Constants {
	static let cellIdentifier = "RickAndMortyCellIdentifier"
}

class CharacterListViewController: UIViewController, CharacterListViewModelOutput {
	
	let tableView = UITableView()
    
    let viewModel: CharacterListViewModelProtocol = CharacterListViewModel()
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(tableView)
		view.backgroundColor = .white
        
        viewModel.delegate = self
        
        setupTableView()
        
		viewModel.fetchCharacters()
	}
	
	private func setupTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			])
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
	}
    
    func updateUI() {
        tableView.reloadData()
    }
}

extension CharacterListViewController: UITableViewDelegate { }

extension CharacterListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.viewState.items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.viewState.items[indexPath.row].name
		return cell
	}
	
}
