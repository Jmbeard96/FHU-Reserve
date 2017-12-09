//
//  FavoritesTableViewCell.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 12/9/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomDescription: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
