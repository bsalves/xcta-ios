//
//  ProductsViewModel.swift
//  Xcta
//
//  Created by Bruno Alves on 21/11/23.
//

import Foundation

protocol ProductsViewModelProtocol: ObservableObject {
    var viewData: ProductsViewData { get set }
    var showAlertAddCart: Bool { get set }
    var selectedProduct: Product? { get set }
    var viewState: ViewState { get set }
    func loadProducts() async
    func tapProduct(_ product: Product)
    func setSelectedSize(_ size: Product.Size)
    func addProduct(to cart: Cart)
}

final class ProductsViewModel: ProductsViewModelProtocol {
    
    // MARK: - Private properties
    
    private var service: ServiceWorker
    
    // MARK: - ViewState conforms
    
    var viewState: ViewState = .ready
    var selectedProduct: Product?
    var selectedSize: Product.Size?
    
    // MARK: - Internal properties
    
    @Published var viewData: ProductsViewData
    @Published var showAlertAddCart = false
    
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
    
    func tapProduct(_ product: Product) {
        selectedProduct = product
        showAlertAddCart.toggle()
    }
    
    func setSelectedSize(_ size: Product.Size) {
        selectedSize = size
    }
    
    func addProduct(to cart: Cart) {
        guard let selectedProduct, let selectedSize else { return }
        cart.add(
            product: CartItem(
                productId: selectedProduct.id,
                image: selectedProduct.image,
                title: selectedProduct.title,
                price: selectedProduct.promotionalValue ?? selectedProduct.value,
                size: Product.Size(
                    title: selectedSize.title,
                    sku: selectedSize.sku
                )
            )
        )
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
                availableSizes: $0.sizes.filter {
                    $0.available
                }.map {
                    Product.Size(
                        title: $0.size,
                        sku: $0.sku
                    )
                },
                sale: $0.onSale
            )
        }
    }
}
