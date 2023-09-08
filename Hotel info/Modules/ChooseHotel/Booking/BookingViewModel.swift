//
//  BookingViewModel.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 05.09.2023.
//

final class BookingViewModel {
    var sectionModels: Box<[BookingSectionModel]> = Box([])
    var sumFromModel: Box<String> = Box("")
    
    private var responseBookingModel: ResponseBookingModel?
    private let apiService: APIServiceProtocol
    private var addCounts = 0
    private var touristNumbers: [TouristNumber] = [TouristNumber(stringNumber: Strings.firstTourist)]
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func viewDidLoad() {
        fetchModel()
    }
    
    func addTourist() {
        if addCounts < 3 {
            addCounts += 1
            if addCounts == 1 {
                touristNumbers.append(TouristNumber(stringNumber: Strings.secondTourist))
            } else if addCounts == 2 {
                touristNumbers.append(TouristNumber(stringNumber: Strings.thirdTourist))
            } else if addCounts == 3 {
                touristNumbers.append(TouristNumber(stringNumber: Strings.fourthTourist))
            }
            var models: [BookingRow] = sectionModels.value[3].rows
            models.append(.tourist(model: touristNumbers))
            sectionModels.value[3] = BookingSectionModel(type: .tourist, rows: models)
        }
    }
}

private extension BookingViewModel {
    func fetchModel() {
        Task(priority: .utility) {
            do {
                responseBookingModel = try await apiService.fetchBookingInfo()
                await MainActor.run(body: {
                    buildSectionModel(from: responseBookingModel)
                    getSum(from: responseBookingModel)
                })
            } catch {
                await MainActor.run(body: {
                    print(error, error.localizedDescription)
                })
            }
        }
    }
    
    func getSum(from model: ResponseBookingModel?) {
        var sum = ""
        
        if let model = model {
            sum = (model.fuel_charge + model.service_charge + model.tour_price).intToString().separate()
        }
        
        sumFromModel.value = sum
    }
    
    func fetchAboutHotelModel(from model: ResponseBookingModel?) -> AboutHotelModel? {
        if let model = model {
            let aboutHotelModel = AboutHotelModel(hotel_name: model.rating_name,
                                                  hotel_adress: model.hotel_adress,
                                                  horating: model.horating,
                                                  rating_name: model.rating_name
            )
            return aboutHotelModel
        } else {
            return nil
        }
    }
    
    func fetchBookingDataModel(from model: ResponseBookingModel?) -> BookingDataModel? {
        if let model = model {
            let bookingDataModel = BookingDataModel(departure: model.departure,
                                                    arrival_country: model.arrival_country,
                                                    tour_date_start: model.tour_date_start,
                                                    tour_date_stop: model.tour_date_stop,
                                                    number_of_nights: model.number_of_nights,
                                                    room: model.room,
                                                    nutrition: model.nutrition
            )
            return bookingDataModel
        } else {
            return nil
        }
    }
    
    func fetchFinalPriceModel(from model: ResponseBookingModel?) -> FinalPriceModel? {
        if let model = model {
            let finalPriceModel = FinalPriceModel(tour_price: model.tour_price,
                                                  fuel_charge: model.fuel_charge,
                                                  service_charge: model.service_charge
            )
            return finalPriceModel
        } else {
            return nil
        }
    }
    
    func buildSectionModel(from model: ResponseBookingModel?) {
        guard let aboutHotelModel = fetchAboutHotelModel(from: model),
              let bookingDataModel = fetchBookingDataModel(from: model),
              let finalPriceModel = fetchFinalPriceModel(from: model) else {
            return
        }
        
        let touristNumbers = [TouristNumber(stringNumber: Strings.firstTourist)]
        
        sectionModels.value = [
            BookingSectionModel(type: .aboutHotel, rows: [.aboutHotel(model: aboutHotelModel)]),
            BookingSectionModel(type: .bookingData, rows: [.bookingData(model: bookingDataModel)]),
            BookingSectionModel(type: .buyerInfo, rows: [.buyerInfo]),
            BookingSectionModel(type: .tourist, rows: [.tourist(model: touristNumbers)]),
            BookingSectionModel(type: .addTourist, rows: [.addTourist]),
            BookingSectionModel(type: .finalPrice, rows: [.finalPrice(model: finalPriceModel)])
        ]
    }
}
