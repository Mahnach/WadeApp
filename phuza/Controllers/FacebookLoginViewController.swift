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
    }
    
    @IBAction func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginFacebookAction() {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self) { (result, error) in
            DispatchQueue.main.async {
                guard let result = result, let resultToken = result.token, let token = resultToken.tokenString, error == nil else {
                    self.showMessage("Unable to log in with Facebook", title: "Error")
                    return
                }
                let credential = FacebookAuthProvider.credential(withAccessToken: token)
                Auth.auth().signInAndRetrieveData(with: credential, completion: { (authResult, error) in
                    guard let _ = authResult, error == nil else {
                        self.showMessage("Unable to log in with Facebook", title: "Error")
                        return
                    }
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
}
