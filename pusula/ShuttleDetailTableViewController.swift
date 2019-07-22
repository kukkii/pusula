//
//  ShuttleDetailTableViewController.swift
//  pusula
//
//  Created by Tugce on 07/06/17.
//  Copyright © 2017 Tugce. All rights reserved.
//

import UIKit

class ShuttleDetailTableViewController: UITableViewController  {
    
    //MARK: Properties

    @IBOutlet var tableViewNew: UITableView!
    static var item : [Shuttle] = [Shuttle()]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableViewNew.delegate = self
        self.tableViewNew.dataSource = self

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(ShuttleDetailTableViewController.item.count == 0 ){
            return 1
        }
        return ShuttleDetailTableViewController.item.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        let cellIdentifier = "ShuttleDetailCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ShuttleDetailTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ShuttleDetailCell.")
        }
        if ShuttleDetailTableViewController.item.count != 0  {
            
            let hour = ShuttleDetailTableViewController.item[indexPath.row]
            cell.hours.text = hour.departure_time
        
        }
        
        
        return cell
    }

    
}
