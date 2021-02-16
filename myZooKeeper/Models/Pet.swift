//
//  Pet.swift
//  myZooKeeper
//
//  Created by Sandy Vasquez on 2/11/21.
//

import Foundation
import  Firebase

class Pet {
    var petName: String
    var petWeight: String
    var petImageUrl: String
    
    init() {
        petName = ""
        petWeight = ""
        petImageUrl = ""
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        petName = snapshot.data()["name"] as? String ?? "name"
        petWeight = snapshot.data()["weight"] as! String
        petImageUrl = snapshot.data()["petImageUrl"] as! String
    }
}
