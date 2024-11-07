//
//  Body.swift
//  NetworkLayer
//
//  Created by Aleksandr Kazmin on 07.11.2024.
//

import Foundation

struct Body: Decodable {
    enum CodingKeys: String, CodingKey {
        case cars = "results"
    }
    let cars: [Car]
}

struct Car: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case imageUrl = "href"
        case description
        case thumbnail
    }
    let title: String
    let imageUrl: URL
    let description: String
    let thumbnail: URL
}
