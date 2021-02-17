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

    }


    @IBAction func eventButton(_ sender: Any) {
        let eventStore = EKEventStore()
        print("text")
        
        switch EKEventStore.authorizationStatus(for: .event) {
            case .authorized:
                openEventUI(eventStore)
            case .denied, .restricted:
                    print("Access denied")
            case .notDetermined:
                    eventStore.requestAccess(to: .event) { (granted, error) in
                        if granted {
                            DispatchQueue.main.async {
                                self.openEventUI(eventStore)
                            }
                              } else {
                                print("Access denied")
                              }
                        }
                   
                   default:
                       print("nothing here")
                    
        }
    }
    
    func openEventUI(_ store: EKEventStore) {
        let eventModalVC = EKEventEditViewController()
        
        let event = EKEvent(eventStore: store)
      
        let startDate = Date()
              
        let endDate = startDate.addingTimeInterval(60 * 120)
              
        event.calendar = store.defaultCalendarForNewEvents
                                 
        event.title = "Sample Meeting"
        event.startDate = startDate
        event.endDate = endDate
                          
        event.addAlarm( EKAlarm(relativeOffset: -60.0 * 15) )
              
        eventModalVC.event = event
        
      
        eventModalVC.eventStore = store
        eventModalVC.editViewDelegate = self
      
        self.present(eventModalVC, animated: true)
        
    }
}
