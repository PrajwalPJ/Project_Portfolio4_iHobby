//
//  EditProfileViewController.swift
//  iHobby_Portfolio4
//
//  Created by Prajwal Ramamurthy on 5/23/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var mobileNumberField: UITextField!
    
    
    var phoneNum: String?
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate? = self
        mobileNumberField.delegate? = self
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        
        emailField.text = email
        mobileNumberField.text = phoneNum
        
        performSegue(withIdentifier: "unwindToProfile", sender: self)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        emailField.text = email
        mobileNumberField.text = phoneNum
        
        let secController = segue.destination as? ProfileViewController
        secController?.emailLabel?.text = email
        secController?.phoneNumberLabel?.text = phoneNum
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mobileNumberField.resignFirstResponder()
        emailField.resignFirstResponder()
    }
    
    
    
}

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
