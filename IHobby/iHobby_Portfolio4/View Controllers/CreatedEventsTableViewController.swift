//
//  CreatedEventsTableViewController.swift
//  iHobby_Portfolio4
//
//  Created by Prajwal Ramamurthy on 5/16/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class CreatedEventsTableViewController: UITableViewController {
    
    // variables and outlets we need to use later
    var createTheEvent: [CreateEvent] = []
        var eventList: [CreateEvent] = []
    var eventData = [String]()
    var myString1 = String()
    var myString2 = String()
    var myString3 = String()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    @IBOutlet var tableview: UITableView!
    
    // start of the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        // call function to pull data
        GetFirebaseData()
    
    }
    
    // custom function to fetch data
    func GetFirebaseData()
    {
        ref = Database.database().reference().child("Event") //setting my reference to start inside of my users node
        ref?.observe(.childAdded, with: { (snapshot) in
            
            print(snapshot.value)
            // Get user value and set it to the currentPerson object that i have set
            let event = snapshot.value as? NSDictionary
            
            let title = event?["Title"] as? String ?? ""
            let date = event?["Date"] as? String ?? ""
            let time = event?["Time"] as? String ?? ""
            let location = event?["Location"] as? String ?? ""
            let description = event?["Description"] as? String ?? ""
            
            self.eventList.append(CreateEvent(ieventTitle: title, ieventTime: time, ieventLocation: location, ieventDescription: description, ieventDate: date, initId: self.ref?.key, initUserId: self.ref?.key))
            
           
            // reload tableview
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })
        { (error) in
            print(error.localizedDescription)
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
           // createTheEvent.remove(at: indexPath.row)
            var eventId = eventList[indexPath.row].id
            
            var eventRef = Database.database().reference().child("Event").child(eventId!)
            eventRef.removeValue()
            
            eventList.remove(at: indexPath.row)
            self.tableview.deleteRows(at: [indexPath], with: .fade)
            
           
            tableview.reloadData()
        }
    }
    

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventList.count
    }
    
    // set cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // assign cell components with correct identifier
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell
            else{
                return tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        }
        //print(eventList[indexPath.row].id)
        // Configure the cell...
        cell.eventTitle.text = eventList[indexPath.row].eventTitle
        cell.eventTime.text = eventList[indexPath.row].eventTime
        cell.eventDate.text = eventList[indexPath.row].eventDate
        cell.eventLocation.text = eventList[indexPath.row].eventLocation
        cell.eventDescription.text = eventList[indexPath.row].eventDescription
        
        return cell
    }
    
    
}
