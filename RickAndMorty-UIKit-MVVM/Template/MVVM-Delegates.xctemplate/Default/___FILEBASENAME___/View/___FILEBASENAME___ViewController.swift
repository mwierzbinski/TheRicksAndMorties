// NO-SB

import UIKit

class ___FILEBASENAMEASIDENTIFIER___: UIViewController, ___VARIABLE_viewModelDelegate:identifier___ {

    let viewModel: ___VARIABLE_viewModelProtocol:identifier___

    //MARK: - Initializers
    init(
		viewModel: ___VARIABLE_viewModelProtocol:identifier___
	) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

    required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    //MARK: - View Cycle
    override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.delegate = self
		
		setupUI()
		layoutUI()
		updateUI()

	}

    private func setupUI() {
        // Add Views, subviews and and static info i.e. background colour 
	}
	
	private func layoutUI() {
        // Add Constraint needed to layout view
	}
	
	func updateUI() {
        // Here should be all the updates to view that are dynamic
        // This will be run after viewState will be set in viewModel. 
    }
  
}