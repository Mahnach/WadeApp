//
//  HomeViewController.swift
//  phuza
//
//  Created by Stanislau Sakharchuk on 31/10/2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var hamburgerButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            DataManager.shared.currentUser = user
        }
    }
    
    @IBAction func hamburgerButtonDidTap() {
        if DataManager.shared.currentUser == nil {
            showMessage("You need to make an account", title: "Error")
            return
        }
        performSegue(withIdentifier: "presentMenu", sender: self)
    }
    
    @IBAction func plusButtonDidTap() {
        if DataManager.shared.currentUser == nil {
            performSegue(withIdentifier: "facebookLogin", sender: self)
        } else {
            performSegue(withIdentifier: "presentFeed", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "facebookLogin" {
            let viewController = (segue.destination as! UINavigationController).topViewController as! FacebookLoginViewController
            viewController.homeViewController = self
        }
    }
    
}
