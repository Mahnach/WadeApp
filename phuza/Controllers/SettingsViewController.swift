//
//  SettingsViewController.swift
//  phuza
//
//  Created by Stanislau Sakharchuk on 02/11/2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit

struct SettingsMenuItem {
    enum SettingsMenuItemType {
        case terms, privacy
    }
    
    let title: String
    let type: SettingsMenuItemType
}

class SettingsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [SettingsMenuItem] = [SettingsMenuItem(title: "Privacy Policy", type: .privacy),
                                     SettingsMenuItem(title: "Terms & Conditions", type: .terms)]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SettingsMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsMenuTableViewCell")
    }
    
    // MARK: - Actions
    @IBAction func closeAction() {
        dismiss(animated: true, completion: nil)
    }
    
    func getPrivacyController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
        
        return viewController
    }
    
    func getTermsViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PrivacyViewController") as! PrivacyViewController
        
        return viewController
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch items[indexPath.row].type {
        case .privacy:
            present(getPrivacyController(), animated: true)
        case .terms:
            present(getTermsViewController(), animated: true)
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsMenuTableViewCell") as! SettingsMenuTableViewCell
        cell.cellTitle.text = items[indexPath.row].title
        cell.selectionStyle = .none
        
        return cell
    }
}
