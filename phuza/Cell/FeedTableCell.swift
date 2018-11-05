//
//  FeedTableCell.swift
//  phuza
//
//  Created by Stanislau Sakharchuk on 02/11/2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit

class FeedTableCell: UITableViewCell {
    @IBOutlet weak var offerImageView: UIImageView!
    var offer: Offer = Offer(id: "", data: [:])
}
