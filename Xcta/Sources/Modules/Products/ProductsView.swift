//
//  ProductsView.swift
//  Xcta
//
//  Created by Bruno Alves on 21/11/23.
//

import SwiftUI

struct ProductsView<ViewModel: ProductsViewModelProtocol>: View {
    
    // MARK: - Private property
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .ready:
                content
            case .loading:
                ProgressView()
            case .error(let error):
                Text(error.localizedDescription)
            }
        }
        .navigationTitle(viewModel.viewData.viewTitle)
        .task { await viewModel.loadProducts() }
    }
    
    private var content: some View {
        ScrollView {
            LazyVStack(content: {
                ForEach(viewModel.viewData.items, id: \.id) { item in
                    ProductItemView(
                        imageURL: item.image,
                        title: item.title,
                        regularPrice: item.value,
                        actualPrice: item.promotionalValue,
                        sizes: item.availableSizes.map { $0.size }
                    )
                }
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ProductsView(
        viewModel: ProductsViewModel(
            service: Mockup(),
            viewData: ProductsViewData(
                items: [
                    Product(
                        image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
                        title: "Calça de Shopping",
                        value: "$ 19,99",
                        promotionalValue: "$ 9,99",
                        availableSizes: [
                            Product.Size(
                                available: true,
                                size: "P",
                                sku: "000_P"
                            )
                        ],
                        sale: true
                    ),
                    Product(
                        image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
                        title: "Calça de Shopping",
                        value: "$ 19,99",
                        promotionalValue: "$ 9,99",
                        availableSizes: [
                            Product.Size(
                                available: true,
                                size: "P",
                                sku: "000_P"
                            )
                        ],
                        sale: true
                    )
                ]
            )
        )
    )
}
