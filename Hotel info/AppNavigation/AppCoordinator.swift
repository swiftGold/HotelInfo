import UIKit

final class AppCoordinator: BaseCoordinator {
    private let window: UIWindow
    private let diContainder: AppDIContainer
    private var router: Router?
    
    init(window: UIWindow,
         navigationController: UINavigationController = UINavigationController(),
         diContainder: AppDIContainer
    ) {
        self.window = window
        self.window.rootViewController = navigationController
        self.router = NavigationRouter(navigationController: navigationController)
        self.diContainder = diContainder
    }
    
    override func start() {
        window.makeKeyAndVisible()
        startChooseHotelCoordinator()
    }
}

private extension AppCoordinator {
    func startChooseHotelCoordinator() {
        guard let router else { return }
        let chooseHotelCoordinator = diContainder.makeChooseHotelCoordinator(router: router)
        addChild(chooseHotelCoordinator)
        chooseHotelCoordinator.start()
        chooseHotelCoordinator.onFinish = { [weak self] in
            self?.removeChild(chooseHotelCoordinator)
            chooseHotelCoordinator.start()
        }
    }
}
