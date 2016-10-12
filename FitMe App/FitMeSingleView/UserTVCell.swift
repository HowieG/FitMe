//
//  UserTVCell.swift
//  FitMeSingleView
//
//  Created by Howard Gil on 7/23/16.
//  Copyright © 2016 Howard Gil. All rights reserved.
//

import UIKit

class UserTVCell: UITableViewCell {

    @IBOutlet private weak var userCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}

extension UserTVCell {
    
    func setCollectionViewDataSourceDelegate<D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forRow row: Int) {
        
        userCollectionView.delegate = dataSourceDelegate
        userCollectionView.dataSource = dataSourceDelegate
        userCollectionView.tag = row
        userCollectionView.setContentOffset(userCollectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        userCollectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set {
            userCollectionView.contentOffset.x = newValue
        }
        
        get {
            return userCollectionView.contentOffset.x
        }
    }
}