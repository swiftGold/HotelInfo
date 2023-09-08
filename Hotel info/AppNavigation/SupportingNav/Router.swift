import UIKit

protocol Router: AnyObject {
  func setRoot(_ viewController: UIViewController,
               embedNavBar: Bool,
               isNavigationBarHidden: Bool
  )
  func push(_ viewController: UIViewController, animated: Bool)
  func popToRoot(animated: Bool)
}
