//
//  BookingDataModel.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 05.09.2023.
//

struct BookingDataModel: Decodable {
    let departure: String
    let arrival_country: String
    let tour_date_start: String
    let tour_date_stop: String
    let number_of_nights: Int
    let room: String
    let nutrition: String
}
