//
//  ViewController.swift
//  MultiStateSwitch
//
//  Created by sarawanakumar on 07/25/2017.
//  Copyright (c) 2017 sarawanakumar. All rights reserved.
//

import UIKit
import MultiStateSwitch

class ViewController: UIViewController {
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateSwitch: MultiStateSwitch!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let imgs = [UIImage(named: "home")!, UIImage(named: "away")!, UIImage(named: "sleep")!, UIImage(named: "off")!]
        stateSwitch.stateImages = imgs
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func switchStateChanged(_ sender: MultiStateSwitch) {
        switch sender.currentIndex {
        case 0:
            stateLabel.text = "Home"
        case 1:
            stateLabel.text = "Away"
        case 2:
            stateLabel.text = "Sleep"
        case 3:
            stateLabel.text = "Powered Off"
        default:
            ()
        }
    }
    
    @IBAction func switchButtonTapped(_ sender: Any) {
        stateSwitch.currentIndex = (stateSwitch.currentIndex + 1) % 4
    }
    
    
}

