//
//  CollectionViewCell.swift
//  FitMeSingleView
//
//  Created by Howard Gil on 7/26/16.
//  Copyright © 2016 Howard Gil. All rights reserved.
//

import UIKit


class PhotoThumbnail: UICollectionViewCell {
    
    @IBOutlet weak var thumbNail: UIImageView!
    
    func setThumbnailImage(thumbNailImage: UIImage) {
        self.thumbNail.image = thumbNailImage
    }
    
}