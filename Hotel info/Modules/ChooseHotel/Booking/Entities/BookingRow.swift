//
//  BookingRow.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 05.09.2023.
//

enum BookingRow {
    case aboutHotel(model: AboutHotelModel)
    case bookingData(model: BookingDataModel)
    case buyerInfo
    case tourist(model: [TouristNumber])
    case addTourist
    case finalPrice(model: FinalPriceModel)
}
