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

class CreateEventViewController: UIViewController, UITextFieldDelegate {
    
    // stored variables
    var createAnEvent: [CreateEvent] = []
    var ref: DatabaseReference?

    // outlets and actions
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var locTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the delegate to the text field
        self.timeTextField.delegate = self
        
    }
    
    // create button
    // user will be able to create a custom event
    @IBAction func CreateButton(_ sender: Any) {
        // set the firebase reference
        ref = Database.database().reference()
        
        // create an unique ID to store each event in the database
        let uniqueID = ref?.child("Event").childByAutoId()
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
        else{
            // need to create an alert pop up message here.
            print("Empty")
        }
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
 
    // Hide keyboard when clicked outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // hide keyboard when user presses the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        timeTextField.resignFirstResponder()
        return true
    }

    
    
    
    
    
    
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? CreatedEventsTableViewController {
            dvc.eventData[0] = createAnEvent[tableView.indexPathForSelectedRow!.row]
        }
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
