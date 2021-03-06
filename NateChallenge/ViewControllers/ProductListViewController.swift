//
//  ProductListViewController.swift
//  NateChallenge
//
//  Created by Amy Ha on 14/06/2022.
//

import UIKit
import Combine
import SDWebImage

class ProductListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var coordinator: MainCoordinator?
    private var collectionView: UICollectionView!
    private var countLabel = UILabel()
    private var viewModel = ProductListViewModel()
    private var products = [Product]()
    private var cancellables: Set<AnyCancellable> = []
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        setUpCountLabel()
        setUpCollectionView()
        
        viewModel.$products
            .sink(receiveValue: { (result) in
                self.products = result
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.countLabel.text = "\(self.products.count) Items"
                }
            })
            .store(in: &cancellables)
        
        refreshControl.addTarget(self, action: #selector(onRefreshCollectionView), for: .valueChanged)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        
        if let url = products[indexPath.row].images.first {
            cell.imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "imageComingSoon")) { _, error, _, _ in
                if let error = error {
                    print("Error downloading image: \(error)")
                }
            }
        } else {
            cell.imageView.image = UIImage(named: "imageComingSoon")
        }
        
        cell.imageView.layer.cornerRadius = 20
        cell.titleLabel.text = products[indexPath.row].title.uppercased()
        cell.merchantLabel.text = products[indexPath.row].merchant.lowercased()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCols = 2
        let spaceBetweenCells = 10
        let totalInsetSpace = spaceBetweenCells*(numberOfCols - 1)
        let availableWidth = collectionView.frame.width - CGFloat(totalInsetSpace)
        let widthPerItem = availableWidth / CGFloat(numberOfCols)
        return CGSize(width:  widthPerItem, height: collectionView.frame.size.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onTapProduct(product: products[indexPath.row])
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: countLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        collectionView.refreshControl = refreshControl
    }
    
    private func setUpCountLabel() {
        view.addSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            countLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        countLabel.text = "Items"
        countLabel.textAlignment = .center
        countLabel.backgroundColor = .white
        countLabel.textColor = .black
        countLabel.accessibilityLabel = "Items"
    }
    
    func onTapProduct(product: Product) {
        coordinator?.moveToDetailViewController(with: viewModel, of: product)
    }
    
    @objc
    func onRefreshCollectionView() {
        viewModel.fetchProducts()
        self.refreshControl.endRefreshing()
    }
}

extension ProductListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !viewModel.isPaginating else { return }
        let position = scrollView.contentOffset.y
        if position > (collectionView.contentSize.height-100-scrollView.frame.size.height) {
            self.viewModel.loadNextPage()
        }
    }
}
