import UIKit

final class LocationView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryText
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryText
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = .vertical
        stackView.distribution  = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 0
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.setupUI()
        self.layoutUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .clear
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        addSubview(stackView)
    }
    
    func layoutUI() {
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }

}
