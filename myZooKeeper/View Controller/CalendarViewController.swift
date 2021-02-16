//
//  CalendarViewController.swift
//  myZooKeeper
//
//  Created by Sandy Vasquez on 2/16/21.
//

import UIKit
import EventKitUI


class CalendarViewController: UIViewController, EKEventEditViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        self.dismiss(animated: true)

        <#code#>
    }


    


}
