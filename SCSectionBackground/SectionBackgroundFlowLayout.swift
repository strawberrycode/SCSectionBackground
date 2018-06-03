//
//  SectionBackgroundFlowLayout.swift
//  SCSectionBackground
//
//  Created by Catherine Schwartz on 12/02/2016.
//  Copyright © 2016 StrawberryCode. All rights reserved.
//

import UIKit

class SectionBackgroundFlowLayout: UICollectionViewFlowLayout {

    // MARK: prepareLayout
    
    override func prepare() {
        super.prepare()
        
        minimumLineSpacing = 8.0
        minimumInteritemSpacing = 8.0
        sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        let width = (UIScreen.main.bounds.width / 3) - 2 * 8.0
        itemSize = CGSize(width: width, height: 100)
        
        register(SCSBCollectionReusableView.self, forDecorationViewOfKind: "sectionBackground")
    }
    
    // MARK: layoutAttributesForElementsInRect
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var allAttributes = [UICollectionViewLayoutAttributes]()
        
        if let attributes = attributes {
            
            for attr in attributes {
                // Look for the first item in a row
                // You can also calculate it by item (remove the second check in the if below and change the tmpWidth and frame origin
                if (attr.representedElementCategory == UICollectionElementCategory.cell && attr.frame.origin.x == self.sectionInset.left) {
                    
                    // Create decoration attributes
                    let decorationAttributes = SCSBCollectionViewLayoutAttributes(forDecorationViewOfKind: "sectionBackground", with: attr.indexPath)
                    // Set the color(s)
                    if (attr.indexPath.section % 2 == 0) {
                        decorationAttributes.color = UIColor.green.withAlphaComponent(0.5)
                    } else {
                        decorationAttributes.color = UIColor.blue.withAlphaComponent(0.5)
                    }
                    
                    // Make the decoration view span the entire row
                    let tmpWidth = self.collectionView!.contentSize.width
                    let tmpHeight = self.itemSize.height + self.minimumLineSpacing + self.sectionInset.top / 2 + self.sectionInset.bottom / 2  // or attributes.frame.size.height instead of itemSize.height if dynamic or recalculated
                  
                    decorationAttributes.frame = CGRect(x: 0, y: attr.frame.origin.y - self.sectionInset.top, width: tmpWidth, height: tmpHeight)
                    
                    // Set the zIndex to be behind the item
                    decorationAttributes.zIndex = attr.zIndex - 1
                    
                    // Add the attribute to the list
                    allAttributes.append(decorationAttributes)
                }
            }
            // Combine the items and decorations arrays
            allAttributes.append(contentsOf: attributes)
        }
        
        return allAttributes
    }
}



class SCSBCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes {
    var color: UIColor = .white
    override func copy(with zone: NSZone? = nil) -> Any {
        
        let newAttributes: SCSBCollectionViewLayoutAttributes = super.copy(with: zone) as! SCSBCollectionViewLayoutAttributes
        newAttributes.color = self.color.copy(with: zone) as! UIColor
        return newAttributes
    }
}

class SCSBCollectionReusableView : UICollectionReusableView {
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let scLayoutAttributes = layoutAttributes as! SCSBCollectionViewLayoutAttributes
        self.backgroundColor = scLayoutAttributes.color
    }
}
