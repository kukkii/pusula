//
//  EventDetailViewController.swift
//  pusula
//
//  Created by Tugce on 31/05/17.
//  Copyright © 2017 Tugce. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    //MARK: Properties

    var eventVar : Event?
    var receivedString = ""

    @IBOutlet weak var eventName: UITextView!
    @IBOutlet weak var eventDescp: UITextView!
    @IBOutlet weak var eventLocation: UITextView!
    @IBOutlet weak var time: UITextView!
    @IBOutlet weak var owner: UITextView!
    @IBOutlet weak var poster: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        eventVar = EventViewController.shared
        eventName.text = eventVar?.eName
        eventDescp.text = eventVar?.description
        eventLocation.text = eventVar?.location
        owner.text = eventVar?.owner
        time.text = eventVar?.eTime
        
    
        let url = URL(string: (eventVar?.poster)!)!
        downloadPicTask(url: url)
    }
    
    // MARK: - Custom Functions
    
    func downloadPicTask (url: URL){
        
        let session = URLSession(configuration: .default)

        
        let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print("Error downloading picture: \(e)")
            } else {
                // It would be weird if we didn't have a response,checking for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image.
                        let image = UIImage(data: imageData)
                        self.poster.image = image
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        
        downloadPicTask.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
