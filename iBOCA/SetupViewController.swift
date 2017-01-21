//
//  SetupViewController.swift
//  iBOCA
//
//  Created by saman on 1/3/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

import UIKit

var emailOn  : Bool = false
var emailAddress : String = ""


class SetupViewController: ViewController{

    @IBOutlet weak var emailOnOff: UISwitch!
    @IBOutlet weak var email: UITextField!
    
    
    @IBAction func emailOnOff(_ sender: Any) {
        emailOn = emailOnOff.isOn
        
        email.isEnabled = emailOn
        UserDefaults.standard.set(!emailOn, forKey: "emailOff")
        UserDefaults.standard.synchronize()

    }
    
    @IBAction func emailChanged(_ sender: Any) {
        emailAddress = email.text!
        UserDefaults.standard.set(emailAddress, forKey:"emailAddress")
        UserDefaults.standard.synchronize()
    }
    
    

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
        
        
        email.isEnabled = emailOn
        emailOnOff.isOn = emailOn
        email.text = emailAddress
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

