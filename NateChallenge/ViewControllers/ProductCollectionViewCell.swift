//
//  ProductCollectionViewCell.swift
//  NateChallenge
//
//  Created by Amy Ha on 14/06/2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductCollectionViewCell"
    
    func heightForView(text:String, width:CGFloat) -> CGFloat{
       let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
       label.numberOfLines = 4
       label.text = text
       label.sizeToFit()
       return label.frame.height
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = Colours.primaryBackground
        imageView.image = UIImage(named: "imageComingSoon")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Product Title"
        label.textAlignment = .center
        label.numberOfLines = 4
        label.textColor = .black
        return label
    }()
    
    let merchantLabel: UILabel = {
        let label = UILabel()
        label.text = "Merchant"
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(merchantLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleLabelHeight = heightForView(text: titleLabel.text ?? "", width: contentView.frame.size.width-16)
        let imageViewHeight = contentView.frame.size.height*(2/3)
        imageView.frame = CGRect(x: 8, y: 0, width: contentView.frame.size.width-16, height: imageViewHeight)
        titleLabel.frame = CGRect(x: 8, y: imageViewHeight, width: contentView.frame.size.width-16, height: titleLabelHeight)
        merchantLabel.frame = CGRect(x: 8, y: imageViewHeight + titleLabelHeight, width: contentView.frame.size.width-16, height: 20)
    }
}
