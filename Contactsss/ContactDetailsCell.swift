//
//  ContactDetailsCell.swift
//  Contactsss
//
//  Created by AFFIXUS IMAC1 on 8/1/18.
//  Copyright © 2018 AFFIXUS IMAC1. All rights reserved.
//

import UIKit

class ContactDetailsCell: UITableViewCell {

    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var lbPersonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
