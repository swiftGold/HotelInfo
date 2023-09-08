import UIKit

struct ChooseHotelModuleDependencies {
    let chooseHotelApiService: APIServiceProtocol
    let chooseHotelNetworkService: Networkable
}

final class ChooseHotelDIContainer {
    private let dependencies: ChooseHotelModuleDependencies
    
    init(dependencies: ChooseHotelModuleDependencies) {
        self.dependencies = dependencies
    }
}

extension ChooseHotelDIContainer {
    func makeHotelViewController(router: HotelRouterInput) -> UIViewController {
        let viewController = HotelViewController()
        let viewModel = HotelViewModel(apiService: dependencies.chooseHotelApiService)
        viewController.viewModel = viewModel
        viewController.router = router
        return viewController
    }
    
    func makeAppartmentViewController(router: AppartmentRouterInput) -> UIViewController {
        let viewController = AppartmentViewController()
        let viewModel = AppartmentViewModel(apiService: dependencies.chooseHotelApiService)
        viewController.viewModel = viewModel
        viewController.router = router
        return viewController
    }
    
    func makeBookingViewController(router: BookingRouterInput) -> UIViewController {
        let viewController = BookingViewController()
        let viewModel = BookingViewModel(apiService: dependencies.chooseHotelApiService)
        viewController.viewModel = viewModel
        viewController.router = router
        return viewController
    }
    
    func makePaidForViewController(router: PaidForRouterInput) -> UIViewController {
        let viewController = PaidForViewController()
        let viewModel = PaidForViewModel()
        viewController.viewModel = viewModel
        viewController.router = router
        return viewController
    }
}
