//
//  ShuttleTableViewCell.swift
//  pusula
//
//  Created by Tugce on 22/04/17.
//  Copyright © 2017 Tugce. All rights reserved.
//

import UIKit

class ShuttleTableViewCell: UITableViewCell {

    @IBOutlet weak var destination: UIView!
    @IBOutlet weak var shuttleHours: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shuttleHours.isEditable = false
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
