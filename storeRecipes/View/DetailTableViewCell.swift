//
//  DetailTableViewCell.swift
//  storeRecipes
//
//  Created by Veronika Goreva on 16/05/2019.
//  Copyright © 2019 Veronika Goreva. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel! {
        didSet{
            if let customFont = UIFont(name: "IndieFlower", size: 20.0) {
                titleLabel.font = customFont
            }
            
        }
    }
    
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
            descriptionLabel.layer.cornerRadius = 5.0
            descriptionLabel.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
