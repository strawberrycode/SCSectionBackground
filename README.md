# Updated to Swift 4.1, Xcode 9.4

# UICollectionView section background


You can apply different colours according to the `IndexPath` of the cells. Here is an example of a `UICollectionView` 4 sections, 3 cells with green background on the even sections and 7 cells on a blue background on the odd ones.

![Section Background in UICollectionView](/Images/SCSectionBackground_small.png?raw=true "Section Background in UICollectionView")


## How does it work?
The idea is to override `UICollectionViewLayoutAttributes` to add a color attribute.
And then override `UICollectionReusableView` apply the color to the view background. Easy peasy :)

```
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
```

## How to use it? 
All this happens in the `UICollectionViewFlowLayout` used on your `UIcollectionView`. Here is an example of `layoutAttributesForElementsInRect`:
```
// Create decoration attributes
let decorationAttributes = SCSBCollectionViewLayoutAttributes(forDecorationViewOfKind: "sectionBackground", with: attr.indexPath)
// Set the color(s)
if (attr.indexPath.section % 2 == 0) {
        decorationAttributes.color = UIColor.green.withAlphaComponent(0.5)
    } else {
    decorationAttributes.color = UIColor.blue.withAlphaComponent(0.5)
}
```
You will find all the details in the [SectionBackgroundFlowLayout.swift file](https://github.com/thejini3/SCSectionBackground/blob/master/SCSectionBackground/SectionBackgroundFlowLayout.swift) 

