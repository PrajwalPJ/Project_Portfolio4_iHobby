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
        
        databaseWork()
        
    }
    
    // Delete button functionality
    @IBAction func DeleteEventButton(_ sender: Any) {
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                print("Deleted")
                
                self.tableview.deleteRows(at: [indexPath], with: .fade)
                //remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
        
            }}
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            createTheEvent.remove(at: indexPath.row)
            tableview.reloadData()
        }
    }
    
    // Edit event button functionality
    @IBAction func EditEventButton(_ sender: Any) {
       // presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // custom function to get database connection and pull and request data from the database
    func databaseWork(){
        // set the firebase reference
        ref = Database.database().reference()
        
        // testing again to read data
        ref?.observe(DataEventType.value, with: {(snapshot) in
            
            if snapshot.childrenCount > 0{
                self.createTheEvent.removeAll()
                
                for event in snapshot.children.allObjects as![DataSnapshot]{
                    let eventObject = event.value as? [String: AnyObject]
                    let eventTitle = eventObject?["Title"]
                    let eventDescription = eventObject?["Description"]
                    let eventLocation = eventObject?["Location"]
                    let eventDate = eventObject?["Date"]
                    let eventTime = eventObject?["Time"]
                    let eventId = eventObject?["uniqueID"]
                    
                    // call our data model
                    let event = CreateEvent(ieventTitle: eventTitle as! String?, ieventTime: eventTime as! String?, ieventLocation: eventLocation as! String?, ieventDescription: eventDescription as! String?, ieventDate: eventDate as! String?, initId: eventId as! String?)
                    
                    self.createTheEvent.append(event)                }
            }
            self.tableView.reloadData()
        })
        // retrieve the events and listen for changes
        databaseHandle = ref?.child("Event").observe(.childAdded, with: { (snapshot) in
            
            // code that executes when a child is added to "Event"
            // Take the value from snapshot and add it to EventData array
            // try to convert value of data to string
            let event = snapshot.value as? String
            
            if let actualEvent = event{
                // append data to to eventData array
                self.eventData.append(actualEvent)
                // reload the table view
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                //self.performSegue(withIdentifier: "CreateToView", sender: self)
                
                print(self.eventData)
            }
            
        })
    }
    
  
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    // set cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    // assign cell components with correct identifier
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell
            else{
                return tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        }
        
        //cell.eventTitle.text = createTheEvent[indexPath.row].eventTitle
        // Configure the cell...
       cell.eventTitle.text = myString1
        cell.eventTime.text = myString2
        cell.eventDate.text = myString3
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
