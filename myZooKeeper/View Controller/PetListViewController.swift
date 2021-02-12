//
//  PetListViewController.swift
//  myZooKeeper
//
//  Created by Sandy Vasquez on 2/11/21.
//

import UIKit
import Firebase

class PetListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var petList = [Pet]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchPetList()
    }
    
    func fetchPetList() {
        Firestore.firestore().collection("pet_profiles").getDocuments { (snapshot, error) in
            if error != nil {
                print("Error fetching pet list!")
            } else {
                guard let documentSnapshot = snapshot, !documentSnapshot.isEmpty else {
                    print("Error fetching pet list! May be empty list.")
                    return
                }
                
                let petDocuments = documentSnapshot.documents
                
                for document in petDocuments {
                    let pet = Pet(snapshot: document)
                    self.petList.append(pet)
                }
                
                self.tableView.reloadData()
                
            }
        }
    }
}

extension PetListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PetCardCell") as! PetCardCell
        cell.petName.text = petList[indexPath.row].petName
        cell.petWeight.text = petList[indexPath.row].petWeight
        if let data =  try? Data(contentsOf: URL(string: petList[indexPath.row].petImageUrl)!) {
            cell.petView.image = UIImage(data: data)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270.0
    }
    
}
