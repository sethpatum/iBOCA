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
var serverEmailAddress : String = "datacollect@bostoncognitive.org"
var theTestClass : Int = 0
let testClassName = ["CNU", "COMM", "ECT", "DW", "PHY", "ICU", "B1", "B2", "B3", "TEST"]
let BIDMCpassKey = "PressOn"

class Setup: ViewController, UIPickerViewDelegate  {

    @IBOutlet weak var transmitOnOff: UISwitch!
    @IBOutlet weak var atBIDMCOnOff:  UISwitch!
    @IBOutlet weak var emailOnOff:    UISwitch!
    @IBOutlet weak var email:         UITextField!
    @IBOutlet weak var emailLabel:    UILabel!
    @IBOutlet weak var adminName:     UITextField!
    @IBOutlet weak var adminInitials: UILabel!
    @IBOutlet weak var patiantID:     UITextField!
    
    @IBOutlet weak var testClass: UIPickerView!
    @IBOutlet weak var testClassLabel: UILabel!
    
    @IBAction func transmitOnOff(_ sender: UISwitch) {
        transmitOn = transmitOnOff.isOn
        UserDefaults.standard.set(transmitOn, forKey: "Transmit")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func atBIDMCOnOff(_ sender: UISwitch) {
        if(atBIDMCOnOff.isOn) { // Trying to use BIDMC content
            if(UserDefaults.standard.object(forKey: "BIDMCproceedKey") == nil) { // See if the person has permission
                // Ask for the key pharse
                let alertController = UIAlertController(title: "Enter passkey", message: "Enter Pass Key to use BIDMC Features", preferredStyle: .alert)
                
                //the confirm action taking the inputs
                let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
                    //getting the input values from user
                    let key = alertController.textFields?[0].text
                    if (key == BIDMCpassKey) { // Got the right key
                        UserDefaults.standard.set(key, forKey: "BIDMCproceedKey")
                        UserDefaults.standard.synchronize()
                        self.setAtBIDMC()
                    } else { // bad key
                        self.atBIDMCOnOff.isOn = false
                    }
                }
                
                //the cancel action, no key
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
                     self.atBIDMCOnOff.isOn = false
                }
                
                //adding textfields to our dialog box
                alertController.addTextField { (textField) in
                    textField.placeholder = "Enter Pass Key"
                }
                //adding the action to dialogbox
                alertController.addAction(confirmAction)
                alertController.addAction(cancelAction)
                
                //finally presenting the dialog box
                self.present(alertController, animated: true, completion: nil)
            } else { // key exist in the system, should be OK
            setAtBIDMC()
            }
        } else { // trying to set it off, should be OK
            setAtBIDMC()
        }
    }
    
    func setAtBIDMC() {
        atBIDMCOn = atBIDMCOnOff.isOn
        UserDefaults.standard.set(atBIDMCOn, forKey: "AtBIDMC")
        UserDefaults.standard.synchronize()
        patiantID.text = PID.getID()
        if atBIDMCOn == true {
            testClass.isHidden = false
            testClassLabel.isHidden = false
        } else {
            testClass.isHidden = true
            testClassLabel.isHidden = true
        }
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
        
        testClass.delegate = self
        if atBIDMCOn == true {
            testClass.isHidden = false
            testClassLabel.isHidden = false
        } else {
            testClass.isHidden = true
            testClassLabel.isHidden = true
        }
        theTestClass = UserDefaults.standard.integer(forKey: "TheTestClass")
        testClass.selectRow(theTestClass, inComponent: 0, animated: true)
        
        doneSetup = true
    }
    
    func numberOfComponentsInPickerView(_ pickerView : UIPickerView!) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == testClass {
            return testClassName.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == testClass {
            return testClassName[row]
        } else {
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == testClass {
            theTestClass = row
            UserDefaults.standard.set(row, forKey:"TheTestClass")
        } else  {
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
