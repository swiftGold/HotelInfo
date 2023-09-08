class BaseCoordinator: Coordinator {
  private var childCoordinators: [Coordinator] = []
  
  func start() {}
}

extension BaseCoordinator {
  func addChild(_ coordinator: Coordinator) {
    guard !childCoordinators.contains(where: { $0 === coordinator }) else {
      return
    }
  }
  
  func removeChild(_ coordinator: Coordinator) {
    guard !childCoordinators.isEmpty else {
      return
    }
    
    if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
      coordinator.childCoordinators.filter { $0 !== coordinator }.forEach { coordinator.removeChild($0) }
    }
    
    for (index, element) in childCoordinators.enumerated() where element === coordinator {
      childCoordinators.remove(at: index)
      break
    }
  }
}
