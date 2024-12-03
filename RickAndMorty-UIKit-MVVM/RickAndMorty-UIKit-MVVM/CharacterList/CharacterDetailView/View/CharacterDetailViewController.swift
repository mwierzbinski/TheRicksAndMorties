import UIKit

final class CharacterDetailViewController: UIViewController {
    
    private enum Constants {
        static let padding: CGFloat = 16
    }
    
    let viewModel: CharacterDetailViewModel
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryText
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondary
        
        setupUI()
        updateUI()
        layoutUI()
    }
    
    
    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(icon)
        view.addSubview(subTitle)
    }

    private func layoutUI() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitle.translatesAutoresizingMaskIntoConstraints = false
   
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -Constants.padding).isActive = true
  
        icon.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        icon.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        icon.heightAnchor.constraint(equalTo: icon.widthAnchor).isActive = true
        
        
        subTitle.topAnchor.constraint(equalTo: icon.bottomAnchor).isActive = true
        subTitle.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        subTitle.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
    }
    
    func updateUI() {
        nameLabel.text = viewModel.viewState.name
        icon.image = UIImage(named: viewModel.viewState.image)
        subTitle.text = viewModel.viewState.subtitle
    }
    
}
