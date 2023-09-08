import Foundation

protocol APIServiceProtocol {
    func fetchHotelInfo() async throws -> ResponseHotelModel
    func fetchAppartmentInfo() async throws -> ResponseAppartmentModel
    func fetchBookingInfo() async throws -> ResponseBookingModel
}

final class APIService {
    private let networkManager: Networkable
    
    init(networkManager: Networkable) {
        self.networkManager = networkManager
    }
}

extension APIService: APIServiceProtocol {
    func fetchHotelInfo() async throws -> ResponseHotelModel {
        let url = getHotelInfoURL()
        return try await networkManager.request(urlString: url)
    }
    
    func fetchAppartmentInfo() async throws -> ResponseAppartmentModel {
        let url = getAppartmentInfoURL()
        return try await networkManager.request(urlString: url)
    }
    
    func fetchBookingInfo() async throws -> ResponseBookingModel {
        let url = getBookingURL()
        return try await networkManager.request(urlString: url)
    }
}

private extension APIService {
    func getHotelInfoURL() -> String {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "run.mocky.io"
        components.path = "/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3"
        guard let url = components.url?.absoluteString else {
            fatalError()
        }
        return url
    }
    
    func getAppartmentInfoURL() -> String {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "run.mocky.io"
        components.path = "/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd"
        guard let url = components.url?.absoluteString else {
            fatalError()
        }
        return url
    }
    
    func getBookingURL() -> String {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "run.mocky.io"
        components.path = "/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8"
        guard let url = components.url?.absoluteString else {
            fatalError()
        }
        return url
    }
}
