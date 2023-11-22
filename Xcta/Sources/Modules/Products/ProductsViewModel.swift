//
//  ProductsViewModel.swift
//  Xcta
//
//  Created by Bruno Alves on 21/11/23.
//

import Foundation

protocol ProductsViewModelProtocol: ObservableObject {
    var viewData: ProductsViewData { get set }
    var viewState: ViewState { get set }
    func loadProducts() async
}

final class ProductsViewModel: ProductsViewModelProtocol {
    
    // MARK: - Private properties
    
    private var service: ServiceWorker
    
    // MARK: - ViewState conforms
    
    var viewState: ViewState = .ready
    
    // MARK: - Internal properties
    
    @Published var viewData: ProductsViewData
    
    // MARK: - Initializer
    
    init(service: ServiceWorker, viewData: ProductsViewData = ProductsViewData()) {
        self.service = service
        self.viewData = viewData
    }
    
    // MARK: - Internal methods
    
    func loadProducts() async {
        viewState = .loading
        do {
            try await handleViewData(try await service.fetch())
            viewState = .ready
        } catch {
            viewState = .error(error)
        }
    }
    
    // MARK: - Private methods
    
    @MainActor private func handleViewData(_ data: Data) throws {
        let list = try JSONDecoder().decode(ProductList.self, from: data)
        viewData.items = list.products.map {
            Product(
                image: $0.image,
                title: $0.name,
                value: $0.regularPrice,
                promotionalValue: $0.actualPrice,
                availableSizes: $0.sizes.map {
                    Product.Size(
                        available: $0.available,
                        size: $0.size,
                        sku: $0.sku
                    )
                },
                sale: $0.onSale
            )
        }
    }
}
