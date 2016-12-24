import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.rootViewController = AppCoordinator().rootViewController
        window?.makeKeyAndVisible()

        setupStyle()

        return true
    }

    private func setupStyle() {
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = .white
    }

}

