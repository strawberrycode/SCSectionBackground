# Updated to Swift 4.1, Xcode 9.4

# UICollectionView section background

This project shows how to apply colour to background sections (or cells) on a `UICollectionView`. The code is written in Swift, and inspired by Eric [Chapman's article](http://www.ericjchapman.com/ios-changing-the-section-background-color-in-a-uicollectionview.html) (Objective-C [GitHub project](https://github.com/ericchapman/ios_decoration_view)).
You can apply different colours according to the `NSIndexPath` of the cells. Here is an example of a `UICollectionView` 4 sections, 3 cells with green background on the even sections and 7 cells on a blue background on the odd ones.

![Section Background in UICollectionView](/Images/SCSectionBackground_small.png?raw=true "Section Background in UICollectionView")


## How does it work?
The idea is to override `UICollectionViewLayoutAttributes` to add a color attribute.
And then override `UICollectionReusableView` apply the color to the view background. Easy peasy :)

```
class SCSBCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes { 
    var color: UIColor = UIColor.whiteColor()

    override func copyWithZone(zone: NSZone) -> AnyObject {
        let newAttributes: SCSBCollectionViewLayoutAttributes = super.copyWithZone(zone) as! SCSBCollectionViewLayoutAttributes
        newAttributes.color = self.color.copyWithZone(zone) as! UIColor
        return newAttributes
    }
}
class SCSBCollectionReusableView : UICollectionReusableView {
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {       
        super.applyLayoutAttributes(layoutAttributes)
        let scLayoutAttributes = layoutAttributes as! SCSBCollectionViewLayoutAttributes self.backgroundColor =         scLayoutAttributes.color
    }
}
```

## How to use it? 
All this happens in the `UICollectionViewFlowLayout` used on your `UIcollectionView`. Here is an example of `layoutAttributesForElementsInRect`:
```
// Create decoration attributes
let decorationAttributes = SCSBCollectionViewLayoutAttributes(forDecorationViewOfKind: "sectionBackground", withIndexPath: attr.indexPath)
// Set the color(s)
if (attr.indexPath.section % 2 == 0) {
    decorationAttributes.color = UIColor.greenColor().colorWithAlphaComponent(0.5)
} else {
    decorationAttributes.color = UIColor.blueColor().colorWithAlphaComponent(0.5)
}
```
You will find all the details in the [SectionBackgroundFlowLayout.swift file](https://github.com/strawberrycode/SCSectionBackground/blob/master/SCSectionBackground/SectionBackgroundFlowLayout.swift) and if you want more details, please have a look at my the article I've written about it: [How to create a Section Background in a UICollectionView in Swift](http://bit.ly/1oQuC7I).

## Contact
You can ping me on Twitter [@cath_schwz](https://twitter.com/cath_schwz), open an issue on GitHub or leave a comment on my [blog](http://bit.ly/1oQuC7I) :)
