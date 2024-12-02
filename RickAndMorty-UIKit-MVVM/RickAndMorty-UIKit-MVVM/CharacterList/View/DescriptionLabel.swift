import UIKit

final class DescriptionLabel: UIView {
    
    private enum Constants {
        static let statusIndicator = "•"
        static let separator = "-"
        static let fontSize: CGFloat = 12
    }
    
    private lazy var statusIndicatorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28)
        label.text = Constants.statusIndicator
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.textColor = .primaryText
        return label
    }()
    
    private lazy var separatorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.textColor = .primaryText
        label.text = Constants.separator
        return label
    }()
    
    private lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.textColor = .primaryText
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStatus( _ status: CharacterStatus, species: String) {
        
        statusIndicatorLabel.textColor = .color(from: status)
        statusLabel.text = status.rawValue
        speciesLabel.text = species
        setupViews()
        layoutViews()
    }
    
    private func setupViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(statusIndicatorLabel)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(separatorLabel)
        stackView.addArrangedSubview(speciesLabel)
    }
    
    private func layoutViews() {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        statusIndicatorLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

private extension UIColor {
    static func color(from status: CharacterStatus) -> UIColor {
        switch status {
        case .alive: return .green
        case .dead: return .red
        case .unknown: return .gray
        }
    }
}
