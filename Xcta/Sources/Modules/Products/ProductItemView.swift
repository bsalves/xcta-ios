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
    var sale: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            productPhotoView
            productInfoView
        }
        .padding()
    }
    
    private var productPhotoView: some View {
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
                    Image(systemName: "camera")
                }
                .frame(width: 100, height: 120)
            @unknown default:
                EmptyView()
            }
        }
    }
    
    private var productInfoView: some View {
        VStack(alignment: .leading) {
            if sale {
                HStack {
                    Text("Promoção!")
                    Image(systemName: "tag")
                }
                .foregroundColor(.red)
            }
            Text(title)
            Spacer()
            VStack(alignment: .leading) {
                if let actualPrice, sale {
                    
                    Text(regularPrice)
                        .strikethrough()
                        .font(.caption)
                    Text(actualPrice)
                        .font(.title2)
                } else {
                    Text(regularPrice)
                        .font(.title2)
                    Spacer()
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
}

#Preview {
    ProductItemView(
        imageURL: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
        title: "Calça",
        regularPrice: "$ 1,99",
        actualPrice: "$ 0,99",
        sizes: ["X", "P", "M"], 
        sale: true
    )
}
