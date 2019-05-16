//
//  Data.swift
//  storeRecipes
//
//  Created by Veronika Goreva on 02/05/2019.
//  Copyright © 2019 Veronika Goreva. All rights reserved.
//

import UIKit

class Recipes {
    var name: String
    var ingredients: String
    var image: String
    
    init(name: String, ingredients: String, image: String) {
        self.name =  name
        self.ingredients = ingredients
        self.image = image
    }
    convenience init() {
        self.init(name: "", ingredients: "", image: "")
    }
}

