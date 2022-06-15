//
//  DetailViewController.swift
//  NateChallenge
//
//  Created by Amy Ha on 14/06/2022.
//

import UIKit

class DetailViewController: UIViewController {
 
    var removeButton = UIButton()
    var addToCartButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpRemoveButton()
        setUpAddToCartButton()
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
}
