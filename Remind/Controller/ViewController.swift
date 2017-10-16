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
    }
    
    @IBAction func timerButtonPressed(_ sender: UIButton) {
        print("timer")
    }
    
    @IBAction func dateButtonPressed(_ sender: UIButton) {
        print("date")
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        print("location")
    }
}

