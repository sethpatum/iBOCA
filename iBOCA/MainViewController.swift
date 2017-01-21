//
//  MainViewController.swift
//  iBOCA
//
//  Created by saman on 1/21/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

import UIKit
import MessageUI

class MainViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    var mailSubject : String = "CNToolkit Results"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = nil
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        var body:String?
        
        if(emailOn) {
            body = resultsArray.emailBody()
            let picker = MFMailComposeViewController()
            picker.mailComposeDelegate = self
            picker.setSubject(mailSubject)
            picker.setMessageBody(body!, isHTML: true)
            picker.setToRecipients([emailAddress])
            //           MainViewController(picker, animated: true, completion: nil)
        }
        resultsArray.doneWithPatient()
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

