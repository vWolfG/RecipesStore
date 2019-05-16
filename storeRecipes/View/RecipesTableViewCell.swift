//
//  RecipesTableViewCell.swift
//  storeRecipes
//
//  Created by Veronika Goreva on 02/05/2019.
//  Copyright © 2019 Veronika Goreva. All rights reserved.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {

    @IBOutlet var MealNameLabel: UILabel! {
        didSet{
            MealNameLabel.numberOfLines = 0
        }
    }
    @IBOutlet var MealImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
