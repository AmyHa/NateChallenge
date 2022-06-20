//
//  DetailViewController.swift
//  NateChallenge
//
//  Created by Amy Ha on 14/06/2022.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
 
    var removeButton = UIButton()
    var addToCartButton = UIButton()
    var linkButton = UIButton()
    var merchantLabel = UILabel()
    var titleLabel = UILabel()
    var imageView = UIImageView()
    
    var viewModel: ProductListViewModel?
    var product: Product?
    
    init(viewModel: ProductListViewModel, with product: Product) {
        self.viewModel = viewModel
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpImageView()
        setUpTitleLabel()
        setUpMerchantLabel()
        setUpRemoveButton()
        setUpAddToCartButton()
        setUpLinkButton()
        
        removeButton.addTarget(self, action: #selector(onTapRemoveButton), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(onTouchDownRemoveButton), for: .touchDown)
    }
    
    private func setUpImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2)
        ])
         imageView.contentMode = .scaleAspectFit
        
        if let url = product?.images.first {
            imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "imageComingSoon")) { _, error, _, _ in
                if let error = error {
                    print("Error downloading image: \(error)")
                }
            }
        } else {            
            imageView.image = UIImage(named: "imageComingSoon")
        }
    }
    
    private func setUpTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
        titleLabel.text = product?.title.uppercased()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
    
    private func setUpMerchantLabel() {
        view.addSubview(merchantLabel)
        merchantLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            merchantLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            merchantLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            merchantLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
        merchantLabel.text = product?.merchant.lowercased()
        merchantLabel.textColor = .gray
        merchantLabel.numberOfLines = 0
        merchantLabel.textAlignment = .center
    }
    
    private func setUpRemoveButton() {
        view.addSubview(removeButton)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            removeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            removeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            removeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        removeButton.setTitle("I've seen it already!", for: .normal)
        removeButton.titleLabelFont = UIFont(name: "Outfit-SemiBold", size: 15)
        removeButton.setTitleColor(.white, for: .normal)
        removeButton.backgroundColor = .black
    }
    
    private func setUpAddToCartButton() {
        view.addSubview(addToCartButton)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            addToCartButton.bottomAnchor.constraint(equalTo: removeButton.topAnchor, constant: -10)
        ])
        
        addToCartButton.setTitle("ADD TO CART", for: .normal)
        addToCartButton.titleLabelFont = UIFont(name: "Outfit-SemiBold", size: 15)
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.backgroundColor = .black
    }
    
    private func setUpLinkButton() {
        view.addSubview(linkButton)
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            linkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            linkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            linkButton.topAnchor.constraint(equalTo: merchantLabel.bottomAnchor, constant: 10),
            linkButton.heightAnchor.constraint(equalTo: addToCartButton.heightAnchor, multiplier: 1)
        ])
        linkButton.setImage(UIImage(systemName: "link")?.withRenderingMode(.alwaysTemplate), for: .normal)
        linkButton.tintColor = .darkGray
        linkButton.addTarget(self, action: #selector(onTapLinkButton), for: .touchUpInside)
    }
    
    @objc
    private func onTapRemoveButton() {
        if let product = product {
            viewModel?.remove(product)
        }
        dismiss(animated: true)
    }
    
    @objc
    private func onTouchDownRemoveButton() {
        removeButton.backgroundColor = .gray
    }
    
    @objc
    private func onTapLinkButton() {
        if let url = product?.url {
            if let link = URL(string: url) {
                UIApplication.shared.open(link)
            }
        }
    }
}
