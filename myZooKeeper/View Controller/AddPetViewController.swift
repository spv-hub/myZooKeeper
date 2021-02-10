//
//  AddPetViewController.swift
//  myZooKeeper
//
//  Created by Ada on 2/3/21.
//

import UIKit
import Firebase

class AddPetViewController: UIViewController {
    @IBOutlet weak var NameTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "isSignedIn") {
            return
            
        }
        
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }
    
    
    @IBOutlet weak var speciesTextField: UITextField!
    
    
    @IBAction func SavePet(_ sender: UIButton) {
        
        var ref: DocumentReference? = nil
        ref = Firestore.firestore().collection("pet_profiles").addDocument(data: [
            "name": NameTextField.text!,
            "species": speciesTextField.text!,
            "gender": "Female"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    @IBAction func SavePetButton(_ sender: UIButton) {
        //print("SavePetButton got tapped.")
        var ref: DocumentReference? = nil
        ref = Firestore.firestore().collection("pet_profiles").addDocument(data: [
            "name": NameTextField.text!,
            "species": "dog",
            "gender": "Female"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }


    }
    
   
 
}
