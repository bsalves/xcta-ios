//
//  CartItemView.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import SwiftUI

struct CartItemView: View {
    
    @Binding var item: CartItem
    
    var body: some View {
        HStack(spacing: 14) {
            AsyncImage(url: URL(string: item.image)) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        ProgressView()
                    }
                    .frame(width: 80, height: 80)
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 80, height: 80)
                case .failure:
                    ZStack {
                        Image(systemName: "picture")
                    }
                @unknown default:
                    EmptyView()
                }
            }
            VStack(alignment: .leading) {
                Text(item.title)
                VStack(alignment: .leading) {
                    Text(item.price)
                        .font(.title2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Button {
                    print("+")
                } label: {
                    Image(systemName: "plus")
                }
                .padding()
                
                Text(String(item.quantity))
                
                Button {
                    print("-")
                } label: {
                    Image(systemName: "minus")
                }
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    CartItemView(
        item: .constant(
            CartItem(
                productId: UUID(),
                image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
                title: "Calça",
                price: "$ 19,99",
                size: Product.Size(title: "P", sku: "000_P")
            )
        )
    )
}
