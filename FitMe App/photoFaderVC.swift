////
////  photoFaderVC.swift
////  FitMeSingleView
////
////  Created by Howard Gil on 8/8/16.
////  Copyright © 2016 Howard Gil. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class photoFaderVC
//{
//    //static var progressPictures = [UIImage]() //testing purposes only
//    //static var bottomImageView : UIImageView? //static
//    //static var topImageView : UIImageView? //static
//    
//    //var imageViewArray = [UIImageView?]()
//    
//    static var numPhotos : Int? //static //extrenuous
//    static var currentPhoto : Int? //static
//    
//    static var previousAlphaRatio : Float? //static
//    static var slidingRight : Bool = true //static
//    
////    func addPhotosForTesting()
////    {
////        //testing photos
////        progressPictures.append(UIImage(named: "musclegain1")!)
////        progressPictures.append(UIImage(named: "musclegain2")!)
////        progressPictures.append(UIImage(named: "musclegain3")!)
////    }
//    
//
//    //move
////    override func touchesMoved(touches: Set<UITouch>,
////                               withEvent event: UIEvent?)
////    {
////        if let touch = touches.first {
////            let position :CGPoint = touch.locationInView(view)
////            //print(position.x)
////            let percentOfView = Float(position.x/view.bounds.width) //calculate in superclass
////            changeOver(percentOfView) //
////        }
////    }
//    
//    static func changeOver(alphaRatio : Float, imageViewArray : [UIImageView])
//    {
//        if previousAlphaRatio != nil
//        {
//            if(previousAlphaRatio! - alphaRatio > 0)
//            {
//                slidingRight = false
//            }
//            else
//            {
//                slidingRight = true
//            }
//        }
//        
//        //y = mx + b
//        var fadeOutEquation = -Float(numPhotos!-1)*alphaRatio + Float(currentPhoto!)
//        var fadeInEquation = Float(numPhotos!-1)*alphaRatio - Float(currentPhoto!-1)
//        
//        //the fadeOutEquation (AKA alpha) being out of bounds signals a change point (a change of photos)
//        if(fadeOutEquation > 1 || fadeOutEquation < 0 || fadeInEquation > 1 || fadeInEquation < 0)
//        {
//            if(slidingRight)
//            {
//                //next photo
//                if(currentPhoto! < numPhotos)
//                {
//                    currentPhoto! += 1
//                    //resets equation values so that new imageViews don't start at out of bounds alphas (ex: fadeInEquation = 1.01771 instead of 0.0
//                    //otherwise top view would appear at full 1.0 alpha instead of hidden (0.0 alpha)
//                    fadeOutEquation = 1.0
//                    fadeInEquation = 0.0
//                }
//            }
//            else
//            {
//                //previous photo
//                if(currentPhoto > 1)
//                {
//                    currentPhoto! -= 1
//                    fadeOutEquation = 0.0
//                    fadeInEquation = 1.0
//                }
//            }
//        }
//        
//        bottomImageView = imageViewArray[currentPhoto! - 1]
//        topImageView = imageViewArray[currentPhoto!]
//        
////        bottomImageView?.alpha = CGFloat(fadeOutEquation)
////        view.addSubview(topImageView!)
////        topImageView?.alpha = CGFloat(fadeInEquation)
//        
//        imageViewArray[currentPhoto! - 1].alpha = CGFloat(fadeOutEquation)
////        view.addSubview(imageViewArray[currentPhoto!])
//        imageViewArray[currentPhoto!].alpha = CGFloat(fadeInEquation)
//
//        
//        previousAlphaRatio = alphaRatio
//    }
//}