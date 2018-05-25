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

// globbal array
var filteredEvents = [CreateEvent]()
var isFiltering =  false

class ExploreEventsTableViewController: UITableViewController, UISearchBarDelegate,  UISearchResultsUpdating, UISearchControllerDelegate, UINavigationControllerDelegate{
    
    // variables and outlets
    var searchController = UISearchController()
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching = false
    // reference to the databse
    var ref: DatabaseReference!
    var refHandle: DatabaseHandle?
    // array to use the objects and store in
    var eventList: [CreateEvent] = []
    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        // set the firebase reference
        ref = Database.database().reference()
        // call our fetch function
        GetFirebaseData()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
            
            // add it to our data model
            self.eventList.append(CreateEvent(ieventTitle: title, ieventTime: time, ieventLocation: "", ieventDescription: "", ieventDate: date, initId: "", initUserId: ""))
            // reload tableview
            DispatchQueue.main.async {
                filteredEvents = self.eventList
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
        if searchController.isActive {
            return filteredEvents.count
        }else{
            return eventList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreCellID1", for: indexPath) as? ExploreEventCell
            else{
                return tableView.dequeueReusableCell(withIdentifier: "ExploreCellID1", for: indexPath)
        }
        
        // chech if we are searching
        if searchController.isActive {
            cell.textLabel?.text? = filteredEvents[indexPath.row].eventTitle!
        }else{
            cell.textLabel?.text? = eventList[indexPath.row].eventTitle!
        }
        var text = [CreateEvent].Element()
        let event: CreateEvent
        if searchController.isActive {
            event = filteredEvents[indexPath.row]
            
        } else {
            event = eventList[indexPath.row]
        }
        
        // Configure the cell...
        cell.exploreTitle.text = filteredEvents[indexPath.row].eventTitle
        cell.exploreTime.text = filteredEvents[indexPath.row].eventTime
        cell.exploreDate.text = filteredEvents[indexPath.row].eventDate
        
        return cell
    }
    
    // when the click happens stop editing
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // when text changes it affects it
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isFiltering = false
            tableView.reloadData()
            view.endEditing(true)
        } else {
            isFiltering = true
            let lower = searchBar.text!
            filteredEvents = eventList.filter({$0.eventTitle?.range(of: lower) != nil})
            tableView.reloadData()
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased(){
            if searchText.characters.count == 0{
                filteredEvents = eventList
            }else{
                filteredEvents = eventList.filter{ return $0.eventTitle!.contains(searchText)
                    var s = ""
                }
            }
        }
        tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        if let searchText = searchController.searchBar.text?.lowercased(){
            if searchText.characters.count == 0{
                filteredEvents = eventList
            }else{
                filteredEvents = eventList.filter{ return $0.eventTitle!.contains(searchText)
                }
                
            }
            tableView.reloadData()
        }
    }
    
    // this delegate methid is called when the user chages the scope since they handled that in our implementation of the updateSearchResults we can just call that method here and let it take care of everything
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
    }
    
}

