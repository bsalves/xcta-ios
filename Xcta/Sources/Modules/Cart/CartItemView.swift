//
//  CartItemView.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import SwiftUI

struct CartItemView: View {
    
    var imageURL: String
    var title: String
    var price: String
    var size: Product.Size
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        ProgressView()
                    }
                    .frame(width: 100, height: 120)
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 100, height: 120)
                case .failure:
                    ZStack {
                        Image(systemName: "picture")
                    }
                    .frame(width: 100, height: 120)
                @unknown default:
                    EmptyView()
                }
            }
                    
            VStack(alignment: .leading) {
                Text(title)
                Spacer()
                VStack(alignment: .leading) {
                    Text(price)
                        .strikethrough()
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: 120, alignment: .leading)
        }
        .padding()
    }
}

#Preview {
    CartItemView(
        imageURL: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
        title: "Calça",
        price: "$ 1,99",
        size: Product.Size(title: "P", sku: "000_P")
    )
}
