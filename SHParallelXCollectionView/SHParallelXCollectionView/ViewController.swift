//
//  ViewController.swift
//  SHParallelXCollectionView
//
//  Created by Ankit Thakur on 07/11/14.
//  Copyright (c) 2014 Ankit Thakur. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, SHParallelXCollectionViewLayoutDelegate {
    
    
    let iPhone4SeriesHeight:CGFloat = 480
    let iPhone5SeriesHeight:CGFloat = 568
    let iPhone6Height:CGFloat = 667
    let iPhone6PlusHeight:CGFloat = 960
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    @IBOutlet var currentCollectionView:UICollectionView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currentCollectionView.alwaysBounceVertical = true;
        currentCollectionView.showsVerticalScrollIndicator = false;
        currentCollectionView.registerNib (UINib(nibName: "CollectionHeaderView", bundle: NSBundle.mainBundle()), forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,
            withReuseIdentifier:"kReusableCollectionHeaderView");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var collectionViewCell:UICollectionViewCell?;
        
        if indexPath.row == 0 {
            collectionViewCell = currentCollectionView.dequeueReusableCellWithReuseIdentifier("kReusableCollectionViewCell1", forIndexPath: indexPath) as? UICollectionViewCell;
        }
        else if (indexPath.row == 1){
            collectionViewCell = currentCollectionView.dequeueReusableCellWithReuseIdentifier("kReusableMapCollectionViewCell", forIndexPath: indexPath) as? UICollectionViewCell;
        }
        
        return collectionViewCell!;
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var reusableView:UICollectionReusableView?;
        
        reusableView = currentCollectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "kReusableCollectionHeaderView", forIndexPath: indexPath) as? UICollectionReusableView;
        
        return reusableView!;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var size:CGSize = CGSizeZero;
        
        var flowLayout:UICollectionViewFlowLayout = collectionView.collectionViewLayout as UICollectionViewFlowLayout;
        var sectionInset = flowLayout.sectionInset;
        
        if indexPath.item == 0{
            size = CGSizeMake(currentCollectionView.frame.size.width-(sectionInset.left+sectionInset.right), 40);
        }
        else if (indexPath.item == 1) {
            
            var deviceHeight:CGFloat = UIScreen.mainScreen().bounds.size.height;
            var cellHeight:CGFloat = 320;
            
            switch (deviceHeight) {
            case iPhone4SeriesHeight:
                cellHeight = 320;
                break;
                
            case iPhone5SeriesHeight:
                cellHeight = 410;
                break;
                
            case iPhone6Height:
                cellHeight = 560;
                break;
                
            case iPhone6PlusHeight:
                cellHeight = 600;
                break;
                
            default:
                break;
            }
            
            size = CGSizeMake(currentCollectionView.frame.size.width - (sectionInset.left + sectionInset.right), cellHeight);
        }
        
        if (currentCollectionView.contentSize.height >= 120) {
            currentCollectionView.contentSize = CGSizeMake(currentCollectionView.frame.size.width - (sectionInset.left + sectionInset.right), currentCollectionView.contentSize.height+size.height);
        }
        else{
            currentCollectionView.contentSize = CGSizeMake(currentCollectionView.frame.size.width - (sectionInset.left + sectionInset.right), currentCollectionView.contentSize.height+size.height+120);
        }
        
        return size;
    }
    
    func collectionView(collectionView: UICollectionView, withCollectionViewLayout layout: UICollectionViewFlowLayout, withLayoutAttributes layoutAttributes: UICollectionViewLayoutAttributes, withProportionalChange change: CGFloat, draggingItemAtIndexPath indexPath: NSIndexPath) {
        
        if (layoutAttributes.representedElementKind == UICollectionElementKindSectionHeader) {
            
            // will add blur effect
        }
        
    }
    
    
    
}

