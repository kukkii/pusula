//
//  ShuttleWeekStatusViewController.swift
//  pusula
//
//  Created by Tugce on 31/05/17.
//  Copyright © 2017 Tugce. All rights reserved.
//

import UIKit

class ShuttleWeekStatusViewController: UIViewController {
    
    @IBAction func pazarButton(_ sender: Any) {
        
        ShuttleViewController.status = "sunday"
    }
    @IBAction func cumartesiButton(_ sender: Any) {
        
        ShuttleViewController.status = "saturday"
    }
    @IBAction func haftaiciButton(_ sender: Any) {
        
        ShuttleViewController.status = "weekdays"

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
   

}
