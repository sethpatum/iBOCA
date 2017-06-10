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



class MainViewController: UIViewController, MFMailComposeViewControllerDelegate{
    var mailSubject : String = "iBOCA Results"
    
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = nil
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        var body:String?
        
        if(emailOn && MFMailComposeViewController.canSendMail()  && resultsArray.numResults() > 0) {
            body = resultsArray.emailBody()
            let picker = MFMailComposeViewController()
            picker.mailComposeDelegate = self
            picker.setSubject(mailSubject)
            picker.setMessageBody(body!, isHTML: true)
            picker.setToRecipients([emailAddress])
            present(picker, animated: true)
        }
        resultsArray.doneWithPatient()
        self.performSegue(withIdentifier: "BackToLanding", sender: self)
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        segueToLanding = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        screenSize = UIScreen.main.bounds
        
        emailOn = !UserDefaults.standard.bool(forKey: "emailOff")
        if(UserDefaults.standard.object(forKey: "emailAddress") != nil) {
            emailAddress = UserDefaults.standard.object(forKey: "emailAddress") as! String
        }
        
        LabelSM.isHidden = true
        LabelVA.isHidden = true
        
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

