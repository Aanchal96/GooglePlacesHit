//
//  AttributesTableViewCell.swift
//  GooglePlacesHit
//
//  Created by Appinventiv on 15/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class AttributesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var vicinityLable: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
