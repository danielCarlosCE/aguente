import XCTest
@testable import Aguente

class ReaderViewControllerTestCase: XCTestCase {

    var readerVC: ReaderViewController!
    var mockReader = MockCodeReader()

    override func setUp() {
        super.setUp()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        readerVC = mainStoryboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController

        readerVC.dataSource = MockDataSource()
        readerVC.codeReader = mockReader

        let window = UIApplication.shared.delegate!.window!
        window!.rootViewController = readerVC

    }

    func testItFiresRightEventWhenKnownCodeIsRead() {
        let exp = expectation(description: "calls didFindCard")

        //given
        var didFindCardWasCalled = false
        readerVC.didFindCard = { _ in
            didFindCardWasCalled = true
            exp.fulfill()
        }
        //when
        mockReader.completion?("123")

        //then
        waitForExpectations(timeout: 3) { error in
            XCTAssert(didFindCardWasCalled)
            XCTAssertNil(error)
        }

    }

    func testItFiresRightEventWhenUnKnownCodeIsRead() {
        let exp = expectation(description: "calls didReadUnknownCode")

        //given
        var didReadUnknownCodeWasCalled = false
        readerVC.didReadUnknownCode = { _ in
            didReadUnknownCodeWasCalled = true
            exp.fulfill()
        }
        //when
        mockReader.completion?("ABC")

        //then
        waitForExpectations(timeout: 3) { error in
            XCTAssert(didReadUnknownCodeWasCalled)
            XCTAssertNil(error)
        }
        
    }

}
