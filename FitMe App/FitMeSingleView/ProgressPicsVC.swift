////
////  ProgressPicsVC.swift
////  FitMeSingleView
////
////  Created by Howard Gil on 7/25/16.
////  Copyright © 2016 Howard Gil. All rights reserved.
////
//
//import UIKit
//
//class ProgressPicsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
//{
//    @IBOutlet weak var toggleComparisonStyleButton: UIButton! //connect
//    
//    var toggleSetToReveal : Bool = false //do this differently
//    var imageViewArray = [UIImageView]()
//    var numPhotos : Int? //extrenuous
//    var currentPhoto : Int?
//    
//    var bottomImageView : UIImageView?
//    var topImageView : UIImageView?
//    
//    //testing
//    var topImage = UIImage(named: "musclegain2")
//    var bottomImage = UIImage(named:"musclegain1")
//    
//    override func viewDidLoad()
//    {
//        numPhotos = photoFaderVC.progressPictures.count //
//        
//        let picWidth : CGFloat = view.bounds.width //move
//        let picHeight : CGFloat = view.bounds.height //move
//        
//        bottomImageView!.image = bottomImage //
//        topImageView!.image = topImage //
//        
//        //move
//        //if let
//        for i in 0..<numPhotos!
//        {
//            imageViewArray.append(UIImageView(image: photoFaderVC.progressPictures[i])) //
//            imageViewArray[i].frame = CGRect(x: view.bounds.width/2 - picWidth/2, y: view.bounds.height/2 - picHeight/2, width: picWidth, height: picHeight)
//        }
//        
//        //currentPhoto must not be base-0 because of the division
//        currentPhoto = 1 //set this to one once the first photo is added!!!
//        
//        view.addSubview(imageViewArray[0]) //move
//    }
//    
//    override func viewWillAppear(animated: Bool)
//    {
//        bottomImageView = imageViewArray[0] //sets bottom to second to last
//        topImageView = imageViewArray[1]
//    }
//    
//    
//    @IBAction func toggleComparisonStyleButtonTouched(sender: AnyObject)
//    {
//        //add functionality to change the image of the button depending on what the user wants to toggle to
//        //currently, the button gets highlighted with a blue background if it is selected
//        
//        toggleSetToReveal = !toggleSetToReveal
//        toggleComparisonStyleButton.selected = !toggleComparisonStyleButton.selected
//    }
//    
//    override func touchesMoved(touches: Set<UITouch>,
//                               withEvent event: UIEvent?)
//    {
//        if let touch = touches.first
//        {
//            let position :CGPoint = touch.locationInView(view)
//            let percentOfScreen : Float = Float(position.x/self.view.bounds.width)
//            
//            if(toggleSetToReveal)
//            {
//                //let proportionateNumPixels = percentOfScreen * Float(CGImageGetWidth(topImage?.CGImage))
//                //topImageView.image = revealImage(topImage!, pixelsToHide: Int(proportionateNumPixels))
//            }
//            else
//            {
//                photoFaderVC.changeOver(percentOfScreen, imageViewArray: imageViewArray)
//                bottomImageView = imageViewArray[currentPhoto! - 1]
//                view.addSubview(imageViewArray[currentPhoto!])
//                topImageView = imageViewArray[currentPhoto!]
//            }
//        }
//    }
//    
//    //connect this to the add photo button in the nav bar
//    @IBAction func addPhotosButtonTouched(sender: AnyObject)
//    {
//        let addPhotoAlert = UIAlertController(title: "Add Image", message: "Select from camera roll or take photo?", preferredStyle: .Alert)
//        
//        let selectPhotoAction = UIAlertAction(title: "Camera Roll", style: .Default, handler:{
//            
//            (UIAlertAction) in
//            
//            self.selectPicture()
//        })
//        
//        addPhotoAlert.addAction(selectPhotoAction)
//        
//        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .Default, handler:{
//            
//            (UIAlertAction) in
//            
//            self.takePicture()
//        })
//        
//        addPhotoAlert.addAction(takePhotoAction)
//        
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler:{
//            
//            (UIAlertAction) in
//            
//            self.dismissViewControllerAnimated(true, completion: nil)
//        })
//        
//        addPhotoAlert.addAction(cancelAction)
//        
//        self.presentViewController(addPhotoAlert, animated: true, completion: {})
//        
//    }
//    
//    
//    //QUESTION: Maybe put UIImagePickerController in its own class???
//    
//    //Note: Camera not available on simulator
//    func takePicture()
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
//                let noRearCameraAlert = UIAlertController(title: "Your phone doesn't have a rear camera!", message: "FitMe cannot access the camera.", preferredStyle: .Alert)
//                
//                let dismissAction = UIAlertAction(title: "OK", style: .Cancel, handler:{
//                    
//                    (UIAlertAction) in
//                    
//                    self.dismissViewControllerAnimated(true, completion: {})
//                })
//                
//                noRearCameraAlert.addAction(dismissAction)
//                
//                self.presentViewController(noRearCameraAlert, animated: true, completion: {})
//            }
//            
//        }
//        else
//        {
//            let noCameraAccessAlert = UIAlertController(title: "Cannot access camera.", message: "FitMe cannot access the camera.", preferredStyle: .Alert)
//            
//            let dismissAction = UIAlertAction(title: "OK", style: .Cancel, handler:{
//                
//                (UIAlertAction) in
//                
//                self.dismissViewControllerAnimated(true, completion: {})
//            })
//            
//            noCameraAccessAlert.addAction(dismissAction)
//            
//            self.presentViewController(noCameraAccessAlert, animated: true, completion: {})
//        }
//    }
//    
//    func selectPicture()
//    {
//        let picker = UIImagePickerController()
//        picker.allowsEditing = false //
//        picker.delegate = self
//        presentViewController(picker, animated: true, completion: nil)
//    }
//    
//    // MARK: - UIImagePickerControllerDelegate Methods
//    
//    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
//        dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
//    {
//        
//        var selectedImage: UIImage
//        
//        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage
//        {
//            selectedImage = possibleImage
//        }
//        else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
//        {
//            selectedImage = possibleImage
//        }
//        else
//        {
//            return
//        }
//        
//        //if fader
//        imageViewArray.append(UIImageView(image: selectedImage))
//        topImageView = imageViewArray.last! //
//        
//        print(imageViewArray.count)
//        
//        self.dismissViewControllerAnimated(false, completion:
//            {
//                //() -> Void in
//                //self.performSelector(#selector(self.takeNextPhoto), withObject: picker, afterDelay: 0.1)
//        })
//    }
//    
//    
//    
////    var progressPictures = [UIImage]()
////    var bottomImageView : UIImageView?
////    var topImageView : UIImageView?
////    
////    var imageViewArray = [UIImageView?]()
////    
////    var numPhotos : Int?
////    var currentPhoto : Int?
////    
////    var previousAlphaRatio : Float?
////    var slidingRight : Bool = true
////    
////    override func viewDidLoad()
////    {
////        super.viewDidLoad()
////        
////        //testing photos
////        progressPictures.append(UIImage(named: "musclegain1")!)
////        progressPictures.append(UIImage(named: "musclegain2")!)
////        progressPictures.append(UIImage(named: "musclegain3")!)
////        
////        numPhotos = progressPictures.count
////        
////        let picWidth : CGFloat = view.bounds.width
////        let picHeight : CGFloat = view.bounds.height
////        
////        //if let
////        for i in 0..<numPhotos!
////        {
////            imageViewArray.append(UIImageView(image: progressPictures[i]))
////            imageViewArray[i]!.frame = CGRect(x: view.bounds.width/2 - picWidth/2, y: view.bounds.height/2 - picHeight/2, width: picWidth, height: picHeight)
////        }
////        
////        //currentPhoto must not be base-0 because of the division
////        currentPhoto = 1
////        
////        view.addSubview(imageViewArray[0]!)
////    }
////    
////    override func touchesMoved(touches: Set<UITouch>,
////                               withEvent event: UIEvent?)
////    {
////        if let touch = touches.first {
////            let position :CGPoint = touch.locationInView(view)
////            //print(position.x)
////            let percentOfView = Float(position.x/view.bounds.width)
////            changeOver(percentOfView)
////        }
////    }
////    
////    func changeOver(alphaRatio : Float)
////    {
////        if previousAlphaRatio != nil
////        {
////            if(previousAlphaRatio! - alphaRatio > 0)
////            {
////                slidingRight = false
////            }
////            else
////            {
////                slidingRight = true
////            }
////        }
////        
////        //y = mx + b
////        var fadeOutEquation = -Float(numPhotos!-1)*alphaRatio + Float(currentPhoto!)
////        var fadeInEquation = Float(numPhotos!-1)*alphaRatio - Float(currentPhoto!-1)
////        
////        //the fadeOutEquation (AKA alpha) being out of bounds signals a change point (a change of photos)
////        if(fadeOutEquation > 1 || fadeOutEquation < 0 || fadeInEquation > 1 || fadeInEquation < 0)
////        {
////            if(slidingRight)
////            {
////                //next photo
////                if(currentPhoto! < numPhotos)
////                {
////                    currentPhoto! += 1
////                    //resets equation values so that new imageViews don't start at out of bounds alphas (ex: fadeInEquation = 1.01771 instead of 0.0
////                    //otherwise top view would appear at full 1.0 alpha instead of hidden (0.0 alpha)
////                    fadeOutEquation = 1.0
////                    fadeInEquation = 0.0
////                }
////            }
////            else
////            {
////                //previous photo
////                if(currentPhoto > 1)
////                {
////                    currentPhoto! -= 1
////                    fadeOutEquation = 0.0
////                    fadeInEquation = 1.0
////                }
////            }
////        }
////        
////        bottomImageView = imageViewArray[currentPhoto! - 1]
////        topImageView = imageViewArray[currentPhoto!]
////        
////        bottomImageView?.alpha = CGFloat(fadeOutEquation)
////        view.addSubview(topImageView!)
////        topImageView?.alpha = CGFloat(fadeInEquation)
////        previousAlphaRatio = alphaRatio
////    }
////    
////    override func didReceiveMemoryWarning() {
////        super.didReceiveMemoryWarning()
////        // Dispose of any resources that can be recreated.
////    }
//}
