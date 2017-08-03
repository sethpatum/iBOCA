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

    @IBOutlet weak var versionLabel: UILabel!
    
    @IBAction func BCSbutton(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "http://www.bostoncognitive.org")! as URL)
    }
    
    @IBAction func CNBSbutton(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "http://tmslab.org/")! as URL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //declare pickerviews
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        versionLabel.text = "Version " + version! + " (build " + build! + ")"
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
