//
//  HomeViewController.swift
//  phuza
//
//  Created by Stanislau Sakharchuk on 31/10/2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var hamburgerButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        let isAuth = UserDefaults.standard.bool(forKey: "auth")
        if isAuth {
            performSegue(withIdentifier: "presentFeed", sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            DataManager.shared.currentUser = user
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func hamburgerButtonDidTap() {
        if DataManager.shared.currentUser == nil {
            showMessage("You need to make an account", title: "Error")
            return
        }
        performSegue(withIdentifier: "presentMenu", sender: self)
    }
    
    
    func facebookLogin(completion: @escaping(Bool) ->()) {
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
                    completion(true)
                })
            }
        }
    }
    
    
    @IBAction func plusButtonDidTap() {
        if DataManager.shared.currentUser == nil {
            facebookLogin { (completion) in
                if completion {
                    self.dismiss(animated: true, completion: nil)
                    self.performSegue(withIdentifier: "facebookLogin", sender: self)
                }
            }
        } else {
            performSegue(withIdentifier: "facebookLogin", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "facebookLogin" {
            let viewController = (segue.destination as! UINavigationController).topViewController as! FacebookLoginViewController
            viewController.homeViewController = self
        }
    }
    
}
