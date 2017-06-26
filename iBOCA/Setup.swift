//
//  Setup.swift
//  iBOCA
//
//  Created by saman on 6/25/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

let PID = PatiantID()

var transmitOn : Bool = false
var atBIDMCOn  : Bool = false
var emailOn    : Bool = false
var emailAddress       : String = ""
var serverEmailAddress : String = "saman@mit.edu"

class Setup: UIViewController {

    @IBOutlet weak var transmitOnOff: UISwitch!
    @IBOutlet weak var atBIDMCOnOff:  UISwitch!
    @IBOutlet weak var emailOnOff:    UISwitch!
    @IBOutlet weak var email:         UITextField!
    @IBOutlet weak var emailLabel:    UILabel!
    @IBOutlet weak var adminName:     UITextField!
    @IBOutlet weak var adminInitials: UILabel!
    @IBOutlet weak var patiantID:     UITextField!
    
    
    @IBAction func transmitOnOff(_ sender: UISwitch) {
        transmitOn = transmitOnOff.isOn
        UserDefaults.standard.set(transmitOn, forKey: "Transmit")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func atBIDMCOnOff(_ sender: UISwitch) {
        atBIDMCOn = atBIDMCOnOff.isOn
        UserDefaults.standard.set(atBIDMCOn, forKey: "AtBIDMC")
        UserDefaults.standard.synchronize()
        patiantID.text = PID.getID()
    }
    
    
    @IBAction func emailOnOff(_ sender: Any) {
        emailOn = emailOnOff.isOn
        email.isEnabled = emailOn
        emailLabel.isEnabled = emailOn
        UserDefaults.standard.set(emailOn, forKey: "emailOn")
        UserDefaults.standard.synchronize()
    }
    

    @IBAction func emailChanged(_ sender: Any) {
        emailAddress = email.text!
        UserDefaults.standard.set(emailAddress, forKey:"emailAddress")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func adminNameChanged(_ sender: UITextField) {
        PID.nameSet(name: adminName.text!)
        adminInitials.text = PID.getInitials()
        patiantID.text = PID.getID()
    }
    
    
    @IBAction func patiantIDEdited(_ sender: UITextField) {
        if !PID.changeID(proposed: patiantID.text!) {
            patiantID.text = PID.getID()
        } else {
            patiantID.text = PID.getID()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        transmitOn = UserDefaults.standard.bool(forKey: "Transmit")
        transmitOnOff.isOn = transmitOn
        
        atBIDMCOn = UserDefaults.standard.bool(forKey: "AtBIDMC")
        atBIDMCOnOff.isOn = atBIDMCOn
       
        emailOn = UserDefaults.standard.bool(forKey: "emailOn")
        if(UserDefaults.standard.object(forKey: "emailAddress") != nil) {
            emailAddress = UserDefaults.standard.object(forKey: "emailAddress") as! String
        }
        email.isEnabled = emailOn
        emailLabel.isEnabled = emailOn
        emailOnOff.isOn = emailOn
        email.text = emailAddress
    
        patiantID.text = PID.getID()
        adminName.text = PID.getName()
        adminInitials.text = PID.getInitials()
        
        // Need to figure out how to transmit!
        transmitOnOff.isEnabled = false
  
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
