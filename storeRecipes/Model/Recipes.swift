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
    var type: String
    var ingredients: String
    var image: String
    var steps: String
    
    init(name: String, type: String,  ingredients: String, image: String, steps: String) {
        self.name =  name
        self.ingredients = ingredients
        self.image = image
        self.type = type
        self.steps = steps
    }
    convenience init() {
        self.init(name: "", type:"", ingredients: "", image: "", steps: "")
    }
}

