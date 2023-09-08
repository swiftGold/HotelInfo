import UIKit

final class ChooseHotelCoordinator: BaseCoordinator & CoordinatorOutput {
    var onFinish: (() -> Void)?
    
    private let router: Router
    private let diContainer: ChooseHotelDIContainer
    
    init(router: Router,
         diContainer: ChooseHotelDIContainer
    ) {
        self.router = router
        self.diContainer = diContainer
    }
    
    override func start() {
        let hotelViewController = diContainer.makeHotelViewController(router: self)
        router.setRoot(hotelViewController, embedNavBar: false, isNavigationBarHidden: false)
    }
}

extension ChooseHotelCoordinator: HotelRouterInput {
    func routeToAppartmentVC() {
        let appartmentViewController = diContainer.makeAppartmentViewController(router: self)
        router.push(appartmentViewController, animated: false)
    }
}

extension ChooseHotelCoordinator: AppartmentRouterInput {
    func routeToBookingVC() {
        let bookingViewController = diContainer.makeBookingViewController(router: self)
        router.push(bookingViewController, animated: false)
    }
}

extension ChooseHotelCoordinator: BookingRouterInput {
    func routeToPaidVC() {
        let raidForViewController = diContainer.makePaidForViewController(router: self)
        router.push(raidForViewController, animated: false)
    }
}

extension ChooseHotelCoordinator: PaidForRouterInput {
    func routeToHotelVC() {
        onFinish?()
    }
}
