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

class ExploreEventsTableViewController: UITableViewController, UISearchBarDelegate,  UISearchResultsUpdating, UISearchControllerDelegate, UINavigationControllerDelegate{
  
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    var searchController = UISearchController(searchResultsController: nil)
    var isSearching = false
    

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
        
        // setup search controller
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        
        // to recieve updates to searches here in this tableviewcontroller
        searchController.searchResultsUpdater = self
        
        // setup SearchBar of the search conroller
       searchController.searchBar.scopeButtonTitles = ["All", "Title", "Location"]
        searchController.searchBar.delegate = self
        
        // Add the search bar to the table view as a header
        tableView.tableHeaderView = searchController.searchBar
        
        // since we reloaded the searchbar we need to make sure that it is sized correctly
        searchController.searchBar.sizeToFit()
        
        filteredEvents = eventList
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
        return 120
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
    
    override func viewWillDisappear(_ animated: Bool) {
        filteredEvents = eventList
        searchController.isActive = false
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // get the text our user wants to search for
        let searchText = searchController.searchBar.text
        
        // get the scope title that the user has selected
        let selectedScope = searchController.searchBar.selectedScopeButtonIndex
       let allScopeTitles = searchController.searchBar.scopeButtonTitles!
        let scopeTitle = allScopeTitles[selectedScope]
        
        
        // dump our full data set into the array we will use for filtering
        filteredEvents = eventList
        
        // if the user typed anything into the search field, filtered based on that entry
        if searchText != ""{
            
            filteredEvents = filteredEvents.filter({ (title) -> Bool in
                return title.eventTitle?.lowercased().range(of: searchText!.lowercased()) != nil
            })
        }
        // then filter again based on scope
        if scopeTitle != "All"{
            filteredEvents = filteredEvents.filter({
                
                // here we use $0 to represent the current element instead of naming the parameter
                $0.eventTitle?.range(of: scopeTitle) != nil
            })
        }
        tableView.reloadData()
    }
    
    // this delegate methid is called when the user chages the scope since they handled that in our implementation of the updateSearchResults we can just call that method here and let it take care of everything
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
    }
    
    override func viewDidLayoutSubviews() {
        self.searchController.searchBar.sizeToFit()
    }
    
}
