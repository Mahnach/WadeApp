//
//  FeedViewController.swift
//  phuza
//
//  Created by Stanislau Sakharchuk on 31/10/2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import Firebase

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var ref: DatabaseReference!
    var offers: [Offer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideTableViewSeprator(true)
        activityIndicator.startAnimating()
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        ref = Database.database().reference()
        ref.child("offers").observe(.value) { (snapshot) in
            self.offers = []
            for item in snapshot.children {
                let snap = item as! DataSnapshot
                self.offers.append(Offer(id: snap.key, data: snap.value as? [String : Any] ?? [:]))
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
    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableCell", for: indexPath) as! FeedTableCell
        cell.offerImageView.kf.setImage(with: URL(string: offers[indexPath.row].image))
        return cell
    }
    
}
