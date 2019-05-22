//
//  NewRecipesTableViewController.swift
//  storeRecipes
//
//  Created by Veronika Goreva on 10/05/2019.
//  Copyright © 2019 Veronika Goreva. All rights reserved.
//

import UIKit
import CoreData

//protocol CreateNewRecipesDelegate {
//    func saveNewRecipe(recipe: RecipesMO)
//}


class NewRecipesTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    

    
    @IBOutlet var recipesTypes: [UIButton]! {
        didSet {
            guard let customFont = UIFont(name: "IndieFLower", size: 18.0) else {return}
            for i in 0...recipesTypes.count - 1 {
                recipesTypes[i].titleLabel?.numberOfLines = 0
                recipesTypes[i].titleLabel?.font = customFont
                recipesTypes[i].tag = i
                recipesTypes[i].setImage(UIImage(named: "circle"), for: .normal)

                if recipesTypes[i].titleLabel?.text == recipe?.type {
                    isCheckedButton[i] = true
                    recipesTypes[i].setImage(UIImage(named: "checked"), for: .normal)
                }
            }
            
        }
        
    }

    @IBOutlet var recipeImage: UIImageView! {
        didSet{
            recipeImage.tag = 1
            recipeImage.contentMode = .scaleAspectFill
            recipeImage.clipsToBounds = true
            if let image = recipe?.image as? Data {
                let imageForShow = UIImage(data: image)
                recipeImage.image = imageForShow
            }
        }
    }
    @IBOutlet var nameField: UITextField! {
        didSet {
            nameField.tag = 2
            nameField.text = recipe?.name
           
        }
    }
    @IBOutlet var ingredientsField: UITextView!{
        didSet {
            ingredientsField.tag = 3
            ingredientsField.text = recipe?.ingredients
         
        }
    }
    @IBOutlet var stepsField: UITextView!{
        didSet{
            stepsField.tag = 4
            stepsField.text = recipe?.steps
            
        }
    }
    
    
    var recipe: RecipesMO?
        
//        didSet {
//            nameField.text = recipe?.name
//            ingredientsField.text = recipe?.ingredients
//            stepsField.text = recipe?.steps
//            recipesType = recipe?.type
//            for i in 0...recipesTypes.count - 1{
//
//            }
//            if let image = recipe?.image as? Data {
//                let imageForShow = UIImage(data: image)
//                recipeImage.image = imageForShow
//            }
//        }
//
    
    var recipesType: String!
    

    
    
    var isCheckedButton = Array(repeating: false, count: 4)
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if recipe == nil {
            navigationItem.title = "Create recipe"
        }
        else {
            navigationItem.title = "Edit recipe"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        if let customFont = UIFont(name: "IndieFlower", size: 26.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: customFont]
        }
        
        self.recipesType = recipe?.type
        
        
    }
    
    // Mark - TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let next = view.viewWithTag(textField.tag + 1){
            textField.resignFirstResponder()
            next.becomeFirstResponder()
        }
        return true
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let requestImage = UIAlertController(title: "", message: "Choose the source of image", preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.sourceType = .camera
                    imagePicker.allowsEditing = false
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
            let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            requestImage.addAction(cameraAction)
            requestImage.addAction(photoLibrary)
            requestImage.addAction( cancel)
            present(requestImage, animated: true, completion: nil)
            
        }
        
    }
    
    // Mark - ImagePickerControllerDelegate
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[ UIImagePickerController.InfoKey.originalImage] as? UIImage {
           // let flippedImage = UIImage(cgImage: selectedImage.cgImage!, scale: selectedImage.scale, orientation:.left)
            
            self.recipeImage.image = selectedImage
            
           
        }
        
        // apply constraints
        let leadingConstraint = NSLayoutConstraint(item: recipeImage, attribute: .leading, relatedBy: .equal, toItem: recipeImage.superview , attribute: .leading , multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        
        let trailingConstraint = NSLayoutConstraint(item: recipeImage, attribute: .trailing, relatedBy: .equal, toItem: recipeImage.superview , attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: recipeImage, attribute: .top, relatedBy: .equal, toItem: recipeImage.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: recipeImage, attribute: .bottom, relatedBy: .equal, toItem: recipeImage.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    // MARK: - Round Buttons
    @IBAction func checkType(_ sender: UIButton!) {
        self.isCheckedButton[sender.tag] = (self.isCheckedButton[sender.tag]) ? false : true
        let imageName = self.isCheckedButton[sender.tag] ? "checked" : "circle"
        if let image =  UIImage(named: imageName) {
            for i in 0...self.isCheckedButton.count - 1 {
                if i != sender.tag {
                    self.isCheckedButton[i] = false
                    self.recipesTypes[i].setImage(UIImage(named: "circle"), for: .normal)
                }
                else {
                    self.recipesType = sender.titleLabel!.text // saving type
                    //print(self.recipesType ?? "")
                    sender.setImage(image, for: .normal)
                }
            }
            
        }
        
    }
    
    
    // save new recipe
    @IBAction func handleSave(_ sender: Any){
        if nameField.text == "" || ingredientsField.text == "" || stepsField.text == "" || isCheckedButton.contains(true) == false {
            
            let alertController = UIAlertController(title: "Oooops", message: "Please, fill all fields!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            return
            
        }
        
        if recipe == nil {
            createNewRecipe()
        }
        else {
            saveChangedRecipe()
        }
        
        
        
       
        
    }
    
    
    private func saveChangedRecipe(){
        print("try to edit")
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            //let context = appDelegate.persistentContainer.viewContext
            self.recipe?.name = nameField.text
            
            self.recipe?.ingredients = ingredientsField.text
            self.recipe?.steps = stepsField.text
            self.recipe?.type = self.recipesType
            
            let defaulImage = UIImage(named: "emptyPhoto")
            
            if recipeImage.image  == defaulImage, let newImage = UIImage(named: self.recipesType.lowercased())  {
                
                self.recipe?.image = newImage.pngData()
            }
            else {
                if let image = recipeImage.image  {
                    self.recipe?.image = image.pngData()
                }
            }

            appDelegate.saveContext()
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    private func createNewRecipe() {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let recipe = NSEntityDescription.insertNewObject(forEntityName: "Recipes", into: appDelegate.persistentContainer.viewContext)
            recipe.setValue(nameField.text, forKey: "name")
           
            recipe.setValue(recipesType, forKey: "type")
            recipe.setValue(ingredientsField.text, forKey: "ingredients")
            recipe.setValue(stepsField.text, forKey: "steps")
            
            let defaulImage = UIImage(named: "emptyPhoto")
            
            if recipeImage.image  == defaulImage, let newImage = UIImage(named: recipesType.lowercased())  {
                
                recipe.setValue(newImage.pngData(), forKey: "image")
            }
            else {
                if let image = recipeImage.image  {
                    recipe.setValue(image.pngData(), forKey: "image")
                }
                
            }
            
            appDelegate.saveContext()
            
            
        }
        dismiss(animated: true, completion: nil)
        
    
        
    }
    
}
