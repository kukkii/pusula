//
//  ShuttleViewController.swift
//  pusula
//
//  Created by Tugce on 22/04/17.
//  Copyright © 2017 Tugce. All rights reserved.
//

import UIKit
import Firebase

class EventViewController: UIViewController , UICollectionViewDelegate ,UICollectionViewDataSource{
    
    //MARK: Properties

    @IBOutlet weak var CollectionView: UICollectionView!
    let rootRef =  FIRDatabase.database().reference()
    var eventArr : [Event] = []
    var selectedEvent : Event?
    static var shared = Event() //lazy init, and it only runs once

    override func viewDidLoad() {
        super.viewDidLoad()
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        FirebaseData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        EventViewController.shared = eventArr[indexPath.item]
        
    }
    
 
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.eventArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let cellIdentifier = "EventCollectionViewCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? EventCollectionViewCell  else {
            fatalError("The dequeued cell is not an instance of EventCollectionViewCell.")
        }
        
        
        if self.eventArr.count != 0 {
            
            let event = self.eventArr[indexPath.row]
            
            cell.eName.text = event.eName
            cell.eTime.text = event.eTime
            let url = URL(string: event.poster)!
            let session = URLSession(configuration: .default)
        
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let res = response as? HTTPURLResponse {
                        print("Downloaded picture with response code \(res.statusCode)")
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            cell.eImage.image = image                                                    } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code for some reason")
                    }
                }
            }
            
            downloadPicTask.resume()
                    }
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:  Custom Functions
    
    func FirebaseData(){
        
        var event = Event()

        rootRef.child("events").observeSingleEvent(of: .value, with: { (dataSnapshot) in
            
            
            for snapshot in dataSnapshot.children.allObjects as! [FIRDataSnapshot] {
                event = Event()
                let value = snapshot.value as? NSDictionary
                let eventName = value?["eName"] as? String ?? ""
                let eventTime = value?["eTime"] as? String ?? ""
                let owner = value?["owner"] as? String ?? ""
                let descp = value?["description"] as? String ?? ""
                let phone = value?["phone"] as? String ?? ""
                let poster = value?["poster"] as? String ?? ""
                let location = value?["eLocation"] as? String ?? ""
                
                event.eName = eventName
                event.eTime = eventTime
                event.owner = owner
                event.description = descp
                event.phone = phone
                event.poster = poster
                event.location = location
                
                self.eventArr.append(event)
            
          }
            self.CollectionView.reloadData()
            
    
        }) { (error) in
            print(error.localizedDescription)
        }
        
    
    }
    
}
