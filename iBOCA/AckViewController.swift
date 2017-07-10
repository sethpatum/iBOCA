//
//  AckViewController.swift
//  iBOCA
//
//  Created by saman on 7/10/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation
import UIKit


class AckViewController:  ViewController {

    
    @IBAction func BCSbutton(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "http://www.bostoncognitive.org")! as URL)
    }
    
    @IBAction func CNBSbutton(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "http://tmslab.org/")! as URL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //declare pickerviews
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
