//
//  FoodTableViewController.swift
//  pusula
//
//  Created by Tugce on 11/04/17.
//  Copyright © 2017 Tugce. All rights reserved.
//

import UIKit
import SWXMLHash


class FoodTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var  foodItem : [Food] = [];
    var size = 0;
    let url = URL(string: "http://ogrenci.isikun.edu.tr/i/images/data/yemek.xml")
    var day = 0
    var month : String = String ()
    var months: [String] = ["January","February","March","April","May","June","July","August","September", "October","November","December"]
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Load the sample data.

        let date = Date()
        let calendar = Calendar.current
        
        day = calendar.component(.day, from: date)
        let numberOfMonth = calendar.component(.month, from: date)
        
        month = self.months[numberOfMonth-1]
        parseXML();
       
        
        
        
    }
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table view data source
    
     override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        size = self.foodItem.count ;
        size =  size-day+1
        return self.size
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false;
       
        let cellIdentifier = "FoodTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FoodTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FoodTableViewCell.")
        }
        
        let food = foodItem[indexPath.row+day-1]
        
      
        if Int(food.day)! >= self.day {
            
            cell.day.text = food.day + " " + month
            cell.lunch.text = food.evening
            cell.dinner.text = food.midday
        }

        return cell
    }
    
    
    
    //MARK: Custom Functions
    

    func parseXML() {

        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            let xml = SWXMLHash.parse(data!)
            
            for menu in xml["Menu"]{
                let newItem = Food();

                
                if let val = menu.element?.attributes["ay"] {
                    newItem.mounth = val;
                }
                
                for elem in menu["yemek"] {
                    let newItem = Food();

                    if let val = elem.element?.attributes["gun"] {
                        newItem.day = val;
                    }
                    if let val = elem["oglen"].element?.text {
                        newItem.evening = val;
                        
                    }
                    if let val = elem["aksam"].element?.text {
                        newItem.midday = val;
                    }
                    self.foodItem.append(newItem);

                }
            }
            self.tableView.reloadData()
            
        }
        task.resume()

        
        
        
      
    }
    
}
