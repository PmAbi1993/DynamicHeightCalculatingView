import UIKit

class ViewControllerFactory {
    static func createInitialViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let viewModel = StackedLabelViewBuilder(strings: ["Hello world", "Welcome to Simple Scroller"], viewConsumer: viewController)
        viewController.viewProvider = viewModel
        viewModel.build()
        return viewController
    }
}
