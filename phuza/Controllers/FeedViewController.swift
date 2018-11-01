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

class Offer {
    
    let id: String
    let headline: String
    let image: String
    let link: String
    let title: String
    let text: String
    
    init(id: String, data: [String : Any]) {
        self.id = id
        self.headline = data["headline"] as? String ?? ""
        self.image = data["image"] as? String ?? ""
        self.link = data["link"] as? String ?? ""
        self.title = data["offer"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
        
    }
    
}

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference!
    var offers: [Offer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        ref.child("offers").observe(.value) { (snapshot) in
            self.offers = []
            for item in snapshot.children {
                let snap = item as! DataSnapshot
                self.offers.append(Offer(id: snap.key, data: snap.value as? [String : Any] ?? [:]))
            }
            self.tableView.reloadData()
        }
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

class FeedTableCell: UITableViewCell {
    @IBOutlet weak var offerImageView: UIImageView!
}
