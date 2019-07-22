//
//  FirstViewController.swift
//  pusula
//
//  Created by Tugce on 06/03/17.
//  Copyright © 2017 Tugce. All rights reserved.
//pa

import UIKit
import SWXMLHash
import Foundation

class FirstViewController: UIViewController {
    
    var foodItem : [Food] = [];
    
    
    
    let url = URL(string: "http://ogrenci.isikun.edu.tr/i/images/data/yemek.xml")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseXML()
        
        for food in foodItem {
            
            print(food.day)
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItem.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "FoodTableViewCell"

        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as? FoodTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
       //  let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        
        

        let food = foodItem[indexPath.row]
        
        cell.textLabel?.text = self.foodItem[indexPath.section].day
       
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        var temp = foodItem as NSArray
        return temp.index(of: title)
    }
    
    // parser
    
    
    func parseXML() {
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
            let xml = SWXMLHash.parse(data!)
            
            for menu in xml["Menu"]{
                let newItem = Food();

                if let val = menu.element?.attributes["ay"] {
                    newItem.mounth = val;
                   // print(val)
                }
                
                for elem in menu["yemek"] {
                    if let val = elem.element?.attributes["gun"] {
                        newItem.day = val;
                       // print(val)
                    }
                    
                    
                    if let val = elem["oglen"].element?.text {
                        newItem.evening = val;
                       // print(val)
                    
                    }
                    if let val = elem["aksam"].element?.text {
                        newItem.midday = val;
                        //print(val)
                    }
                    self.foodItem.append(newItem);

                }

                print(self.foodItem.count);

            }
            
            
        }
        task.resume()
       
    }
}



