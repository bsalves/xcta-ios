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
    @State var presentPopover = false
    @EnvironmentObject var cartViewModel: CartViewModel
    
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
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Menu {
                    switch viewModel.filter {
                    case .all:
                        Button(action: { viewModel.filter = .sale }) {
                            Text("Somente promoções")
                        }
                    case .sale:
                        Button(action: { viewModel.filter = .all }) {
                            Text("Mostrar tudo")
                        }
                    }
                } label: {
                    Label("Filtrar", systemImage: "line.3.horizontal.decrease.circle")
                }
            }
        }
        .navigationTitle(viewModel.viewData.viewTitle)
        .task { await viewModel.loadProducts() }
        .confirmationDialog("Adicionar ao carrinho?", isPresented: $viewModel.showAlertAddCart) {
            if let selectedProduct = viewModel.selectedProduct {
                ForEach(selectedProduct.availableSizes, id: \.title) { size in
                    Button(size.title) {
                        viewModel.setSelectedSize(size)
                        cartViewModel.addProduct(
                            selectedProduct,
                            size: size
                        )
                    }
                }
            }
        }
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
                        sizes: item.availableSizes.map { $0.title },
                        sale: item.sale
                    )
                    .onTapGesture { viewModel.tapProduct(item) }
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
                                title: "P",
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
