//
//  RecipesTableViewController.swift
//  storeRecipes
//
//  Created by Veronika Goreva on 02/05/2019.
//  Copyright © 2019 Veronika Goreva. All rights reserved.
//

import UIKit
import CoreData

class RecipesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating//, CreateNewRecipesDelegate
{
    
    

    @IBOutlet var emptyView: UIView!
    
    var recipesStore = [RecipesMO]()
    var searchResults =  [RecipesMO]()
    
    var TypeRecipes: String!
    var fetchResultController: NSFetchedResultsController<RecipesMO>!
    
    var searchController: UISearchController!
    
    

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
        
        //set empty view
        tableView.backgroundView = emptyView
        tableView.backgroundView?.isHidden = true
        
        // delete not using rows
        tableView.tableFooterView = UIView()
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Write recipe name..."
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.tintColor = .white
        searchController.searchBar.backgroundImage = UIImage()
        
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        fetchData()
        
        
        
    }
    
    private func fetchData(){
        let fetchRequest: NSFetchRequest<RecipesMO> = RecipesMO.fetchRequest()
        //describe how the fetched objects are sorted
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true) // понарастущей
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchRequest.predicate = NSPredicate(format: "type == %@", TypeRecipes)
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            
            
            let context = appDelegate.persistentContainer.viewContext
            self.fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            self.fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()  //execute the fetch request
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    recipesStore = fetchedObjects
                    //tableView.reloadData()
                }
                
            } catch {
                print(error)
            }
            
            
        }
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    func filterContent(for searchText: String){
        searchResults = recipesStore.filter({ (recipe) -> Bool in
            if let name = recipe.name {
                let isMatch = name.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            return false
        })
        
    }
    
    
    //it is called when NSFetchResultsController is about to start processing the content change.
    // We tell the table view, "Hey, we're going to update the table. Get ready for it."
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    // When there is any content change in the managed object context (e.g. a new restaurant is
    // saved), the second method is automatically called. Here we determine the type of
    // operation and proceed with the required operation accordingly.
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
                if let fetchedObject = controller.fetchedObjects {
                    recipesStore = fetchedObject as! [RecipesMO]
                }
                tableView.reloadData()
            }
        case .delete:
            self.recipesStore.remove(at: indexPath!.row)
            self.tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.reloadData()
        
            
//
//            case .update:
//                if let newIndexPath = newIndexPath {
//                    tableView.reloadRows(at: [newIndexPath], with: .fade)
//                    tableView.reloadData()
//                }
        default:
            tableView.reloadData()
            
        }
        
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // MARK: - DataSourceDelegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        if recipesStore.count > 0 {
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .singleLine
        }
        else {
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
        }
        
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if searchController != nil {
//            if searchController.isActive {
//                return searchResults.count
//            }
//            else {
//                return recipesStore.count
//            }
//        }
//        else {
//            return recipesStore.count
//        }
        //return recipesStore.count
        if searchController != nil && searchController!.isActive {
            return searchResults.count
        }
        else {
            return recipesStore.count
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipesTableViewCell
       
        
        
        let recipe = (searchController.isActive) ? searchResults[indexPath.row] : recipesStore[indexPath.row]
     
        cell.MealNameLabel.text = recipe.name
        //print(ecipesStore[indexPath.row].name)
        if let recipesImage = recipe.image {
            cell.MealImage.image = UIImage(data: recipesImage as Data)
        }
       
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "") { (contextualAction, view, completeHandler) in
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let recipeForDelete = self.fetchResultController.object(at: indexPath)

                context.delete(recipeForDelete)
                appDelegate.saveContext()
            }
            completeHandler(true)
        }
        
        let editAction = UIContextualAction(style: .normal , title: "") { (action, view, completeHandler) in
            print("trying to edit")
            
           
            
            let main = UIStoryboard(name: "Main", bundle: nil)
            let editContoller = main.instantiateViewController(withIdentifier: "NewRecipesTableViewController") as! NewRecipesTableViewController
            editContoller.recipe = self.recipesStore[indexPath.row]
        
            let navController = UINavigationController(rootViewController: editContoller)
            self.present(navController, animated: true, completion: nil)

            
            completeHandler(true)
        }
        deleteAction.backgroundColor = UIColor.red
        deleteAction.image = UIImage(named: "delete")
        
        editAction.backgroundColor = UIColor.lightGray
        editAction.image = UIImage(named: "pen")
        
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        
        return swipeConfig
        
    }





   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController =  segue.destination as! DetailViewController
                destinationController.recipesStore = (self.searchController.isActive) ?  searchResults[indexPath.row] : recipesStore[indexPath.row]
                
                
            }
           
        }
    }

    
    @IBAction func goToBackRecipesTable(segue:UIStoryboardSegue) {
        //self.dismiss(animated: true, completion: nil)
        print("out of here1")
    }

}
