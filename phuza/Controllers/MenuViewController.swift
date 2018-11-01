//
//  MenuViewController.swift
//  phuza
//
//  Created by Stanislau Sakharchuk on 01/11/2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = DataManager.shared.currentUser {
            usernameLabel.text = user.displayName
            if let photoUrl = user.photoURL {
                userImageView.kf.setImage(with: photoUrl)
            }
        }
    }
    
    @IBAction func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
    
}
