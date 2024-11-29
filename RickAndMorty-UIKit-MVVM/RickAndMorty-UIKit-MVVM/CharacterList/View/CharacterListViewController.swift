
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
    
    let viewModel: CharacterListViewModelProtocol = CharacterListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        setupUI()
        layoutUI()
        updateUI()
        
        viewModel.fetchCharacters()
    }
    
    private func setupUI() {
        view.backgroundColor = .secondary
        charactersView.backgroundColor = .clear
        
        view.addSubview(charactersView)
    }
    
    func updateUI() {
        charactersView.reloadData()
    }
    
    private func layoutUI() {
        charactersView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        charactersView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding).isActive = true
        charactersView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding).isActive = true
        charactersView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        charactersView.translatesAutoresizingMaskIntoConstraints = false
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
        viewModel.viewState.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChracterViewCell.identifier, for: indexPath) as! ChracterViewCell
        cell.configure(with: viewModel.viewState.items[indexPath.row])
        return cell
    }
}

extension UIColor {
    static var primary: UIColor {
        .init(red: 60/256, green: 62/256, blue: 68/256, alpha: 1)
    }
    
    static var secondary: UIColor {
        .init(red: 39/256, green: 43/256, blue: 51/256, alpha: 1)
    }
    
    static var secondaryText: UIColor {
        .init(red: 158/256, green: 158/256, blue: 158/256, alpha: 1)
    }
    
    static var primaryText: UIColor {
        .white
    }
    
}
