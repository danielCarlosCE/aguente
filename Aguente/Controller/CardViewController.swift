import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var cardDescription: UILabel!

    var card: Card!

    override func viewDidLoad() {
        cardImage.image = UIImage(named: card.imageName)
        cardTitle.text = card.title
        cardDescription.text = card.description
    }

}
