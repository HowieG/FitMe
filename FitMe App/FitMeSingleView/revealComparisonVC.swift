//
//  revealComparisonVC.swift
//  FitMeSingleView
//
//  Created by Howard Gil on 8/1/16.
//  Copyright © 2016 Howard Gil. All rights reserved.
//

import UIKit
import CoreGraphics
import CoreImage

class revealComparisonVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    //@IBOutlet weak var topImageView: UIImageView! //
    
    //@IBOutlet weak var bottomImageView: UIImageView! //
    
    @IBOutlet weak var toggleComparisonStyleButton: UIButton!
    
    
    //add navigation controller with "Add Photos" Button
    //For fader: insert the photos to the front of the array
    //Set bottom image to be index 0, etc.
    //Max num images = 10
    //Erase extra images
    
    //For revealer: new selected image = bottom image, other one = top image
    //Max num images = 2
    
    //bottom/top image for reveal
    //array for fader
    
    var toggleSetToReveal : Bool = false //do this differently
    
    var progressPictures_Fader = [UIImage]()
    var bottomImageView : UIImageView?
    var topImageView : UIImageView?
    
    var imageViewArray = [UIImageView?]()
    
    var numPhotos_Fader : Int?
    
    var previousAlphaRatio : Float?
    var slidingRight : Bool = true
    
    var topImage = UIImage(named: "musclegain2") //testing purposes, for reveal only
    var bottomImage = UIImage(named:"musclegain1") //testing purposes, for reveal only
    
    var currentBottomPhoto : Int? //change this to base 0 - change the FadeOutEquation
    
    var picWidth : CGFloat?
    var picHeight : CGFloat?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //testing photos
        progressPictures_Fader.append(UIImage(named: "musclegain1")!)
        progressPictures_Fader.append(UIImage(named: "musclegain2")!)
        progressPictures_Fader.append(UIImage(named: "musclegain3")!)
        
        numPhotos_Fader = progressPictures_Fader.count
        
        picWidth = view.bounds.width
        picHeight = view.bounds.height - 44 //accounts for the nav bar
        
        //if let
        for i in 0..<numPhotos_Fader!
        {
            imageViewArray.append(UIImageView(image: progressPictures_Fader[i]))
            imageViewArray[i]!.frame = CGRect(x: (view.bounds.width - picWidth!)/2, y: (view.bounds.height - picHeight! + 44)/2, width: picWidth!, height: picHeight!)
        }
        
        bottomImageView = imageViewArray[0] //
        topImageView = imageViewArray[1] //
        
        
        //currentBottomPhoto must not be base-0 because of the division
        currentBottomPhoto = 1
        
        view.addSubview(bottomImageView!)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        bottomImageView!.image = progressPictures_Fader[0]
        topImageView!.image = progressPictures_Fader[1]
//        bottomImageView!.image = progressPictures_Fader[currentBottomPhoto!-1]
//        topImageView!.image = progressPictures_Fader[currentBottomPhoto!]
    }
    
    
    @IBAction func toggleComparisonStyleButtonTouched(sender: AnyObject)
    {
        //add functionality to change the image of the button depending on what the user wants to toggle to
        //currently, the button gets highlighted with a blue background if it is selected
        
        toggleSetToReveal = !toggleSetToReveal
        toggleComparisonStyleButton.selected = !toggleComparisonStyleButton.selected
    }
    
    //
    @IBAction func addPhotosButtonTouched(sender: AnyObject)
    {
        let addPhotoAlert = UIAlertController(title: "Add Image", message: "Select from camera roll or take photo?", preferredStyle: .Alert)
        
        let selectPhotoAction = UIAlertAction(title: "Camera Roll", style: .Default, handler:{
            
            (UIAlertAction) in
            
            self.selectPicture()
        })
        
        addPhotoAlert.addAction(selectPhotoAction)
        
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .Default, handler:{
            
            (UIAlertAction) in
            
            self.takePicture()
        })
        
        addPhotoAlert.addAction(takePhotoAction)
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler:{
            
            (UIAlertAction) in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        
        addPhotoAlert.addAction(cancelAction)
        
        self.presentViewController(addPhotoAlert, animated: true, completion: {})
        
    }
    
    override func touchesMoved(touches: Set<UITouch>,
                               withEvent event: UIEvent?)
    {
        if let touch = touches.first {
            let position :CGPoint = touch.locationInView(view)
            let percentOfScreen : Float = Float(position.x/self.view.bounds.width)
            
            if(toggleSetToReveal)
            {
                let proportionateNumPixels = percentOfScreen * Float(CGImageGetWidth(topImage?.CGImage))
                topImageView!.image = revealImage(topImage!, pixelsToHide: Int(proportionateNumPixels))
            }
            else
            {
                changeOver(percentOfScreen)
            }
        }
    }
    
    func changeOver(alphaRatio : Float)
    {
        if previousAlphaRatio != nil
        {
            if(previousAlphaRatio! - alphaRatio > 0)
            {
                slidingRight = false
            }
            else
            {
                slidingRight = true
            }
        }
        
        //y = mx + b
        var fadeOutEquation = -Float(numPhotos_Fader!-1)*alphaRatio + Float(currentBottomPhoto!)
        var fadeInEquation = Float(numPhotos_Fader!-1)*alphaRatio - Float(currentBottomPhoto!-1)
        
        //the fadeOutEquation (AKA alpha) being out of bounds signals a change point (a change of photos)
        if(fadeOutEquation > 1 || fadeOutEquation < 0 || fadeInEquation > 1 || fadeInEquation < 0)
        {
            if(slidingRight)
            {
                //next photo
                if(currentBottomPhoto! < numPhotos_Fader)
                {
                    currentBottomPhoto! += 1
                    //resets equation values so that new imageViews don't start at out of bounds alphas (ex: fadeInEquation = 1.01771 instead of 0.0
                    //otherwise top view would appear at full 1.0 alpha instead of hidden (0.0 alpha)
                    fadeOutEquation = 1.0
                    fadeInEquation = 0.0
                }
            }
            else
            {
                //previous photo
                if(currentBottomPhoto > 1)
                {
                    currentBottomPhoto! -= 1
                    fadeOutEquation = 0.0
                    fadeInEquation = 1.0
                }
            }
        }
        
        bottomImageView = imageViewArray[currentBottomPhoto! - 1] //
        topImageView = imageViewArray[currentBottomPhoto!] //
        
        bottomImageView?.alpha = CGFloat(fadeOutEquation) //
        view.addSubview(topImageView!)
        topImageView?.alpha = CGFloat(fadeInEquation) //
        previousAlphaRatio = alphaRatio //
    }
    
    func revealImage(inputImage: UIImage, pixelsToHide : Int) -> UIImage?
    {
        let inputCGImage     = inputImage.CGImage
        let colorSpace       = CGColorSpaceCreateDeviceRGB()
        let width            = CGImageGetWidth(inputCGImage)
        let height           = CGImageGetHeight(inputCGImage)
        let bytesPerPixel    = 4
        let bitsPerComponent = 8
        let bytesPerRow      = bytesPerPixel * width
        let bitmapInfo       = RGBA32.bitmapInfo
        
        guard let context = CGBitmapContextCreate(nil, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo) else {
            print("unable to create context")
            return nil
        }
        
        CGContextDrawImage(context, CGRectMake(0, 0, CGFloat(width), CGFloat(height)), inputCGImage)
        
        let pixelBuffer = UnsafeMutablePointer<RGBA32>(CGBitmapContextGetData(context))
        
        var currentPixel = pixelBuffer
        
        let transparent = RGBA32(red: 0, green: 0, blue: 0, alpha: 0)
        
        for _ in 0 ..< Int(height)
        {
            for i in 0...pixelsToHide//for i in 1...sliderValue
            {
                //currentPixel = currentRow * Int(width) + i
                currentPixel.memory = transparent
                //let change : Int = Int(currentPixel.)
                
                if (i == pixelsToHide)
                {
                    currentPixel += width - pixelsToHide
                }
                else
                {
                    currentPixel += 1//(Int(currentPixel) - (currentRow * width + i))
                }
            }
        }
        
        let outputCGImage = CGBitmapContextCreateImage(context)
        let outputImage = UIImage(CGImage: outputCGImage!, scale: inputImage.scale, orientation: inputImage.imageOrientation)
        
        return outputImage
    }
    
    //restructure this, may be unnecessary
    struct RGBA32{//: Equatable {
        var color: UInt32
        
        func red() -> UInt8 {
            return UInt8((color >> 24) & 255)
        }
        
        func green() -> UInt8 {
            return UInt8((color >> 16) & 255)
        }
        
        func blue() -> UInt8 {
            return UInt8((color >> 8) & 255)
        }
        
        func alpha() -> UInt8 {
            return UInt8((color >> 0) & 255)
        }
        
        init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
            color = (UInt32(red) << 24) | (UInt32(green) << 16) | (UInt32(blue) << 8) | (UInt32(alpha) << 0)
        }
        
        static let bitmapInfo = CGImageAlphaInfo.PremultipliedLast.rawValue | CGBitmapInfo.ByteOrder32Little.rawValue
    }
    
    //Note: Camera not available on simulator
    //add code to do something with the taken picture (add it to the imageArray and update currentBottomPhoto)
    func takePicture()
    {
        
        if (UIImagePickerController.isSourceTypeAvailable(.Camera))
        {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil
            {
                
                let imagePicker = UIImagePickerController() //change name to something like cameraUsePicker
                
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: false, completion: {} )
                
            }
            else
            {
                let noRearCameraAlert = UIAlertController(title: "Your phone doesn't have a rear camera!", message: "FitMe cannot access the camera.", preferredStyle: .Alert)
                
                let dismissAction = UIAlertAction(title: "OK", style: .Cancel, handler:{
                    
                    (UIAlertAction) in
                    
                    self.dismissViewControllerAnimated(true, completion: {})
                })
                
                noRearCameraAlert.addAction(dismissAction)
                
                self.presentViewController(noRearCameraAlert, animated: true, completion: {})
            }
            
        }
        else
        {
            let noCameraAccessAlert = UIAlertController(title: "Cannot access camera.", message: "FitMe cannot access the camera.", preferredStyle: .Alert)
            
            let dismissAction = UIAlertAction(title: "OK", style: .Cancel, handler:{
                
                (UIAlertAction) in
                
                self.dismissViewControllerAnimated(true, completion: {})
            })
            
            noCameraAccessAlert.addAction(dismissAction)
            
            self.presentViewController(noCameraAccessAlert, animated: true, completion: {})
        }
    }
    
    func selectPicture()
    {
        let picker = UIImagePickerController()
        picker.allowsEditing = false //do not want users editing their photos
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        
        var selectedImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage
        {
            selectedImage = possibleImage
        }
        else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        {
            selectedImage = possibleImage
        }
        else
        {
            return
        }
        
        if(toggleSetToReveal)
        {
            bottomImage = topImage
            topImage = selectedImage
        }
        else
        {
            numPhotos_Fader! += 1 //
            imageViewArray.append(UIImageView(image: selectedImage))
            
            imageViewArray[numPhotos_Fader!-1]!.frame = CGRect(x: (view.bounds.width - picWidth!)/2, y: (view.bounds.height - picHeight! + 44)/2, width: picWidth!, height: picHeight!)
            
            //should indicate that a photo has been added, because the bottom photo does not change (no way to tell past the first time you add a photo)
            
        }
        
        
        self.dismissViewControllerAnimated(false, completion:
            {
                //() -> Void in
                //self.performSelector(#selector(self.takeNextPhoto), withObject: picker, afterDelay: 0.1)
        })
    }
    
    func takeNextPhoto(picker: UIImagePickerController)
    {
        self.presentViewController(picker, animated: false, completion: { _ in })
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
