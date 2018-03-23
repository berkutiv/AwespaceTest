//
//  ProductCollectionViewCell.swift
//  AwespaceTest
//
//  Created by Иван on 19.03.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    
    func configureSelf(with model : Product)
    {
        configureAppearance()
        
        productName.text = model.name
        productPrice.text = model.price
        productImage.sd_setImage(with: URL(string: model.image))
    }
    
    func configureAppearance()
    {
        self.contentView.layer.cornerRadius = 7
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }

}
