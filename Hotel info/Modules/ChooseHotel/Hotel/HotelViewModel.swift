//
//  HotelViewModel.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 31.08.2023.
//

final class HotelViewModel {
    var sectionModels: Box<[HotelSectionModel]> = Box([])
    
    private var responseHotelModel: ResponseHotelModel?
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func viewDidLoad() {
        fetchModel()
    }
}

private extension HotelViewModel {
    func fetchModel() {
        Task(priority: .utility) {
            do {
                responseHotelModel = try await apiService.fetchHotelInfo()
                await MainActor.run(body: {
                    buildSectionModel(from: responseHotelModel)
                })
            } catch {
                await MainActor.run(body: {
                    print(error, error.localizedDescription)
                })
            }
        }
    }
    
    func fetchHotelDescription(from model: ResponseHotelModel?) -> HotelMainModel? {
        if let model = model {
            let hotelMainModel = HotelMainModel(id: model.id,
                                                images: model.image_urls,
                                                name: model.name,
                                                adress: model.adress,
                                                minimal_price: model.minimal_price,
                                                price_for_it: model.price_for_it,
                                                rating: model.rating,
                                                rating_name: model.rating_name
            )
            return hotelMainModel
        } else {
            return nil
        }
    }
    
    func fetchHotelInfo(from model: ResponseHotelModel?) -> HotelInfoModel? {
        if let model = model {
            let hotelInfoModel = HotelInfoModel(description: model.about_the_hotel.description,
                                                peculiarities: model.about_the_hotel.peculiarities
            )
            return hotelInfoModel
        } else {
            return nil
        }
    }
    
    func buildSectionModel(from model: ResponseHotelModel?) {
        guard let hotelModel = fetchHotelDescription(from: model),
              let hotelInfoModel = fetchHotelInfo(from: model) else {
            return
        }
        
        sectionModels.value = [
            HotelSectionModel(type: .hotelMain, rows: [.hotelMain(model: hotelModel)]),
            HotelSectionModel(type: .hotelInfo, rows: [.hotelInfo(model: hotelInfoModel)])
        ]
    }
}
