//
//  VerificationViewController.swift
//  iHobby_Portfolio4
//
//  Created by Prajwal Ramamurthy on 5/10/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit

// verify user by uploading their ID
class VerificationViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var colorForButtonBackground: UIColor = UIColor.green
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // outlets and ibactions
    @IBOutlet weak var IDImaageView: UIImageView?
    @IBAction func UploadButton(_ sender: Any) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){
            
        }
    }
    
    @IBAction func VerifyButton(_ sender: Any) {
        if IDImaageView?.image != nil {
           
         performSegue(withIdentifier: "verToPro", sender: self)
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let pro = segue.destination as? ProfileViewController
            pro?.verifyButton?.backgroundColor? = UIColor.green
            }}else
            {
                    self.showAlert((Any).self)
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pro = segue.destination as? ProfileViewController
        pro?.verifyButton?.backgroundColor? = UIColor.green
        pro?.verifyButton?.setTitle("VERIFIED", for: .normal)
        
    }
    

    // pop up alert function
    func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Attention", message:
            "Please Upload an ID to verify account!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // pick an image to upload
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            IDImaageView?.image = image
        }else{
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
