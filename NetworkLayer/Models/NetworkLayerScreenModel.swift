//
//  NetworkLayerScreenModel.swift
//  NetworkLayer
//
//  Created by Aleksandr Kazmin on 07.11.2024.
//

import Foundation
struct NetworkLayerScreenModel {
    let header: Header
    let body: Body

    init(header: Header, body: Body) {
        self.header = header
        self.body = body
    }
}
