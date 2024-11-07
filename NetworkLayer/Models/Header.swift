//
//  Header.swift
//  NetworkLayer
//
//  Created by Aleksandr Kazmin on 07.11.2024.
//

import Foundation

struct Header: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case version
        case imageUrl = "href"
    }
    let title: String
    let version: String
    let imageUrl: String
}
