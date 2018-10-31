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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            hamburgerButton.isHidden = false
            plusButton.isHidden = true
            DataManager.shared.currentUser = user
        } else {
            plusButton.isHidden = false
            hamburgerButton.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "facebookLogin" {
            let viewController = (segue.destination as! UINavigationController).topViewController as! FacebookLoginViewController
            viewController.homeViewController = self
        }
    }
    
    func presentFeedViewController() {
        let feedViewController = storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        navigationController?.pushViewController(feedViewController, animated: true)
    }
    
}
