//
//  TasksViewController.swift
//  myZooKeeper
//
//  Created by Ada on 2/16/21.
//

import UIKit
import Firebase
import FirebaseFirestore



class TasksViewController: UIViewController {
    
    
   
    
    
    @IBOutlet weak var tasklist: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

extension TasksViewController: UITableViewDataSource {
    
}

