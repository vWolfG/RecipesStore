//
//  RecipesTableViewController.swift
//  storeRecipes
//
//  Created by Veronika Goreva on 02/05/2019.
//  Copyright © 2019 Veronika Goreva. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    var RecipesStore = [ Recipes(name:"Lazani", type: "Breakfast", ingredients: "hihihihi", image: "breakfast", steps: "sksmdsfdf"),
                       Recipes(name:"Картоха", type: "Lunch", ingredients: "Много картохи", image: "lunch", steps: "sksmdsfdf"),
                       Recipes(name:"Салатик", type: "Dinner", ingredients: "Овощи там всякие", image: "dinner", steps: "sksmdsfdf"), Recipes(name:"Sladkoe", type: "Dessert", ingredients: "Овощи там всякие", image: "pudding", steps: "sksmdsfdf") ]
    var TypeRecipes: String!
    
    var recipesList = Array<Recipes>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // tableView.tableFooterView = UIView() // delete empty rows
        
        navigationController?.navigationBar.isHidden = false
        
        //transparent nav bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        self.title = "Recipes for " + TypeRecipes.lowercased()
       
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
       
        if let customFont = UIFont(name: "IndieFlower", size: 26.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: customFont]
        }
 
        
        
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super .viewWillAppear(animated)
//
//
//    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        recipesList = RecipesStore.filter{$0.type.contains(TypeRecipes) != false }
        return recipesList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipesTableViewCell
        
        recipesList = RecipesStore.filter{$0.type.contains(TypeRecipes) != false }
       // if RecipesStore
        
        cell.MealNameLabel.text = recipesList[indexPath.row].name
        cell.MealImage.image = UIImage(named: recipesList[indexPath.row].image)
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        
    }
   






   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController =  segue.destination as! DetailViewController
                destinationController.recipesStore = recipesList[indexPath.row]
            }
           
        }
    }
    

}
