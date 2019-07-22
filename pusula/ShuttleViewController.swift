//
//  ShuttleViewController.swift
//  pusula
//
//  Created by Tugce on 22/04/17.
//  Copyright © 2017 Tugce. All rights reserved.
//

import UIKit
import Alamofire

class ShuttleViewController: UIViewController , UICollectionViewDelegate ,UICollectionViewDataSource{
    
    //MARK: Properties

    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var banner: UINavigationItem!
    var currentWeekStatus : [Shuttle] = []
    var KtoKadikoy : [Shuttle] = []
    var KtoKampus : [Shuttle] = []
    var KtoMaslak : [Shuttle] = []
    var MtoKampus : [Shuttle] = []
    var StoKampus : [Shuttle] = []
    var KtoSile : [Shuttle] = []
    var toKabatas : [Shuttle] = []
    static var status : String = "weekdays"
    var weekStringTV : [String] = ["KAMPUS - KADIKÖY" , "KADIKÖY-KAMPUS" ,"KAMPUS-MASLAK" ,"MASLAK-KAMPUS" ,"KAMPUS-SILE" ,"SILE-KAMPUS" ,"KABATAŞ-KAMPÜS"]


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        Json()
    }

    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return weekStringTV.count
    }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
    banner.title = ShuttleViewController.status

        collectionView.delegate = self
        collectionView.dataSource = self
    

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ShuttleCollectionViewCell"
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ShuttleCollectionViewCell  else {
            fatalError("The dequeued cell is not an instance of ShuttleCollectionViewCell.")
        }
    if currentWeekStatus.count != 0 {
        
        switch weekStringTV[indexPath.row] {
        case "KAMPUS - KADIKÖY":
            cell.tag = 0
        case "KADIKÖY-KAMPUS":
            cell.tag = 1
        case "KAMPUS-MASLAK":
            cell.tag = 2
        case "MASLAK-KAMPUS":
            cell.tag = 3
        case "KAMPUS-SILE":
            cell.tag = 4
        case "SILE-KAMPUS":
            cell.tag = 5
        case "KABATAŞ-KAMPÜS":
            cell.tag = 6
        default:
            print("Error")
        }
        
        cell.shuttleHours.text! = ""

        var shuttleHoursTv : String = String()
        
        switch cell.tag {
            
        case 0:
            for index in 0 ..< KtoKadikoy.count {
                shuttleHoursTv = KtoKadikoy[index].departure_time!
                cell.shuttleHours.text! += shuttleHoursTv + "\n"
            }
        case 1:
            for index in 0 ..< KtoKampus.count {
                shuttleHoursTv = KtoKampus[index].departure_time!
                cell.shuttleHours.text! += shuttleHoursTv + "\n"
            }
        case 2:
            for index in 0 ..< KtoMaslak.count {
                shuttleHoursTv = KtoMaslak[index].departure_time!
                cell.shuttleHours.text! += shuttleHoursTv + "\n"
            }
        case 3:
            for index in 0 ..< MtoKampus.count {
                shuttleHoursTv = MtoKampus[index].departure_time!
                cell.shuttleHours.text! += shuttleHoursTv + "\n"
            }
        case 4:
            for index in 0 ..< KtoSile.count {
                shuttleHoursTv = KtoSile[index].departure_time!
                cell.shuttleHours.text! += shuttleHoursTv + "\n"
            }
        case 5:
            for index in 0 ..< StoKampus.count {
                shuttleHoursTv = StoKampus[index].departure_time!
                cell.shuttleHours.text! += shuttleHoursTv + "\n"
            }
        case 6:
            for index in 0 ..< toKabatas.count {
                shuttleHoursTv = KtoKampus[index].departure_time!
                cell.shuttleHours.text! += shuttleHoursTv + "\n"
            }
        default:
            print("Error")
        }
        
    cell.destination.text = String(describing: self.weekStringTV[indexPath.row])
    }
    
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            ShuttleDetailTableViewController.item = self.KtoKadikoy
        case 1:
            ShuttleDetailTableViewController.item = self.KtoKampus
        case 2:
            ShuttleDetailTableViewController.item = self.KtoMaslak
        case 3:
            ShuttleDetailTableViewController.item = self.MtoKampus
        case 4:
            ShuttleDetailTableViewController.item = self.KtoSile
        case 5:
            ShuttleDetailTableViewController.item = self.StoKampus
        case 6:
            ShuttleDetailTableViewController.item = self.toKabatas
        default:
            print("Error")
        
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Custom functions

    func Json () {
       
        
        switch ShuttleViewController.status {
        case "weekdays":
            self.fillWeekArray(weekStatus: "weekdays")
        case "saturday":
            self.fillWeekArray(weekStatus: "saturday")
        case "sunday":
            self.fillWeekArray(weekStatus: "sunday")
        default:
                print("Error")
        }
      
        
            }
  
    func fillWeekArray(weekStatus : String ){
        
        var arr : [NSDictionary] = [NSDictionary()]

        
        Alamofire.request("http://pusula.herokuapp.com").responseJSON { response in
            
            
            var name : String
            var departureTime : String
            
            
            do{
                
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    arr = try(JSON.value(forKey: weekStatus) as? Array<NSDictionary>)!
                    
                    
                    for index in 0 ..< arr.count {
                        let currentShuttle : Shuttle = Shuttle()
                        name = (arr[index].value(forKeyPath: "name") as? String)!
                        departureTime = (arr[index].value(forKeyPath: "departure_time") as? String)!
                        currentShuttle.departure_time = departureTime
                        currentShuttle.weekStatus = weekStatus
                        currentShuttle.name = name
                        self.currentWeekStatus.append(currentShuttle)
                    }
                    
                   
                    self.CollectionView.reloadData()
                }
                
            }
            catch {
                print("Error")
                
            }
            
            
            
            
        }

    }
    
    
    
    

}
