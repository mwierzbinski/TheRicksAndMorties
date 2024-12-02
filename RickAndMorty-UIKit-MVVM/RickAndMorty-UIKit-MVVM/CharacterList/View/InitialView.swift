import UIKit

/// Imagine This is totally different view with only some animations and a static text or two
class InitialView: UIView {
    
    enum Constants {
        static let padding: CGFloat = 16
    }
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Welcome, Soon You will see more Ricks and more Morties"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()

    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ram-initial")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.setupUI()
        self.layoutUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(title)
        addSubview(icon)
    }

    private func layoutUI() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        icon.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        icon.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        icon.heightAnchor.constraint(equalTo: icon.widthAnchor).isActive = true
        
        title.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 16).isActive = true
        title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding).isActive = true
        title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -Constants.padding).isActive = true
  
    }
}
