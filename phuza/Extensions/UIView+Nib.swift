//
//  UIView+Nib.swift
//  phuza
//
//  Created by Sorochinskiy Dmitriy on 03.11.2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit

extension UIView {
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    class func fromNib<T: UIView>(name: String) -> T {
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)![0] as! T
    }
}

