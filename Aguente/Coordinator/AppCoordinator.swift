import UIKit

class AppCoordinator {
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let navigation: UINavigationController

    init() {
        navigation = mainStoryboard.instantiateInitialViewController() as! UINavigationController
    }

    var rootViewController: UIViewController {
        let readerViewController = navigation.viewControllers.first as! ReaderViewController
        setup(readerViewController)

        return navigation
    }

    private func setup(_ readerViewController: ReaderViewController) {
        readerViewController.codeReader = AVCodeReader()
        readerViewController.dataSource = MockDataSource()

        readerViewController.didFindCard = { [weak self] card in
            self?.showCard(card)
        }
        readerViewController.didReadUnknownCode = { [weak self] unknownCode in
            self?.showAlert(for: unknownCode)
        }
    }

    private func showCard(_ card: Card) {
        let identifier = "CardViewController"
        let cardViewController = mainStoryboard.instantiateViewController(withIdentifier: identifier) as! CardViewController
        cardViewController.card = card

        navigation.pushViewController(cardViewController, animated: true)
    }

    private func showAlert(for unknownCode: String) {
        let errorMessage = "We could not find a card for code \(unknownCode)"

        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            (self?.navigation.viewControllers.first as? ReaderViewController)?.viewWillAppear(false)
        }))

        navigation.present(alertController, animated: true, completion: nil)
    }
}
