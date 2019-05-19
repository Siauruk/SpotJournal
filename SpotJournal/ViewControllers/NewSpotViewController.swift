//
//  NewSpotViewController.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 5/1/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import UIKit

class NewSpotViewController: UITableViewController {
    
    var currentSpot: Spot!
    var imageIsChanged = false
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet var spotImage: UIImageView!
    @IBOutlet var spotName: UITextField!
    @IBOutlet var spotLocation: UITextField!
    @IBOutlet var spotType: UITextField!
    @IBOutlet var ratingControl: RatingControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1) )
        saveButton.isEnabled = false
        spotName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
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
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard
            let identifier = segue.identifier,
            let mapVC = segue.destination as? MapViewController
            else { return }
        
        mapVC.incomeSegueIdentifier = identifier
        mapVC.mapViewControllerDelegate = self
    
        if identifier == "showSpot" {
            mapVC.spot.name = spotName.text!
            mapVC.spot.location = spotLocation.text
            mapVC.spot.type = spotType.text
            mapVC.spot.imageData = spotImage.image?.pngData()
        }
    }
    
    func saveSpot() {
        let image = imageIsChanged ? spotImage.image : #imageLiteral(resourceName: "imagePlaceholder")
        let imageData = image?.pngData()
        
        let newSpot = Spot(name: spotName.text!, location: spotLocation.text, type: spotType.text, imageData: imageData, rating: Double(ratingControl.rating))
        
        if currentSpot != nil {
            try! realm.write {
                currentSpot?.name = newSpot.name
                currentSpot?.location = newSpot.location
                currentSpot?.type = newSpot.type
                currentSpot?.imageData = newSpot.imageData
                currentSpot?.rating = newSpot.rating
            }
        } else {
           StorageManager.saveObject(newSpot)
        }
    }
    
    private func setupEditScreen() {
        if currentSpot != nil {
            
            setupNavigationBar()
            imageIsChanged = true
            
            guard let data = currentSpot?.imageData, let image = UIImage(data: data) else { return }
            
            spotImage.image = image
            spotImage.contentMode = .scaleAspectFit
            spotName.text = currentSpot?.name
            spotLocation.text = currentSpot?.location
            spotType.text = currentSpot?.type
            ratingControl.rating = Int(currentSpot.rating)
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentSpot?.name
        saveButton.isEnabled = true
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("deinit", NewSpotViewController.self)
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

extension NewSpotViewController: MapViewControllerDelegate {
    
    func getAddress(_ address: String?) {
        spotLocation.text = address
    }
}
