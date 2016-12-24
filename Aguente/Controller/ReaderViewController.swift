import UIKit

class ReaderViewController: UIViewController {

    @IBOutlet weak var videoPreview: UIView!
    private var videoLayer: CALayer!

    var codeReader: CodeReader!
    var dataSource: DataSource!

    var didFindCard: ((Card) -> Void)?
    var didReadUnknownCode: ((String) -> Void)?

    override func viewDidLoad() {
        videoLayer = codeReader.videoPreview
        videoPreview.layer.addSublayer(videoLayer)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoLayer.frame = videoPreview.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        codeReader.startReading { (code) in
            self.fetchCard(for: code)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        codeReader.stopReading()
    }

}

//MARK: Data Source
extension ReaderViewController {

    func fetchCard(for code: String) {
        dataSource.card(for: code) { card in
            guard let card = card else {
                self.didReadUnknownCode?(code)
                return
            }
            self.didFindCard?(card)
        }
    }

}
