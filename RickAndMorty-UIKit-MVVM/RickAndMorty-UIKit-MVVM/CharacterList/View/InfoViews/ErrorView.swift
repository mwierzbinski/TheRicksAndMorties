import UIKit

// Imagine this is totally different view then other views.
class ErrorView: UIView {
    
    enum Constants {
        static let padding: CGFloat = 16
    }
    
    private lazy var title: UILabel = {
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
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.primaryButtonTitile, for: .normal)
        button.backgroundColor = .primary
        button.layer.cornerRadius = 10
        return button
    }()
    
    private var state: CharacterListViewModel.ErrorViewState
    
    init(state: CharacterListViewModel.ErrorViewState) {
        self.state = state
        
        super.init(frame: .zero)
        
        self.setupUI()
        self.layoutUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        
        title.text = state.title
        addSubview(title)
        
        icon.image = UIImage(named: state.image)
        addSubview(icon)
        
        subTitle.text = state.subtitle
        addSubview(subTitle)
        
        actionButton.setTitle(state.buttonTitle, for: .normal)
        addSubview(actionButton)
    }

    private func layoutUI() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
   
        title.topAnchor.constraint(equalTo: topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -Constants.padding).isActive = true
  
        icon.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        icon.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        icon.heightAnchor.constraint(equalTo: icon.widthAnchor).isActive = true
        
        
        subTitle.topAnchor.constraint(equalTo: icon.bottomAnchor).isActive = true
        subTitle.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        subTitle.trailingAnchor.constraint(equalTo: title.trailingAnchor).isActive = true
        
        actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding).isActive = true
        actionButton.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: title.trailingAnchor).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
