//
//  ShadowView.swift
//  Remind
//
//  Created by Stanley Pan on 17/10/2017.
//  Copyright © 2017 Stanley Pan. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        layer.shadowPath = CGPath(rect: layer.bounds, transform: nil)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
        
        layer.cornerRadius = 5
    }
}
