//
//  ProfileViewController.swift
//  iHobby_Portfolio4
//
//  Created by Prajwal Ramamurthy on 5/10/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseDatabase

var global_UserID:String? //using a global uid to help me search through my database
// Profile Page Controller
class ProfileViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var userIDTest: [Attendees] = []
    var ver:VerificationViewController?
    // create the outlets for the labels
    @IBOutlet weak var emailLabel: UILabel?
    @IBOutlet weak var phoneNumberLabel: UILabel?
    @IBOutlet weak var cityLabel: UILabel?
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var image: UIImageView?
    @IBOutlet weak var verifyButton: UIButton?
    
   // let defaults: UserDefaults
    // Start of the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // making my UIImage a circle for asthetics
        image?.layer.cornerRadius = (image?.frame.size.width)!/2
        image?.clipsToBounds = true
        verifyButton?.backgroundColor = UIColor.red
        
        // calling my function that get user details from facebook SDK
        getFacebookUserInfo()
        
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
  
    @IBAction func unwindToVC2(segue:UIStoryboardSegue) { }
    
    @IBAction func BackButton(_ sender: Any) {
        // perform segue
        // identifier "ProfileToHome"
    }
    // Verify Button
    @IBAction func VerificationButton(_ sender: Any) {
    }
    
    // Custom function to get data
    func getFacebookUserInfo() {
        if(FBSDKAccessToken.current() != nil)
        {
            //print permissions, such as public_profile
            print(FBSDKAccessToken.current().permissions)
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
            
            // let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            // request a connection
            let connection = FBSDKGraphRequestConnection()
            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
                
                let data = result as! [String : AnyObject]
                
                // assign the labels
                self.userNameLabel?.text = data["name"] as? String
                self.emailLabel?.text = data["email"] as? String
                
                let FBid = data["id"] as? String
                
                let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1")
                self.image?.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
                print(data)
                
                var ref: DatabaseReference?
                // set the firebase reference
                ref = Database.database().reference()
                
                let uniqueID = ref?.child("Profile").childByAutoId()
                
                if self.userNameLabel?.text != "" {
                    uniqueID?.child("Name").setValue(self.userNameLabel?.text)
                }
                if self.emailLabel?.text != "" {
                    uniqueID?.child("Email").setValue(self.emailLabel?.text)
                }
                uniqueID?.child("ID").setValue(FBid)
                
                global_UserID = FBid
                
                self.userIDTest.append(Attendees(InitID: FBid))
    
                
            })
            connection.start()
            print()
        }
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        verifyButton?.backgroundColor? = UIColor.green
        verifyButton?.setTitle("VERIFIED", for: .normal)
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        image?.image = UIImage(named: "fb-art.jpg")
    }

}
