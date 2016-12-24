import UIKit
@testable import Aguente

class MockCodeReader: CodeReader {
    var completion: ((String) -> Void)?
    func startReading(completion: @escaping (String) -> Void) {
        self.completion = completion
    }
    func stopReading() {}
    private(set) var videoPreview = CALayer()
}
