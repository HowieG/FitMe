////
////  CollevtionViewVC.swift
////  FitMeSingleView
////
////  Created by Howard Gil on 7/27/16.
////  Copyright © 2016 Howard Gil. All rights reserved.
////
//
//import UIKit
//
//class CollevtionViewVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource { //UICollectionViewDelegateFlowLayout
//
//    @IBOutlet weak var collectionView: UICollectionView!
//    
//    let collectionViewA = UICollectionView()
//    let reuseIdentifier = "CollectionViewACell"
//    
//    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
//    
//    override func viewDidLoad() {
//        // Initialize the collection views, set the desired frames
//        super.viewDidLoad()
//        
//        collectionViewA.delegate = self
//        
//        collectionViewA.dataSource = self
//        
//        self.view.addSubview(collectionViewA)
//    }
//
//    // MARK: - UICollectionViewDataSource protocol
//    
//    // tell the collection view how many cells to make
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.items.count
//    }
//    
//    // make a cell for each cell index path
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//        // get a reference to our storyboard cell
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyCollectionViewCell
//        
//        // Use the outlet in our custom class to get a reference to the UILabel in the cell
//        cell.myImage.image = UIImage(named: "muscleGain1")
//        cell.backgroundColor = UIColor.yellowColor() // make cell more visible in our example project
//        
//        return cell
//    }
//    
//    // MARK: - UICollectionViewDelegate protocol
//    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        // handle tap events
//        print("You selected cell #\(indexPath.item)!")
//    }
//    
//    
//    
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
