//
//  CartItemView.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import SwiftUI

struct CartItemView: View {
    
    @Binding var item: CartItem
    var removeItem: (Sku) -> Void
    
    var body: some View {
        HStack(spacing: 14) {
            photoView
            productInfoView
            quantityView
        }
        .padding()
    }
    
    private var photoView: some View {
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
                    Image(systemName: "camera")
                }
            @unknown default:
                EmptyView()
            }
        }
    }
    
    private var productInfoView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(item.title)
                ZStack {
                    Text(item.size.title)
                }
                .frame(width: 26, height: 26)
                .border(Color.black)
            }
            VStack(alignment: .leading) {
                Text(item.price).font(.title2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var quantityView: some View {
        HStack {
            Button {
                item.increase()
            } label: {
                Image(systemName: "plus")
            }
            .padding()
            
            Text(String(item.quantity))
            
            Button {
                do {
                    try item.decrease()
                } catch {
                    removeItem(item.size.sku)
                }
            } label: {
                Image(systemName: (item.quantity == 1) ? "trash" : "minus")
            }
            .padding()
        }
    }
}

#Preview {
    CartItemView(
        item: .constant(
            CartItem(
                productId: UUID(),
                image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
                title: "Calça",
                quantity: 1,
                price: "$ 19,99",
                size: Product.Size(title: "P", sku: "000_P")
            )
        ),
        removeItem: { _ in }
    )
}
