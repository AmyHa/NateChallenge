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
    private var viewModel = ProductListViewModel()
    private var products = [Product]()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        setUpCollectionView()
        
        viewModel.$products
            .sink(receiveValue: { (result) in
                self.products = result
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
            .store(in: &cancellables)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        

    
        if products[indexPath.row].images.count > 0 {
            let imageURL = URL(string: products[indexPath.row].images[0])
            cell.imageView.sd_setImage(with: imageURL) { image, error, cacheType, downloadURL in
                if let error = error {
                    print("Error downloading image: \(error)")
                    if let defaultImage = UIImage(named: "imageComingSoon") {
                        cell.imageView.image = defaultImage
                    }
                }
            }
        }
        
        cell.imageView.layer.cornerRadius = 20
        cell.titleLabel.text = products[indexPath.row].title
        cell.merchantLabel.text = products[indexPath.row].merchant
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
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onTapProduct(product: products[indexPath.row])
    }
    
    func onTapProduct(product: Product) {
        coordinator?.moveToDetailViewController(of: product)
    }
}
