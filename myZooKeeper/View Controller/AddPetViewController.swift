//
//  AddPetViewController.swift
//  myZooKeeper
//
//  Created by Ada on 2/3/21.
//

import UIKit
import Firebase
import FirebaseStorage



class AddPetViewController: UIViewController {
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petSelectionButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var selectedPetImage = UIImage()
    
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
    
    
    
    
    @IBAction func SavePet(_ sender: UIButton) {
        
        uploadImage(image: selectedPetImage) { [self] (url) in
            if url != nil {
                var ref: DocumentReference? = nil
                let uid = Auth.auth().currentUser!.uid
                ref = Firestore.firestore().collection("pet_profiles").addDocument(data: [
                    "name": self.NameTextField.text!,
                    "weight": self.weightTextField.text!,
                    "userId": uid,
                    "petImageUrl": url!.absoluteString
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }
            } else {
                print("Image upload error!")
            }
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        } else {
            print("Camera source is not available.")
        }
    }
    
    func openGallery() {
        self.imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func petSelectionButtonTap(sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Take using Camera", style: .default) { (action) in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Choose from Photo Library", style: .default) { (action) in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func uploadImage(image: UIImage, completion: @escaping ((_ url: URL?) -> ())) {
        let storageRef = Storage.storage().reference().child("petImages").child("\(Auth.auth().currentUser!.uid)").child("\(UUID().uuidString).png")
        let imageData = image.jpegData(compressionQuality: 0.1)

        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        storageRef.putData(imageData!, metadata: metadata) { (url, error) in
            if error == nil {
                storageRef.downloadURL { (url, error) in
                    if error == nil {
                        completion(url)
                    } else {
                        completion(nil)
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
    
}

extension AddPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        petImageView.image = image
        selectedPetImage = image!
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
