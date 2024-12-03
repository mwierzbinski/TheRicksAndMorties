import UIKit

import SDWebImage

final class ChracterViewCell: UICollectionViewCell {
    static let identifier = "ChracterViewCell"
    
    enum Constants {
        static let padding: CGFloat = 16
        static let cornerRadius: CGFloat = 12
        static let height: CGFloat = 150
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial-BoldMT", size: 24)
        label.textColor = .primaryText
        return label
    }()
    
    lazy var descriptionLabel: DescriptionLabel = {
        let label = DescriptionLabel()
        return label
    }()
    
    var lastSeenView: LocationView = {
        return LocationView()
    }()
    
    var firsSeenView: LocationView = {
        return LocationView()
    }()
    
    var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = .vertical
        stackView.distribution  = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = .vertical
        stackView.distribution  = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 16
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with state: CharacterListViewModel.CharacterCellViewState) {
        backgroundColor = .primary
        clipsToBounds = true
        layer.cornerRadius = Constants.cornerRadius
        
        // TODO: This should be done in VM
        if let imageURL = URL(string: state.image) {
            icon.sd_imageIndicator = SDWebImageActivityIndicator.gray
            icon.sd_imageIndicator?.startAnimatingIndicator()
            icon.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "unknown"))
        } else {
            print("⚠️ Invalid URL")
            icon.image = UIImage(named: "unknown")
        }

        titleLabel.text = state.name
        descriptionLabel.setStatus(.alive, species: state.species)
        
        lastSeenView.titleLabel.text = "Last known location:"
        lastSeenView.subtitleLabel.text = state.lastKnownLocation
        
        firsSeenView.titleLabel.text = "First seen in:"
        firsSeenView.subtitleLabel.text = state.firstSeenLocation
        
        layoutViews()
    }
    
    private func setViewHierarchy() {
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(descriptionLabel)
        
        descriptionStackView.addArrangedSubview(titleStackView)
        descriptionStackView.addArrangedSubview(lastSeenView)
        descriptionStackView.addArrangedSubview(firsSeenView)
        
        addSubview(icon)
        addSubview(descriptionStackView)
    }
    
    private func layoutViews() {
        
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        icon.topAnchor.constraint(equalTo: topAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: Constants.height).isActive = true
        icon.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        descriptionStackView.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8).isActive = true
        descriptionStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        descriptionStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

}
