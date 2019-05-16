//
//  RecipesTableViewController.swift
//  storeRecipes
//
//  Created by Veronika Goreva on 02/05/2019.
//  Copyright © 2019 Veronika Goreva. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    var RecipesType = ["Breakfast" : Recipes(name:"Lazani", ingredients: "hihihihi", image: ""),
                       "Lunch": Recipes(name:"Картоха", ingredients: "Много картохи", image: ""),
                       "Dinner": Recipes(name:"Салатик", ingredients: "Овощи там всякие", image: ""),"Dessert": Recipes(name:"Sladkoe", ingredients: "Овощи там всякие", image: "")
    ]
    var TypeRecipes: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView() // delete empty rows
        
        navigationController?.navigationBar.isHidden = false
        //transparent nav bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "Recipes for " + TypeRecipes.lowercased()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        if let customFont = UIFont(name: "IndieFlower", size: 26.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: customFont]
        }
 
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
    
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return RecipesType.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipesTableViewCell
        cell.MealNameLabel.text = RecipesType[TypeRecipes]?.name
        cell.MealImage.image = UIImage(named: TypeRecipes.lowercased())

        return cell
    }
    
    
  
    
    @IBAction func returnToTableRecipes(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
