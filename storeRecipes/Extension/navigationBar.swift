//
//  navigationBar.swift
//  storeRecipes
//
//  Created by Veronika Goreva on 17/05/2019.
//  Copyright © 2019 Veronika Goreva. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
 
    
}
