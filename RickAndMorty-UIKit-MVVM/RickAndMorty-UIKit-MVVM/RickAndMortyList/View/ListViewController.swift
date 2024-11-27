
import UIKit

private enum Constants {
	static let cellIdentifier = "RickAndMortyCellIdentifier"
}

class ListViewController: UIViewController {
	
	let tableView = UITableView()
	let viewModel: RickAndMortyViewModel = .init(api: ClientAPI())
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(tableView)
		view.backgroundColor = .white
		
		viewModel.fetchData { [weak self] _ in
			self?.tableView.reloadData()
		}
		
		setupTableView()
	}
	
	func setupTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			])
		
		
		// Register a basic UITableViewCell for reuse
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
	}
	
}

extension ListViewController: UITableViewDelegate { }

extension ListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) // TODO check this
		cell.textLabel?.text = viewModel.items[indexPath.row].name
		return cell
	}
	
}
