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
}











