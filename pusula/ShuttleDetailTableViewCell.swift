//
//  ShuttleDetailTableViewCell.swift
//  pusula
//
//  Created by Tugce on 07/06/17.
//  Copyright © 2017 Tugce. All rights reserved.
//

import UIKit

class ShuttleDetailTableViewCell: UITableViewCell {

    //MARK: Properties

    @IBOutlet weak var hours: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
