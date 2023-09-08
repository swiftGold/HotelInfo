final class AppDIContainer {
    private let networkService: Networkable
    private let apiService: APIServiceProtocol
    
    init(networkService: Networkable,
         apiService: APIServiceProtocol
    ) {
        self.networkService = networkService
        self.apiService = apiService
    }
    
    convenience init() {
        let jsonService = JSONDecoderManager()
        let networkService = NetworkManager(jsonService: jsonService)
        let apiService = APIService(networkManager: networkService)
        
        self.init(networkService: networkService,
                  apiService: apiService
        )
    }
}

extension AppDIContainer {
    func makeChooseHotelCoordinator(router: Router) -> CoordinatorOutput {
        let dependencies = ChooseHotelModuleDependencies(chooseHotelApiService: apiService,
                                                         chooseHotelNetworkService: networkService
        )
        let diContainer = ChooseHotelDIContainer(dependencies: dependencies)
        let chooseHotelCoordinator = ChooseHotelCoordinator(router: router,
                                                            diContainer: diContainer
        )
        return chooseHotelCoordinator
    }
}
