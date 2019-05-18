//
//  HeaderUIView.swift
//  storeRecipes
//
//  Created by Veronika Goreva on 14/05/2019.
//  Copyright © 2019 Veronika Goreva. All rights reserved.
//

import UIKit

class HeaderUIView: UIView {

    @IBOutlet var headerRecipeImage: UIImageView! 
//        didSet{
//            let aspectRatioConstraint = NSLayoutConstraint(item: headerRecipeImage, attribute: .height, relatedBy: .equal, toItem: headerRecipeImage.superview, attribute: .width, multiplier: (2.0/1.0), constant: 0)
//            headerRecipeImage.addConstraint(aspectRatioConstraint)
//
//        }
    
    @IBOutlet var nameRecipeLabel: UILabel!{
        didSet{
            nameRecipeLabel.numberOfLines = 0
            nameRecipeLabel.layer.cornerRadius = 5.0
            nameRecipeLabel.layer.masksToBounds = true
           
        }
    }
    @IBOutlet var typeRecipeLabel: UILabel! {
        didSet{
            typeRecipeLabel.numberOfLines = 0
            typeRecipeLabel.layer.cornerRadius = 5.0
            typeRecipeLabel.layer.masksToBounds = true
           
        }
    }

}
