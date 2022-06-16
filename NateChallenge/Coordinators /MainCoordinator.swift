//
//  MainCoordinator.swift
//  NateChallenge
//
//  Created by Amy Ha on 14/06/2022.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    let productListViewController = ProductListViewController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        productListViewController.coordinator = self
        navigationController.pushViewController(productListViewController, animated: false)
    }
    
    func moveToDetailViewController(with viewModel: ProductListViewModel, of product: Product) {
        let detailViewController = DetailViewController(viewModel: viewModel, with: product)
        navigationController.present(detailViewController, animated: true)
    }
}
