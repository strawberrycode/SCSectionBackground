//
//  Extensions.swift
//  SCSectionBackground
//
//  Created by Catherine Schwartz on 12/02/2016.
//  Copyright © 2016 StrawberryCode. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setBorder(color: UIColor, width: CGFloat = 1.0) {
        
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
}
