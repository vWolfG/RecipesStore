//
//  DetailViewController.swift
//  storeRecipes
//
//  Created by Veronika Goreva on 16/05/2019.
//  Copyright © 2019 Veronika Goreva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    
     @IBOutlet var tableView: UITableView!
    var recipesStore = Recipes()

    @IBOutlet var headerView: HeaderUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.tintColor = UIColor.black
        
        
      //  tableView.contentInsetAdjustmentBehavior = .never // shift the table view upward
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        
        headerView.nameRecipeLabel.text = recipesStore.name
        headerView.typeRecipeLabel.text = recipesStore.type
        headerView.headerRecipeImage.image = UIImage(named: recipesStore.image)
    
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // Mark: - TableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailTableViewCell.self), for: indexPath) as! DetailTableViewCell
            cell.titleLabel.text = "Ingredients"
            cell.descriptionLabel.text = recipesStore.ingredients
            print("0")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailTableViewCell.self), for: indexPath) as! DetailTableViewCell
            cell.titleLabel.text = "Steps"
            cell.descriptionLabel.text = recipesStore.steps
            print("0")
            return cell
        default:
            fatalError("Failed to ... cell")
        }
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
