//
//  EventCollectionViewCell.swift
//  pusula
//
//  Created by Tugce on 10/05/17.
//  Copyright © 2017 Tugce. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties

    @IBOutlet weak var eImage: UIImageView!
    @IBOutlet weak var eName: UITextView!
    @IBOutlet weak var eTime: UITextView!
    
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        eName.isScrollEnabled = false
        eTime.isScrollEnabled = false
        eName.isEditable = false
        eTime.isEditable = false
        
    }

}


