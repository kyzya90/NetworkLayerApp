//
//  aCell.swift
//  NetworkLayer
//
//  Created by Aleksandr Kazmin on 07.11.2024.
//

import SwiftUI

private enum Constants {
    static let spacing: CGFloat = 8
    static let borderHeight: CGFloat = 1
    static let imageSize: CGFloat = 88
}

struct aCellData: Identifiable {
    let title: String
    let description: String
    let imageUrl: URL
    let id: String

    init(title: String, description: String, imageUrl: URL) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.id = title
    }
}

struct aCell: View {
    private let cellData: aCellData
    
    init(cellData: aCellData) {
        self.cellData = cellData
    }

    var body: some View {
        VStack(spacing: Constants.spacing) {
            Rectangle()
                .frame(height: Constants.borderHeight)
                .foregroundColor(.clear)
            HStack() {
                Rectangle()
                    .frame(width: 0, height: 0)
                Circle().foregroundColor(.yellow)
                    .frame(width: Constants.imageSize)
                VStack {
                    Text(cellData.title)
                        .font(.headline)
                        .bold()
                        
                    Text(cellData.description)
                }
                Spacer()
            }
            Rectangle()
                .frame(height: Constants.borderHeight)
                .foregroundColor(.green)
        }
    }
}

#Preview("Big", traits: .sizeThatFitsLayout) {
    aCell(cellData: aCellData(title: "Some short but big text",
                              description: "some very long text which contains 5 lines fg kskekfka kek kdf gnnre mmmsd mamwmw me end",
                              imageUrl: URL(fileURLWithPath: "")))
    
}

#Preview("Small", traits: .sizeThatFitsLayout) {
    aCell(cellData: aCellData(title: "Some short but big text",
                              description: "some very long ",
                              imageUrl: URL(fileURLWithPath: "")))

}
