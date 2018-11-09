//
//  MenuViewController.swift
//  phuza
//
//  Created by Stanislau Sakharchuk on 01/11/2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit
import Firebase

enum MenuType {
    case favourites, settings
}

struct MenuItem {
    let title: String
    let type: MenuType
}

class MenuViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var items: [MenuItem] = [
        MenuItem(title: "Favourites", type: .favourites),
        MenuItem(title: "Settings", type: .settings)
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
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
    
    @IBAction func logoutAction() {
        do {
            try Auth.auth().signOut()
            DataManager.shared.currentUser = nil
            StorageManager.removeFavourites()

            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        } catch {
            print(error)
        }
    }
    
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath) as! MenuItemCell
        cell.itemLabel.text = items[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch items[indexPath.row].type {
        case .favourites:
            performSegue(withIdentifier: "showFavourites", sender: self)
            break
        case .settings:
            performSegue(withIdentifier: "presentSettings", sender: self)
            break
        }
    }
    
}

class MenuItemCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
}


class LogoutButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var iphoneX = false
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                iphoneX = true
            case 2688:
                iphoneX = true
            case 1792:
                iphoneX = true
            default:
                print("unknown")
            }
        }
        if iphoneX {
            roundCorners(.allCorners, radius: 4.0)
        } else {
            roundCorners([.topLeft, .topRight], radius: 4.0)
        }
    }
}
