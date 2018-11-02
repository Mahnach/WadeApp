//
//  OfferViewController.swift
//  phuza
//
//  Created by Stanislau Sakharchuk on 02/11/2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit
import SafariServices

class OfferViewController: UITableViewController {
    
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var revealButton: UIButton!
    
    var offer: Offer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateContent()
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    func updateContent() {
        guard offer != nil else { return }
        offerImageView.kf.setImage(with: URL(string: offer.image))
        offerLabel.text = offer.title
        headlineLabel.text = offer.headline
        textLabel.text = offer.text
        linkButton.setTitle(offer.link, for: .normal)
        revealButton.backgroundColor = offer.buttonColor
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard offer != nil else { return .default }
        return offer.statusBarStyle
    }
    
    @IBAction func linkButtonDidTap() {
        guard offer != nil else { return }
        guard let url = URL(string: offer.link) else { return }
        if UIApplication.shared.canOpenURL(url) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        } else {
            showMessage("Can't open url", title: "Error")
        }
    }
    
}
