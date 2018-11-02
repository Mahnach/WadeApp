//
//  Offer.swift
//  phuza
//
//  Created by Stanislau Sakharchuk on 02/11/2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit

class Offer {
    
    let id: String
    let headline: String
    let image: String
    let link: String
    let title: String
    let text: String
    let buttonColorHex: String
    let statusBarStyle: UIStatusBarStyle
    
    init(id: String, data: [String : Any]) {
        self.id = id
        self.headline = data["headline"] as? String ?? ""
        self.image = data["image"] as? String ?? ""
        self.link = data["link"] as? String ?? ""
        self.title = data["offer"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
        self.buttonColorHex = data["button_color"] as? String ?? "#000000"
        if let statusBarStyle = data["status_bar_style"] as? String {
            self.statusBarStyle = Int(statusBarStyle) == 1 ? .lightContent : .default
        } else {
            self.statusBarStyle = .default
        }
    }
    
    var buttonColor: UIColor {
        var cString:String = buttonColorHex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0))
    }
    
}
