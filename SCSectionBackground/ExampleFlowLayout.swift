//
//  ExampleFlowLayout.swift
//  SCSectionBackground
//
//  Created by Catherine Schwartz on 02/03/2016.
//  Copyright © 2016 StrawberryCode. All rights reserved.
//

//
//  ExampleFlowLayout.swift
//  SCSectionBackground
//
//  Created by Catherine Schwartz on 12/02/2016.
//  Copyright © 2016 StrawberryCode. All rights reserved.
//

import UIKit

class ExampleFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: prepareLayout
    
    override func prepareLayout() {
        super.prepareLayout()
        
        minimumLineSpacing = 8.0
        minimumInteritemSpacing = 8.0
        sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        let width = (UIScreen.mainScreen().bounds.width / 3) - 2 * 8.0
        itemSize = CGSizeMake(width, 100)
        
        registerClass(SCSBCollectionReusableView.self, forDecorationViewOfKind: "sectionBackground")
    }
    
    // MARK: layoutAttributesForElementsInRect
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElementsInRect(rect)
        var allAttributes = [UICollectionViewLayoutAttributes]()
        
        if let attributes = attributes {
            
            for attr in attributes {
                // Look for the first item in a row
                // You can also calculate it by item (remove the second check in the if below and change the tmpWidth and frame origin
                if (attr.representedElementCategory == UICollectionElementCategory.Cell && attr.frame.origin.x == self.sectionInset.left) {
                    
                    // Create decoration attributes
                    let decorationAttributes = SCSBCollectionViewLayoutAttributes(forDecorationViewOfKind: "sectionBackground", withIndexPath: attr.indexPath)
                    // Set the color(s)
                    if (attr.indexPath.section % 2 == 0) {
                        decorationAttributes.color = UIColor.clearColor()
                    } else {
                        decorationAttributes.color = UIColor.whiteColor().colorWithAlphaComponent(0.9)
                    }
                    
                    // Make the decoration view span the entire row
                    let tmpWidth = self.collectionView!.contentSize.width
                    let tmpHeight = self.itemSize.height + self.minimumLineSpacing + self.sectionInset.top / 2 + self.sectionInset.bottom / 2  // or attributes.frame.size.height instead of itemSize.height if dynamic or recalculated
                    decorationAttributes.frame = CGRectMake(0, attr.frame.origin.y - self.sectionInset.top, tmpWidth, tmpHeight)
                    
                    // Set the zIndex to be behind the item
                    decorationAttributes.zIndex = attr.zIndex - 1
                    
                    // Add the attribute to the list
                    allAttributes.append(decorationAttributes)
                }
            }
            // Combine the items and decorations arrays
            allAttributes.appendContentsOf(attributes)
        }
        
        return allAttributes
    }
}
