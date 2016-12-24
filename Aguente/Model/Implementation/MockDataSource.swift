import Foundation

class MockDataSource: DataSource {
    private var cards: [Card] {
        let tris = Card(code: "123", imageName: "tris", title: "Triss Merigold",
                        description: "Remove 4 strength from 1 opposing unit(s).")
        let yennifer = Card(code: "124", imageName: "yennifer", title: "Yennifer",
                            description: "Spawn either a Unicorn or a Chironex.")
        let ciri = Card(code: "125", imageName: "ciri", title: "Ciri",
                         description: "Return to your hand if you lose the round.")
        let geralt = Card(code: "126", imageName: "geralt", title: "Geralt",
                          description: "No ability.")

        return [tris, yennifer, ciri, geralt]
    }
    func card(for code: String, completion: (Card?) -> Void) {
        completion(cards.filter{ $0.code == code }.first)
    }
}
