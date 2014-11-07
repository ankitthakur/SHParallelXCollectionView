//
//  SHParallelXCollectionViewLayout.swift
//  SHParallelXCollectionView
//
//  Created by Ankit Thakur on 04/11/14.
//  Copyright (c) 2014 Ankit Thakur. All rights reserved.
//

import Foundation
import UIKit


@objc protocol SHParallelXCollectionViewLayoutDelegate : NSObjectProtocol{

    optional func collectionView(collectionView: UICollectionView, withCollectionViewLayout layout: UICollectionViewFlowLayout, withLayoutAttributes layoutAttributes: UICollectionViewLayoutAttributes, withProportionalChange change: CGFloat, draggingItemAtIndexPath indexPath: NSIndexPath) -> Void
    
}


class SHParallelXCollectionViewLayout: UICollectionViewFlowLayout {
    
    
    internal var layoutDelegate:SHParallelXCollectionViewLayoutDelegate?;
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
        
        self.sectionInset = UIEdgeInsetsZero;
        self.itemSize = CGSizeMake(700, 700);
        self.headerReferenceSize = CGSizeMake(320, 120);
        self.minimumLineSpacing = 0.0;
        self.minimumInteritemSpacing = 0.0;
        
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true;
    }
    
    func scrollDirection() -> UICollectionViewScrollDirection{
        return .Vertical
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        
        var collectionView:UICollectionView = self.collectionView!;
        var insets:UIEdgeInsets = collectionView.contentInset;
        var offset:CGPoint = collectionView.contentOffset;
        var minimumY:CGFloat = -insets.top;
        var layoutAttributes:Array = super.layoutAttributesForElementsInRect(rect)!;
        
        if(offset.y < minimumY){
            
            var headerSize:CGSize = self.headerReferenceSize;
            var deltay:Float = Float(offset.y - minimumY);
            var deltaY:CGFloat = CGFloat(fabsf(deltay));
            
            for attribute in layoutAttributes {
                
                var layoutAttribute:UICollectionViewLayoutAttributes = attribute as UICollectionViewLayoutAttributes;
                
                if (layoutAttribute.representedElementKind != nil) {
                    
                    if layoutAttribute.representedElementKind == UICollectionElementKindSectionHeader {
                        
                        var headerRect : CGRect = layoutAttribute.frame;
                        headerRect.size.height = max(minimumY, headerSize.height + deltaY);
                        headerRect.origin.y = headerRect.origin.y - deltaY;
                        layoutAttribute.frame = headerRect;
                        
                        var delegateSelector:Selector = Selector("collectionView(collectionView: withCollectionViewLayout: withLayoutAttributes: withProportionalChange: draggingItemAtIndexPath:)");
                        if (layoutDelegate?.respondsToSelector(delegateSelector) != nil){
                            
                            layoutDelegate?.collectionView!(collectionView, withCollectionViewLayout: self, withLayoutAttributes: layoutAttribute, withProportionalChange: deltaY, draggingItemAtIndexPath: layoutAttribute.indexPath);
                            
                        }
                    }
                }
                
                
            }
            
        }
        
        return layoutAttributes;
    }
    
    
    
}