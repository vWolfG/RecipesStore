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
    @IBOutlet var nameRecipeLabel: UILabel!{
        didSet{
            nameRecipeLabel.numberOfLines = 0
            nameRecipeLabel.layer.cornerRadius = 5.0
            nameRecipeLabel.layer.masksToBounds = true
        }
    }

}
