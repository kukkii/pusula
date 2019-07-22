//
//  FoodTableViewCell.swift
//  pusula
//
//  Created by Tugce on 11/04/17.
//  Copyright © 2017 Tugce. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var lunch: UITextView!
    @IBOutlet weak var dinner: UITextView!
    
      
    override func awakeFromNib() {
        // Initialization code
        super.awakeFromNib()
        lunch.isScrollEnabled = false
        dinner.isScrollEnabled = false
        lunch.isEditable = false
        dinner.isEditable = false
        day.isEnabled = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
