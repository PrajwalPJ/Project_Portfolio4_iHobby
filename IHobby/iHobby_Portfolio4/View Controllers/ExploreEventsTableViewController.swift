//
//  ExploreEventsTableViewController.swift
//  iHobby_Portfolio4
//
//  Created by Prajwal Ramamurthy on 5/22/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ExploreEventsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearching = false
    
       var filteredEvents = [CreateEvent]()
    // reference to the databse
    var ref: DatabaseReference!
    var refHandle: DatabaseHandle?
    // array to use the objects and store in
    var eventList: [CreateEvent] = []
    

    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem

        // set the firebase reference
        ref = Database.database().reference()
        // call our fetch function
        GetFirebaseData()
        
        // search bar
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done

          searchBarTextDidEndEditing(searchBar)
       // searchBarO()
    }

    // custom function to fetch data
    func GetFirebaseData()
    {
        ref = Database.database().reference().child("Event") //setting my reference to start inside of my users node
        ref.observe(.childAdded, with: { (snapshot) in
            
            print(snapshot.value)
            // Get user value and set it to the currentPerson object that i have set
            let event = snapshot.value as? NSDictionary

            let title = event?["Title"] as? String ?? ""
            let date = event?["Date"] as? String ?? ""
            let time = event?["Time"] as? String ?? ""
            
            self.eventList.append(CreateEvent(ieventTitle: title, ieventTime: time, ieventLocation: "", ieventDescription: "", ieventDate: date, initId: ""))
            // reload tableview
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })
        { (error) in
            print(error.localizedDescription)
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
     
        
        if isSearching{
            return filteredEvents.count
        }
           return eventList.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreCellID1", for: indexPath) as? ExploreEventCell
            else{
                return tableView.dequeueReusableCell(withIdentifier: "ExploreCellID1", for: indexPath)
        }
        var text = [CreateEvent].Element()
        if isSearching{
            text = filteredEvents[indexPath.row]
        }
        // Configure the cell...
        cell.exploreTitle.text = eventList[indexPath.row].eventTitle
        cell.exploreTime.text = eventList[indexPath.row].eventTime
        cell.exploreDate.text = eventList[indexPath.row].eventDate

        
        return cell
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        if searchBar.text != ""
        {
            searchText = searchBar.text!
        }
        
        searchBarTextDidEndEditing(searchBar)
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            
            view.endEditing(true)
            
            tableView.reloadData()
            
            
        }else{
            isSearching = true
            let searchString = searchText.trimWhiteSpace()
            if searchString != "", searchString.count > 0 {
                let filterData = eventList.filter {
                    return $0.id?.range(of: searchString, options: .caseInsensitive) != nil
                }
            }
            tableView.reloadData()
        }
        
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
extension String {
    func trimWhiteSpace() -> String {
        let string = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return string
    }
}
