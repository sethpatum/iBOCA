//
//  LandingPage.swift
//  iBOCA
//
//  Created by saman on 6/27/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation
import UIKit


class LandingPage: UIViewController {
    
    @IBOutlet weak var GotoTests: UIButton!
    
    @IBAction func GotoTests(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if atBIDMCOn {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "main")
            self.present(nextViewController, animated:true, completion:nil)
        } else {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Demographics")
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
