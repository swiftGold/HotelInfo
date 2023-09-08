import UIKit

final class NavigationRouter {
  private let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
}

extension NavigationRouter: Router {
  func setRoot(_ viewController: UIViewController, embedNavBar: Bool, isNavigationBarHidden: Bool) {
    if embedNavBar {
      navigationController.isNavigationBarHidden = isNavigationBarHidden
      navigationController.viewControllers = [viewController]
    } else {
      navigationController.viewControllers = [viewController]
    }
  }
  
  func push(_ viewController: UIViewController, animated: Bool) {
    navigationController.pushViewController(viewController, animated: animated)
  }
  
  func popToRoot(animated: Bool) {
    navigationController.popToRootViewController(animated: animated)
  }
}
