//
//  RecipesViewController.swift
//  storeRecipes
//
//  Created by Veronika Goreva on 09/05/2019.
//  Copyright © 2019 Veronika Goreva. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController{
    
    @IBOutlet var imageViewBackground: UIImageView!
    
    
    @IBOutlet var recipesTypesButtons: [UIButton]! {
        didSet {
            for i in 0...recipesTypesButtons.count - 1 {
                recipesTypesButtons[i].tag = i + 1
                recipesTypesButtons[i].layer.cornerRadius = 10.0
                recipesTypesButtons[i].layer.borderColor = UIColor.black.cgColor
                recipesTypesButtons[i].layer.borderWidth = 1.0
                recipesTypesButtons[i].titleLabel?.numberOfLines = 0
            }
        }
    }
    
    var type: String! = ""
    
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = true
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.tintColor = .black
       

    }
    
    
   // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableRecipes" {
            let destinationNavController = segue.destination as! UINavigationController
            let destinationController = destinationNavController.topViewController as! RecipesTableViewController
            destinationController.TypeRecipes = self.type
        }
    }
    
    
    @IBAction func showTableRecipes(_ sender: UIButton!) {
        
        switch sender.tag{
        case 1:
            self.type = "Breakfast"
        case 2:
            self.type = "Lunch"
        case 3:
            self.type = "Dinner"
        case 4:
            self.type = "Dessert"
        default:
            self.type = ""
        }
        self.performSegue(withIdentifier: "tableRecipes", sender: self)
    }
    
  
    @IBAction func goToBackRecipesType(segue:UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
        //print("out of here")
    }

}
