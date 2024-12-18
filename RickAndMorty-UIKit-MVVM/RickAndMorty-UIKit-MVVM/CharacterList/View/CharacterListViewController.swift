
import UIKit

class CharacterListViewController: UIViewController, CharacterListViewModelOutput {
	
	private enum Constants {
		static let cellIdentifier = "RickAndMortyCellIdentifier"
		static let padding: CGFloat = 8
	}
	
	private lazy var pagesFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 8
		layout.minimumInteritemSpacing = 8
		
		return layout
	}()
	
	private lazy var charactersView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: pagesFlowLayout)
		collectionView.register(ChracterViewCell.self, forCellWithReuseIdentifier: ChracterViewCell.identifier)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.backgroundColor = .clear
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.isPagingEnabled = true
		return collectionView
	}()
	
	var infoView: UIView? = nil
	let viewModel: CharacterListViewModelProtocol
	let factory: CharacterViewFactoryProtocol
	
	init(
		viewModel: CharacterListViewModelProtocol = CharacterListViewModel(),
		factory: CharacterViewFactoryProtocol = CharacterViewFactory.init()
	) {
			self.viewModel = viewModel
			self.factory = factory
			super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.delegate = self
		
		setupUI()
		layoutUI()
		updateUI()
		
		// viewDidAppear || viewDidLoad
		viewModel.fetchCharacters()
	}
	
	private func setupUI() {
		view.backgroundColor = .secondary
		charactersView.backgroundColor = .clear
		
		view.addSubview(charactersView)
	}
	
	private func layoutUI() {
		// describe - two ways of doing this
		charactersView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		charactersView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding).isActive = true
		charactersView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding).isActive = true
		charactersView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		charactersView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	func updateUI() {
		infoView?.removeFromSuperview()
		infoView = nil
		
		if let infoView = factory.makeCharacterView(with: viewModel.viewState) {
			self.infoView = infoView
			view.addSubview(infoView)
		}
		
		charactersView.reloadData()
		
		updateLayout()
	}
	
	private func updateLayout() {
		if let infoView {
			infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
			infoView.leadingAnchor.constraint(equalTo: charactersView.leadingAnchor).isActive = true
			infoView.trailingAnchor.constraint(equalTo: charactersView.trailingAnchor).isActive = true
			infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
			infoView.translatesAutoresizingMaskIntoConstraints = false
		}
	}
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = collectionView.bounds.width
		
		return .init(width: width, height: ChracterViewCell.Constants.height)
	}
}

extension CharacterListViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.viewState.characters.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChracterViewCell.identifier, for: indexPath) as! ChracterViewCell
		cell.configure(with: viewModel.viewState.characters[indexPath.row])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let character = viewModel.getCharacterModel(for: indexPath.row) {
			let detailVM = CharacterDetailViewModel(model: .init(character: character))
			let detailsVC = CharacterDetailViewController(viewModel: detailVM)
			navigationController?.pushViewController(detailsVC, animated: true)
		} else {
			// Handle error if needed
		}
	}
}
