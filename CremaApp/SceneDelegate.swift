import UIKit
import Turbo

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private let navigationController = UINavigationController()
    private lazy var session: Session = {
        let session = Session()
        session.delegate = self
        return session
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // iOS has concept of scene where it can have
        // multiple windows running at the same time
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // Create a window visual that we can run on
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = navigationController
        self.window?.rootViewController?.view.backgroundColor = .orange
        self.window?.makeKeyAndVisible()

        visit()
    }

    private func visit() {
        let url = URL(string: "http://localhost:3000")!
        let controller = VisitableViewController(url: url)

        session.visit(controller, action: .advance)
        navigationController.pushViewController(controller, animated: true)
    }
}

extension SceneDelegate: SessionDelegate {
    func session(_ session: Session, didProposeVisit proposal: VisitProposal) {
        let controller = VisitableViewController(url: proposal.url)
        session.visit(controller, options: proposal.options)
        navigationController.pushViewController(controller, animated: true)
    }

    func session(_ session: Session, didFailRequestForVisitable visitable: Visitable, error: Error) {
        print("didFailRequestForVisitable: \(error)")
    }

    func sessionWebViewProcessDidTerminate(_ session: Session) {
        session.reload()
    }
}
