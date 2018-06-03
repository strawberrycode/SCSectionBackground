//
//  SectionBackgroundCollectionViewController.swift
//  SCSectionBackground
//
//  Created by Catherine Schwartz on 12/02/2016.
//  Copyright © 2016 StrawberryCode. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SectionBackgroundCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        self.collectionView?.backgroundColor = UIColor.white // white for the example with transparency  -- UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section % 2 == 0) {
            return 3
        }
        return 7
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath )
        
        // Configure the cell
        cell.backgroundColor = UIColor(white: 0.9, alpha: 1)
        cell.setBorder(color: UIColor.red)
        
        return cell
    }


}
