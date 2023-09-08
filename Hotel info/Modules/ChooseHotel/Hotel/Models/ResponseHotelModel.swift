//
//  ResponseHotelModel.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 31.08.2023.
//

struct ResponseHotelModel: Decodable {
    let id: Int
    let name: String
    let adress: String
    let minimal_price: Int
    let price_for_it: String
    let rating: Int
    let rating_name: String
    let image_urls: [String]
    let about_the_hotel: AboutTheHotelModel
}

struct AboutTheHotelModel: Decodable {
    let description: String
    let peculiarities: [String]
}
