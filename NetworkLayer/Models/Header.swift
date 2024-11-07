//
//  Header.swift
//  NetworkLayer
//
//  Created by Aleksandr Kazmin on 07.11.2024.
//

import Foundation

struct Header: Decodable {
    let title: String
    let description: String
    let imageUrl: String
}
