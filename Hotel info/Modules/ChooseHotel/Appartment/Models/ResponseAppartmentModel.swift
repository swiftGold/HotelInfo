//
//  ResponseAppartmentModel.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 04.09.2023.
//

struct ResponseAppartmentModel: Decodable {
    let rooms: [RoomModel]
}

struct RoomModel: Decodable {
    let id: Int
    let name: String
    let price: Int
    let price_per: String
    let peculiarities: [String]
    let image_urls: [String]
}
