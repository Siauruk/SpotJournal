//
//  NewSpotViewController.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 5/1/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import UIKit

class NewSpotViewController: UITableViewController {
    
    var imageIsChanged = false
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var spotImage: UIImageView!
    @IBOutlet weak var spotName: UITextField!
    @IBOutlet weak var spotLocation: UITextField!
    @IBOutlet weak var spotType: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        spotName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    // MARK: Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
    
    func saveNewSpot() {
        
        var image: UIImage?
        
        if imageIsChanged {
            image = spotImage.image
        } else {
            image = #imageLiteral(resourceName: "imagePlaceholder")
        }
        
        let imageData = image?.pngData()
        
        let newSpot = Spot(name: spotName.text!, location: spotLocation.text, type: spotType.text, imageData: imageData)
        
        StorageManager.saveObject(newSpot)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}


// MARK: Text field delegate

extension NewSpotViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        
        if spotName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}


// Mark: Work with image

extension NewSpotViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        spotImage.image = info[.editedImage] as? UIImage
        spotImage.contentMode = .scaleAspectFit
        spotImage.clipsToBounds = true
        
        imageIsChanged = true
        
        dismiss(animated: true)
    }
}
