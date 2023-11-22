//
//  ProductItemView.swift
//  Xcta
//
//  Created by Bruno Alves on 21/11/23.
//

import SwiftUI

struct ProductItemView: View {
    
    var imageURL: String
    var title: String
    var regularPrice: String
    var actualPrice: String?
    var sizes: [String]
    
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
                    if let actualPrice {
                        Text(regularPrice)
                            .strikethrough()
                            .font(.caption)
                        Text(actualPrice)
                            .font(.title2)
                    } else {
                        Text(regularPrice)
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                HStack {
                    ForEach(sizes, id: \.self) { size in
                        ZStack {
                            Text(size)
                        }
                        .frame(width: 26, height: 26)
                        .border(Color.black)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 120, alignment: .leading)
        }
        .padding()
    }
}

#Preview {
    ProductItemView(
        imageURL: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
        title: "Calça",
        regularPrice: "$ 1,99",
        actualPrice: "$ 0,99",
        sizes: ["X", "P", "M"]
    )
}
