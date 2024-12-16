import Foundation

protocol ___VARIABLE_viewModelDelegate:identifier___: AnyObject {
    func updateUI()
}

protocol ___VARIABLE_viewModelProtocol:identifier___: AnyObject {
    var viewState: ___FILEBASENAMEASIDENTIFIER___.ViewState { get }
    var delegate: ___VARIABLE_viewModelDelegate:identifier___? { set get }
}

class ___FILEBASENAMEASIDENTIFIER___ {
    
    struct ViewState: Equatable {
        // View State can be a struct or enum 
    }

    struct Dependencies {
        // Put in all dependencies that vm needs i.e. Services, analytics etc..
    }

    struct Model {
        // All data that is passed from different model or any data the vm needs to keep reference to. 
    }

    var viewState: ViewState = .initialState  {
        didSet {
            delegate?.updateUI()
        }
    }

    weak var delegate: ___VARIABLE_viewModelDelegate:identifier___?
    
    let dependencies: Dependencies
    var model: Model

    init(model: Model, dependencies: Dependencies) {
        self.dependencies = dependencies
        self.model = model
    }

}

extension ___FILEBASENAMEASIDENTIFIER___.ViewState {
    static let initialState: ___FILEBASENAMEASIDENTIFIER___.ViewState = .init()
}