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
    
    enum LikeButtonState {
        case liked, unliked
    }
    
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var revealButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var offer: Offer!
    var likeButtonState: LikeButtonState = .unliked
    
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
        let filteredFavoritesIds = StorageManager.getFavoritesIds().filter { return offer.id == $0 }
        if filteredFavoritesIds.count > 0  {
            likeButton.tintColor = .red
            likeButtonState = .liked
        }
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
    
    @IBAction func revealCodeButtonTouched(_ sender: Any) {
        revealButton.setTitle("PHUZAXYZ", for: .normal)
    }
    
    @IBAction func likeButtonTouched(_ sender: Any) {
        switch likeButtonState {
        case .liked:
            likeButton.tintColor = .black
            likeButtonState = .unliked
            StorageManager.removeFromFavorite(id: offer.id)
        case .unliked:
            likeButton.tintColor = .red
            likeButtonState = .liked
            StorageManager.addToFavourite(id: offer.id)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.offerToSpend.rawValue {
            (segue.destination as? SpendViewController)?.offer = offer
        }
    }
}
