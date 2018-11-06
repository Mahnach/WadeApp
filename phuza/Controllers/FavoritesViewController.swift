//
//  FavoritesViewController.swift
//  phuza
//
//  Created by Sorochinskiy Dmitriy on 04.11.2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import Firebase

class FavoritesViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var ref: DatabaseReference!
    var offers: [Offer] = []
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavoritesMoreTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesMoreTableViewCell")
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
        
        ref = Database.database().reference()
        ref.child("offers").observe(.value) { (snapshot) in
            self.offers = []
            let favouritesItems = StorageManager.getFavoritesIds()
            for item in snapshot.children {
                let snap = item as! DataSnapshot
                let offer = Offer(id: snap.key, data: snap.value as? [String : Any] ?? [:])
                if (favouritesItems.filter{ return $0 == offer.id}.count) > 0 {
                    self.offers.append(offer)
                }
            }
            self.hideTableViewSeprator(false)
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func hideTableViewSeprator(_ isHidden: Bool) {
        tableView.separatorStyle = isHidden ? .none : .singleLine
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow, segue.identifier == "offerDetail" else { return }
        let offerViewController = segue.destination as! OfferViewController
        offerViewController.offer = offers[selectedIndexPath.row]
    }
    
    func getFeedViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        
        return viewController
    }
    
    func getofferViewController(offer: Offer) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OfferViewController") as! OfferViewController
        viewController.offer = offer
        
        return viewController
    }
}


extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == offers.count {
            show(getFeedViewController(), sender: nil)
        }
        else {
            show(getofferViewController(offer: offers[indexPath.row]), sender: nil)
        }
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == offers.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesMoreTableViewCell", for: indexPath) as! FavoritesMoreTableViewCell
            cell.selectionStyle = .none
            return cell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableCell", for: indexPath) as! FeedTableCell
            cell.offerImageView.kf.setImage(with: URL(string: offers[indexPath.row].image))
            cell.offer = offers[indexPath.row]
            cell.selectionStyle = .none
            
            return cell
        }
        
    }
    
}
