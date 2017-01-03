//
//  ViewController.swift
//  iBOCA
//
//  Created by Seth Amarasinghe on 8/1/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        emailOn = !UserDefaults.standard.bool(forKey: "emailOff")
        if(UserDefaults.standard.object(forKey: "emailAddress") != nil) {
            emailAddress = UserDefaults.standard.object(forKey: "emailAddress") as! String
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

