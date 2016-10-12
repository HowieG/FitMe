//
//  CollectionViewController.swift
//  FitMeSingleView
//
//  Created by Howard Gil on 7/26/16.
//  Copyright © 2016 Howard Gil. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "PhotoCell"

class RPPhotoLibrary: UICollectionViewController, UIImagePickerControllerDelegate
{
    
    
    // By default make locating album false
    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult!
    var assetThumbnailSize: CGSize!
    
    //@IBOutlet weak var thumbNail: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchOptions = PHFetchOptions()
        
        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.Moment, subtype: .Any, options: fetchOptions)
        
        if let first_Obj:AnyObject = collection.firstObject{
            //found the album
            self.assetCollection = first_Obj as! PHAssetCollection
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        // Get size of the collectionView cell for thumbnail image
        if let layout = self.collectionView!.collectionViewLayout as? UICollectionViewFlowLayout{
            let cellSize = layout.itemSize
            
            self.assetThumbnailSize = CGSizeMake(cellSize.width, cellSize.height)
        }
        
        //fetch the photos from collection
        self.photosAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
        
        self.collectionView!.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if(segue.identifier == "selectedPhoto(s)"){
//            
//            if let controller: SelectedPhoto = segue.destinationViewController as? SelectedPhoto{
//                
//                if let cell = sender as? PhotoThumbnail {
//                    if let indexPath: NSIndexPath = self.collectionView!.indexPathForCell(cell){
//                        controller.index = indexPath.item
//                        controller.photosAsset = self.photosAsset
//                        controller.assetCollection = self.assetCollection
//                    }
//                }
//                
//            }
//        }
//    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        var count: Int = 0
        
        if(self.photosAsset != nil){
            count = self.photosAsset.count
        }
        
        return count;
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: PhotoThumbnail = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoThumbnail
        
        //Modify the cell
        let asset: PHAsset = self.photosAsset[indexPath.item] as! PHAsset
        
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: self.assetThumbnailSize, contentMode: .AspectFill, options: nil, resultHandler: {(result, info)in
            if let image = result {
                cell.setThumbnailImage(image)
            }
        })
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout methods
    func collectionView(collectinView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    // UIImagePickerControllerDelegate Methods
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
}