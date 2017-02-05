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
    var mailSubject : String = "CNToolkit Results"
    
    @IBOutlet weak var ButtonOrientation: UIButton!
    @IBOutlet weak var ButtonSimpleMemory: UIButton!
    @IBOutlet weak var ButtonVIsualAssociation: UIButton!
    @IBOutlet weak var ButtonTrails: UIButton!
    @IBOutlet weak var ButtonForwardDigitSpan: UIButton!
    @IBOutlet weak var ButtonBackwardDigitSpan: UIButton!
    @IBOutlet weak var ButtonCatsAndDogs: UIButton!
    @IBOutlet weak var Button3DFigureCopy: UIButton!
    @IBOutlet weak var ButtonnSerialSevens: UIButton!
    @IBOutlet weak var ButtonForwardSpatialSpan: UIButton!
    @IBOutlet weak var ButtonBackwardSpatialSpan: UIButton!
    @IBOutlet weak var ButtonNamingPictures: UIButton!
    @IBOutlet weak var ButtonSemanticListGeneration: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = nil
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        var body:String?
        
        if(emailOn && MFMailComposeViewController.canSendMail()) {
            body = resultsArray.emailBody()
            let picker = MFMailComposeViewController()
            picker.mailComposeDelegate = self
            picker.setSubject(mailSubject)
            picker.setMessageBody(body!, isHTML: true)
            picker.setToRecipients([emailAddress])
            //           MainViewController(picker, animated: true, completion: nil)
            present(picker, animated: true)
        }
        resultsArray.doneWithPatient()
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        screenSize = UIScreen.main.bounds
        
        emailOn = !UserDefaults.standard.bool(forKey: "emailOff")
        if(UserDefaults.standard.object(forKey: "emailAddress") != nil) {
            emailAddress = UserDefaults.standard.object(forKey: "emailAddress") as! String
        }
        
        
        updateButton(button: ButtonOrientation, status: Status[TestOrientation])
        updateButton(button: ButtonSimpleMemory, status: Status[TestSimpleMemory])
        updateButton(button: ButtonVIsualAssociation, status: Status[TestVisualAssociation])
        updateButton(button: ButtonTrails, status: Status[TestTrails])
        updateButton(button: ButtonForwardDigitSpan, status: Status[TestForwardDigitSpan])
        updateButton(button: ButtonBackwardDigitSpan, status: Status[TestBackwardsDigitSpan])
        updateButton(button: ButtonCatsAndDogs, status: Status[TestCatsAndDogs])
        updateButton(button: Button3DFigureCopy, status: Status[Test3DFigureCopy])
        updateButton(button: ButtonnSerialSevens, status: Status[TestSerialSevens])
        updateButton(button: ButtonForwardSpatialSpan, status: Status[TestForwardSpatialSpan])
        updateButton(button: ButtonBackwardSpatialSpan, status: Status[TestBackwardSpatialSpan])
        updateButton(button: ButtonNamingPictures, status: Status[TestNampingPictures])
        updateButton(button: ButtonSemanticListGeneration, status: Status[TestSemanticListGeneration])
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

