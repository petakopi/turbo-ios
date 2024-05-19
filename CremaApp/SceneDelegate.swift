import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // iOS has concept of scene where it can have
        // multiple windows running at the same time
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // Create a window visual that we can run on
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = UIViewController()
        self.window?.rootViewController?.view.backgroundColor = .orange
        self.window?.makeKeyAndVisible()
    }
}

