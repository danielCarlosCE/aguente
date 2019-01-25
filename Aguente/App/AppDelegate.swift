import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appCoordinator = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.rootViewController = appCoordinator.rootViewController
        window?.makeKeyAndVisible()

        setupStyle()

        return true
    }

    private func setupStyle() {
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = .white
    }

}

