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
var screenSize : CGRect?

var testName:String?

class MainViewController: UIViewController, MFMailComposeViewControllerDelegate{
    var mailSubject : String = "iBOCA Results of "
    
    
    var segueToLanding = false // COmplete hack to get back to landing page.  The timer will keep issuing segue command if this variable is set. Deals with the asynchronous mail window (need to find a better way!)
    
    @IBOutlet weak var ButtonOrientation: UIButton!
    @IBOutlet weak var ButtonSimpleMemory: UIButton!
    @IBOutlet weak var ButtonVisualAssociation: UIButton!
    @IBOutlet weak var ButtonTrails: UIButton!
    @IBOutlet weak var ButtonForwardDigitSpan: UIButton!
    @IBOutlet weak var ButtonBackwardDigitSpan: UIButton!
    @IBOutlet weak var ButtonCatsAndDogs: UIButton!
    @IBOutlet weak var Button3DFigureCopy: UIButton!
    @IBOutlet weak var ButtonSerialSevens: UIButton!
    @IBOutlet weak var ButtonForwardSpatialSpan: UIButton!
    @IBOutlet weak var ButtonBackwardSpatialSpan: UIButton!
    @IBOutlet weak var ButtonNamingPictures: UIButton!
    @IBOutlet weak var ButtonSemanticListGeneration: UIButton!
    
    @IBOutlet weak var LabelSM: UILabel!
    @IBOutlet weak var LabelVA: UILabel!
    
    @IBOutlet weak var PatiantID: UILabel!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = nil
        testName = segue.identifier
    }
    
    var doSecondEmail = false
    
    @IBAction func sendEmail(_ sender: Any) {
        var body:String?
        
        if(MFMailComposeViewController.canSendMail()  && resultsArray.numResults() > 0) {
            if(emailOn) {
                // send the e-mail
                body = resultsArray.emailBody()
                sendEmail(body: body!, address: [emailAddress])
                if(transmitOn) {
                    // queue the 2nd e-mail to server
                    doSecondEmail = true
                }
            } else if(transmitOn) {
                // email to server
                sendEmail(body: "", address: [serverEmailAddress])
            } else {
                // nothing to send
                resultsArray.doneWithPatient()
                segueToLanding = true
            }
        } else {
            // nothing to send
            resultsArray.doneWithPatient()
            segueToLanding = true
        }
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
  
        controller.dismiss(animated: true)
        
        if doSecondEmail {
            doSecondEmail = false
            // TransmitOn is why we are here
            if(emailOn && MFMailComposeViewController.canSendMail()  && resultsArray.numResults() > 0) {
                sendEmail(body: "", address: [serverEmailAddress])
            }
        } else {
            // all e-mail sent
            resultsArray.doneWithPatient()
            PID.incID()
            segueToLanding = true
        }
    }
    
    func sendEmail(body: String, address: [String]) {
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        picker.setSubject(mailSubject + PID.getID())
        picker.setMessageBody(body, isHTML: true)
        picker.setToRecipients(address)
        let data = encryptString(str: resultsArray.toJson())
        picker.addAttachmentData(data, mimeType: "text/plain", fileName: "Encrypted-JSON")
        present(picker, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        screenSize = UIScreen.main.bounds
        
        emailOn = UserDefaults.standard.bool(forKey: "emailOn")
        if(UserDefaults.standard.object(forKey: "emailAddress") != nil) {
            emailAddress = UserDefaults.standard.object(forKey: "emailAddress") as! String
        }
        
        LabelSM.isHidden = true
        LabelVA.isHidden = true
        PatiantID.text = PID.getID()
        
        updateButton(button: ButtonOrientation, status: Status[TestOrientation])
        updateButton(button: ButtonSimpleMemory, status: Status[TestSimpleMemory])
        updateButton(button: ButtonVisualAssociation, status: Status[TestVisualAssociation])
        updateButton(button: ButtonTrails, status: Status[TestTrails])
        updateButton(button: ButtonForwardDigitSpan, status: Status[TestForwardDigitSpan])
        updateButton(button: ButtonBackwardDigitSpan, status: Status[TestBackwardsDigitSpan])
        updateButton(button: ButtonCatsAndDogs, status: Status[TestCatsAndDogs])
        updateButton(button: Button3DFigureCopy, status: Status[Test3DFigureCopy])
        updateButton(button: ButtonSerialSevens, status: Status[TestSerialSevens])
        updateButton(button: ButtonForwardSpatialSpan, status: Status[TestForwardSpatialSpan])
        updateButton(button: ButtonBackwardSpatialSpan, status: Status[TestBackwardSpatialSpan])
        updateButton(button: ButtonNamingPictures, status: Status[TestNampingPictures])
        updateButton(button: ButtonSemanticListGeneration, status: Status[TestSemanticListGeneration])
        
        segueToLanding = false
        var timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(update(timer:)), userInfo: nil, repeats: true)
    }
    
    
    func updateButton(button: UIButton, status : TestStatus) {
        switch(status) {
        case .NotStarted:
            button.tintColor = UIColor.blue
            break
            
        case .Running:
            button.tintColor = UIColor.red
            break
            
        case .Done:
            button.tintColor = UIColor.darkGray
            break
        }
        
    }
    
    func update(timer: Timer) {
        if segueToLanding == true { // The HACK!
            self.performSegue(withIdentifier: "BackToLanding", sender: self)
        }
        
        if Status[TestSimpleMemory] == TestStatus.Running {
            LabelSM.isHidden = false
            LabelSM.text = getTimeDelay(startTime: startTimeSM)
        
        } else {
            LabelSM.isHidden = true
        }
        
        
        if Status[TestVisualAssociation] == TestStatus.Running {
            LabelVA.isHidden = false
            LabelVA.text = getTimeDelay(startTime: startTimeVA)
            
        } else {
            LabelVA.isHidden = true
        }
    }
    
    
    func getTimeDelay(startTime:TimeInterval) -> String {
        
        let currTime = NSDate.timeIntervalSinceReferenceDate
        var diff: TimeInterval = currTime - startTime
        
        if diff > 15000 {  // Hack to prevent overflow at the begining
            return ""
        }
        
        let minutes = UInt8(diff / 60.0)
        
        diff -= (TimeInterval(minutes)*60.0)
        
        let seconds = UInt8(diff)
        
        diff = TimeInterval(seconds)
        
        let strMinutes = minutes > 9 ? String(minutes):"0"+String(minutes)
        let strSeconds = seconds > 9 ? String(seconds):"0"+String(seconds)
        
       return "(\(strMinutes) : \(strSeconds))"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

