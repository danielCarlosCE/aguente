import Foundation

protocol DataSource {
    func card(for code: String, completion: (Card?) -> Void)
}
