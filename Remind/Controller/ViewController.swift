//
//  ViewController.swift
//  Remind
//
//  Created by Stanley Pan on 17/10/2017.
//  Copyright © 2017 Stanley Pan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNService.sharedInstance.authorize()
        CLService.sharedInstance.authorize()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterRegion), name: NSNotification.Name("internalNotification.enteredRegion"), object: nil)
        //  internalNotification.handleAction
        NotificationCenter.default.addObserver(self, selector: #selector(handleAction(_:)), name: NSNotification.Name("internalNotification.handleAction"), object: nil)
    }
    
    @IBAction func timerButtonPressed(_ sender: UIButton) {
        print("timer")
        AlertService.actionSheet(in: self, title: "5 seconds") {
            UNService.sharedInstance.timerRequest(with: 5.0)
        }
    }
    
    @IBAction func dateButtonPressed(_ sender: UIButton) {
        print("date")
        AlertService.actionSheet(in: self, title: "Some future time") {
            var components = DateComponents()
            components.second = 0
            //        components.weekday = 4
            
            UNService.sharedInstance.dateRequest(with: components)
        }
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        print("location")
        AlertService.actionSheet(in: self, title: "When I return") {
            CLService.sharedInstance.updateLocation()
        }
    }
    
    @objc func didEnterRegion() {
        UNService.sharedInstance.locationRequest()
    }
    
    @objc func handleAction(_ sender: Notification) {
        guard let action = sender.object as? NotificationActionId else { return }
        
        switch action {
        case .timer:
            print("We will implement timer action in response to user press")
        case .date:
            print("We will implement date action in response to user press")
        case .location:
            print("We will implement location action in response to user press")
        }
    }
}











