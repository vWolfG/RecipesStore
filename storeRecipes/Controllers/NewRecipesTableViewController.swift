//
//  NewRecipesTableViewController.swift
//  storeRecipes
//
//  Created by Veronika Goreva on 10/05/2019.
//  Copyright © 2019 Veronika Goreva. All rights reserved.
//

import UIKit

class NewRecipesTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet var recipesTypes: [UIButton]! {
        didSet {
            guard let customFont = UIFont(name: "IndieFLower", size: 18.0) else {return}
            for i in 0...recipesTypes.count - 1 {
                recipesTypes[i].titleLabel?.numberOfLines = 0
                recipesTypes[i].titleLabel?.font = customFont
                recipesTypes[i].tag = i
                recipesTypes[i].setImage(UIImage(named: "circle"), for: .normal)

            }
            
        }
        
    }
    @IBOutlet var recipeImage: UIImageView! {
        didSet{
            recipeImage.tag = 1
        }
    }
    @IBOutlet var nameField: UITextField! {
        didSet {
            nameField.tag = 2
        }
    }
    @IBOutlet var ingredientsField: UITextView!{
        didSet {
            ingredientsField.tag = 3
        }
    }
    @IBOutlet var stepsField: UITextView!{
        didSet{
            stepsField.tag = 4
        }
    }
    
    var isCheckedButton = Array(repeating: false, count: 4)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        if let customFont = UIFont(name: "IndieFlower", size: 26.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: customFont]
        }

      
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[ UIImagePickerController.InfoKey.originalImage] as? UIImage {
            recipeImage.image = selectedImage
            recipeImage.contentMode = .scaleAspectFill
            recipeImage.clipsToBounds = true
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
    
    
    // Round Buttons
    @IBAction func checkType(_ sender: UIButton!) {
        self.isCheckedButton[sender.tag] = (self.isCheckedButton[sender.tag]) ? false : true
        let imageName = self.isCheckedButton[sender.tag] ? "checked" : "circle"
        if let image =  UIImage(named: imageName) {
            for i in 0...self.isCheckedButton.count - 1 {
                if i != sender.tag {
                    self.isCheckedButton[i] = false
                    self.recipesTypes[i].setImage(UIImage(named: "circle"), for: .normal)
                }
                sender.setImage(image, for: .normal)
            }
            
        }
        
    }
    
    
    // save new recipe
    @IBAction func saveNewRecipe(_ sender: Any){
        if nameField.text == "" || ingredientsField.text == "" || stepsField.text == "" || isCheckedButton.contains(true) == false {
            
            let alertController = UIAlertController(title: "Oooops", message: "Please, fill all fields!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            return
            
        }
        
        // add code fore saving data
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func goToBack(_ Sender: Any){
        dismiss(animated: true, completion: nil)
    }

    
}
