//
//  photoRevealerVC.swift
//  FitMeSingleView
//
//  Created by Howard Gil on 8/8/16.
//  Copyright © 2016 Howard Gil. All rights reserved.
//


//Do I need pragma once ???

import Foundation
import UIKit
import CoreGraphics
import CoreImage

class photoRevealer
{
    
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
}