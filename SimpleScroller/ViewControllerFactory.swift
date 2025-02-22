import UIKit

class ViewControllerFactory {
    static func createInitialViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let randomStrings = generateRandomStrings(100)
        let viewModel = StackedLabelViewBuilder(strings: randomStrings, viewConsumer: viewController)
        viewController.viewProvider = viewModel
        viewModel.build()
        return viewController
    }

    static func createStackedImagesController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let viewModel = StackedImagesViewBuilder(viewConsumer: viewController)
        viewController.viewProvider = viewModel
        viewModel.build()
        return viewController
    }
    
    static func createCollectionController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let viewModel = CollectionsViewBuilder(viewConsumer: viewController)
        viewController.viewProvider = viewModel
        viewModel.build()
        return viewController
    }
    
    static func generateRandomStrings(_ noOfStrings: Int) -> [String] {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return (0..<noOfStrings).map { index in
            "\(index). \(String((0..<60).map { _ in characters.randomElement()! }))"
        }
    }
}
