//
//  CreateEventViewController.swift
//  iHobby_Portfolio4
//
//  Created by Prajwal Ramamurthy on 5/15/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//


import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class CreateEventViewController: UIViewController, UITextFieldDelegate {
    
    // stored variables
    var createAnEvent: [CreateEvent] = []
    var ref: DatabaseReference?
    var facebookID: [Attendees] = []
    
    // outlets and actions
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var locTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    var pulledUserId = UserDefaults.standard
    // for unique event id
    var uniqueID: DatabaseReference?
    // for user id
    var UserId: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the delegate to the text field
        self.timeTextField.delegate = self
        
    }
    
    // create button
    // user will be able to create a custom event
    @IBAction func CreateButton(_ sender: Any) {
        
        if nameTextField.text == ""{
            showAlert((Any).self)
        }else if descTextField.text == ""{
            showAlert((Any).self)
        }else if locTextField.text == ""{
            showAlert((Any).self)
        }else if dateTextField.text == ""{
            showAlert((Any).self)
        }else if timeTextField.text == ""{
            showAlert((Any).self)
        }else{
            // store function
            storeToDatabase()
        }
    }
    
    func storeToDatabase(){
        // set the firebase reference
        ref = Database.database().reference()
        
        // create an unique ID to store each event in the database
        uniqueID = ref?.child("Event").childByAutoId()
       
        // make sure nothing is nil and then set values
        if nameTextField.text != "" {
            uniqueID?.child("Title").setValue(nameTextField.text)
        }
        if descTextField.text != "" {
            uniqueID?.child("Description").setValue(descTextField.text)
        }
        if locTextField.text != "" {
            uniqueID?.child("Location").setValue(locTextField.text)
        }
        if dateTextField.text != "" {
            uniqueID?.child("Date").setValue(dateTextField.text)
        }
        if timeTextField.text != "" {
            uniqueID?.child("Time").setValue(timeTextField.text)
        }
        uniqueID?.child("uniqueID").setValue(uniqueID?.key)
        
     
        // get user uid
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
      
        uniqueID?.child("userId").setValue(uid)
   
        createAnEvent.append(CreateEvent(ieventTitle: nameTextField.text, ieventTime: timeTextField.text, ieventLocation: locTextField.text, ieventDescription: descTextField.text, ieventDate: dateTextField.text, initId: uniqueID?.key, initUserId: UserId?.key))
        
        // perform segue to pass data between controllers
        performSegue(withIdentifier: "CreateToView", sender: self)
    }
    
    //pass data that need to be passed from one controller to the other
    // Segue from Create to Created
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let secController = segue.destination as? CreatedEventsTableViewController
        secController?.myString1 = nameTextField.text!
        secController?.myString2 = timeTextField.text!
        secController?.myString3 = dateTextField.text!
        
    }
    
    // show pop up alert
    func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Attention", message:
            "Please do not leave any fields blank.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
     // Hide keyboard when clicked outside
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     self.view.endEditing(true)
     }
     
     // hide keyboard when user presses the return key
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     timeTextField.resignFirstResponder()
     return true
     }
    
}
