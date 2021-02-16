//
//  EntryViewController.swift
//  myZooKeeper
//
//  Created by Ada on 2/16/21.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var field: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    @IBAction func saveTask() {
        
    }

}
