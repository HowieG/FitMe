//
//  ImagePickerViewController.swift
//  FitMeSingleView
//
//  Created by Howard Gil on 7/26/16.
//  Copyright © 2016 Howard Gil. All rights reserved.
//

import UIKit
import Photos

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    @IBOutlet weak var progressPicImageView: UIImageView!
//    
//
//    
//    var assetCollection: PHAssetCollection!
//    var photosAsset: PHFetchResult!
//    var assetThumbnailSize: CGSize!
//    
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        
//        let alert = UIAlertView(title:  "Select Photos",
//                                message: "FitMe cannot access the camera.",
//                                delegate: self,
//                                cancelButtonTitle: "OK")
//        alert.show()
//        
//    }
//    
//    @IBAction func loadImageTapped(sender: AnyObject)
//    {
//        selectPicture()
//    }
//    
//    @IBAction func takeImageTapped(sender: AnyObject)
//    {
//
//        if (UIImagePickerController.isSourceTypeAvailable(.Camera))
//        {
//            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil
//            {
//                
//                let imagePicker = UIImagePickerController() //change name to something like cameraUsePicker
//                
//                imagePicker.allowsEditing = true
//                imagePicker.sourceType = .Camera
//                imagePicker.cameraCaptureMode = .Photo
//                presentViewController(imagePicker, animated: false, completion: {} )
//                
//            }
//            else
//            {
//                // postAlert("Rear camera does not exist", message: "FitMe cannot access the camera")
//                let alert = UIAlertView(title:  "Your phone doesn't have a rear camera!",
//                                        message: "FitMe cannot access the camera.",
//                                        delegate: self,
//                                        cancelButtonTitle: "OK")
//                alert.show()
//            }
//            
//        }
//        else
//        {
//            // postAlert("Camera not accessible", message: "FitMe cannot access the camera")
//            let alert = UIAlertView(title:  "Cannot access camera.",
//                                    message: "FitMe cannot access the camera.",
//                                    delegate: self,
//                                    cancelButtonTitle: "ok")
//            alert.show()
//        }
//    }
//    // MARK: - UIImagePickerControllerDelegate Methods
//    
//    func selectPicture()
//    {
//        let picker = UIImagePickerController()
//        picker.allowsEditing = false //
//        picker.delegate = self
//        presentViewController(picker, animated: true, completion: nil)
//    }
//    
//    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
//        dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        var newImage: UIImage
//        
//        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
//            newImage = possibleImage
//        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
//            newImage = possibleImage
//        } else {
//            return
//        }
//        
//        // do something interesting here!
//        print(newImage.size)
//        
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
}
