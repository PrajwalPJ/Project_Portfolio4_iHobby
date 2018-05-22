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

   // let pro = ProfileViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "GreenVerify", sender: self)
        
        // Do any additional setup after loading the view.
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
        if IDImaageView != nil {
            performSegue(withIdentifier: "verToPro", sender: self)
            
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                let pro = segue.destination as? ProfileViewController
                pro?.verifyButton?.backgroundColor? = UIColor.green
                if IDImaageView?.image != nil{
                    pro?.verifyButton?.backgroundColor = UIColor.green
                }else{
                    pro?.verifyButton?.backgroundColor = UIColor.red
                }
            }
            
        }else{
            showAlert((Any).self)
        }
    }
    
    func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "iOScreator", message:
            "Hello, world!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            IDImaageView?.image = image
        }else{
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
