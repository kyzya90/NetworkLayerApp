//
//  NetworkLayerScreenModel.swift
//  NetworkLayer
//
//  Created by Aleksandr Kazmin on 07.11.2024.
//

import Foundation
struct NetworkLayerScreenModel {
    let header: Header
    let items: [aCellData]

    init(header: Header, items: [aCellData]) {
        self.header = header
        self.items = items
    }
}
