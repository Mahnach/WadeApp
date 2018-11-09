//
//  FacebookLoginViewController.swift
//  phuza
//
//  Created by Stanislau Sakharchuk on 31/10/2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookLoginViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    weak var homeViewController: HomeViewController?
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupUI() {
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.borderColor = UIColor(red: 229.0/255.0, green: 229.0/255.0, blue: 229.0/255.0, alpha: 1.0).cgColor
        userNameLabel.text = Auth.auth().currentUser?.displayName
    }
    
    @IBAction func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginFacebookAction() {
        UserDefaults.standard.set(true, forKey: "auth")
        self.dismiss(animated: true, completion: nil)
    }

}
