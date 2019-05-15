//
//  CameraAdviceVC.swift
//  Petbulb
//
//  Created by MACPRO on 2017-11-27.
//  Copyright © 2017 Petbulb Corp. All rights reserved.
//

import UIKit

class CameraAdviceVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var imageToPost: UIImageView!
    @IBOutlet weak var captionTextToPost: UITextView!
    @IBOutlet weak var friendsTableViewList: UITableView!
    
    var selectedImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPostImageView))
        imageToPost.addGestureRecognizer(tapGesture)
        imageToPost.isUserInteractionEnabled = true
        
        friendsTableViewList.delegate = self
        friendsTableViewList.dataSource = self
        
    }
    
    // function to handle image/video input options
    @objc func handleSelectPostImageView() {
        let alertController = UIAlertController(title: "ADD IMAGE/VIDEO", message:
            "", preferredStyle: UIAlertControllerStyle.alert)
        
        // Restyle the view of the Alert
        alertController.view.tintColor = DataServices.instance.hexStringToUIColor(hex: "#32c0fa")  // change text color of the buttons
        alertController.view.backgroundColor = DataServices.instance.hexStringToUIColor(hex: "#32c0fa") // change background color
        alertController.view.layer.cornerRadius = 25   // change corner radius
        
        let imageFromGallery = UIAlertAction(title: "GALLERY", style: UIAlertActionStyle.default) { (action) in
            // add code to open phone gellery
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let imageFromCamera = UIAlertAction(title: "PHOTO", style: UIAlertActionStyle.default) { (action) in
            // add code to open camera and snap
        }
        
        let videoFromCamera = UIAlertAction(title: "VIDEO", style: UIAlertActionStyle.default) { (action) in
            // add code to open cmaera and video
        }
        
        // add all action buttons to alertController
        alertController.addAction(imageFromGallery)
        alertController.addAction(imageFromCamera)
        alertController.addAction(videoFromCamera)
        
        alertController.addAction(UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.default,handler: nil))

        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdvicePostCell", for: indexPath)
//        cell.textLabel?.text = "new friends"
//        cell.backgroundColor = UIColor.red
        return cell
    }
    
}

extension CameraAdviceVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            imageToPost.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
