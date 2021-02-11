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
    
    
    @IBOutlet weak var weightTextField: UITextField!
    
    
    
    @IBAction func SavePet(_ sender: UIButton) {
        
        var ref: DocumentReference? = nil
        let uid = Auth.auth().currentUser!.uid
        ref = Firestore.firestore().collection("pet_profiles").addDocument(data: [
            "name": NameTextField.text!,
            "weight": weightTextField.text!,
            "userId": uid
        
           
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
}
//call for retrieving docs from firestore
//associate id for document associate it with user

//tableview setup where data comes from
//store current user ID
// db.collection("cities").whereField("capital", isEqualTo: true)
//.getDocuments() { (querySnapshot, err) in
//    if let err = err {
//        print("Error getting documents: \(err)")
//    } else {
//        for document in querySnapshot!.documents {
//            print("\(document.documentID) => \(document.data())")
//        }
//    }
//}
