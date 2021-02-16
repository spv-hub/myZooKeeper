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
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get all current saved tasks
        let vc = storyboard?.instantiateViewController(identifier:"entry") as! EntryViewController
        vc.title = "New Task"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapAdd() {
        //show another view controller to make an entry
        
    }

}

extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

extension TasksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}

