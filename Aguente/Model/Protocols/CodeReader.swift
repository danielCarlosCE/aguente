import UIKit

protocol CodeReader {
    func startReading(completion: @escaping (String) -> Void)
    func stopReading()
    var videoPreview: CALayer {get}
}
