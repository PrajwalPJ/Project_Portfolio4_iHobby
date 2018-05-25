//
//  ViewController.swift
//  iHobby_Portfolio4
//
//  Created by Prajwal Ramamurthy on 5/9/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

// The facebook Login View Controller
class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var profileInfo: [Profile] = []
    
    // create oulets
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Facebook login button integration
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        // Set the frame and size for the button
        loginButton.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: 28)
        
        loginButton.delegate = self
        // get permissions from facebook for the information we need
        loginButton.readPermissions = ["email", "public_profile"]
        // Call the function we created to pull data from facebook SDK
        getFacebookUserInfo()
        
        
    }
    
    // logout button
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("loginButtonDidLogOut")
        imageView?.image = UIImage(named: "fb-art.jpg")
        nameLabel.text = "Not Logged In"
    }
    
    // login button
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
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
                
                // assign the values
                let data = result as! [String : AnyObject]
                self.nameLabel.text = data["name"] as? String
                let FBid = data["id"] as? String
                // Get the url for the profile picture
                let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1")
                self.imageView?.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
                // to test print the data to console
                print(data)
                
                guard let accessToken = FBSDKAccessToken.current() else {
                    print("Failed to get access token")
                    return
                }
                
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                
                // Perform login by calling Firebase APIs
                Auth.auth().signIn(with: credential, completion: { (user, error) in
                    if let error = error {
                        print("Login error: \(error.localizedDescription)")
                        let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(okayAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        return
                    }
                    
                    // Present the main view
                    print("Logged in with Facebook")
                    
                    if let id = user?.uid, let email = user?.email,let username = user?.displayName, let photo_url = user?.photoURL?.absoluteString {
                        
                        let ref = Database.database().reference().child("users")
                        ref.queryOrdered(byChild:"email").queryEqual(toValue: email).observe(.value, with: { (snapshot) in
                            
                            if (snapshot.value is NSNull) {
                                //print("not found")
                                var ref: DatabaseReference?
                                // set the firebase reference
                                ref = Database.database().reference()
                                
                                let uniqueID = ref?.child("Profile").childByAutoId()
                                uniqueID?.child("Name").setValue(username)
                                uniqueID?.child("Email").setValue(email)
                                uniqueID?.child("Image").setValue(photo_url)
                                
                            } else {
                                
                            }
                        })
                    }
                })
                
            })
            connection.start()
            print()
        }
    }
    
    
    
    // custom function to request data from facebook SDK
    func getFacebookUserInfoOld() {
        if(FBSDKAccessToken.current() != nil)
        {
            //print permissions, such as public_profile
            print(FBSDKAccessToken.current().permissions)
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
            // create a connection
            let connection = FBSDKGraphRequestConnection()
            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
                
                // assign the values
                let data = result as! [String : AnyObject]
                self.nameLabel.text = data["name"] as? String
                let FBid = data["id"] as? String
                // Get the url for the profile picture
                let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1")
                self.imageView?.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
                // to test print the data to console
                print(data)
            })
            // start the connection
            connection.start()
        }
    }
}
