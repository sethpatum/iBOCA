//
//  DigitBase.swift
//  iBOCA
//
//  Created by saman on 6/10/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

import UIKit
import AVFoundation

class DigitBase: ViewController {
    var base:DigitBaseClass? = nil  // Cannot do a subclass, so using composition

    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var EndButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet weak var Button_1: UIButton!
    @IBOutlet weak var Button_2: UIButton!
    @IBOutlet weak var Button_3: UIButton!
    @IBOutlet weak var Button_4: UIButton!
    @IBOutlet weak var Button_5: UIButton!
    @IBOutlet weak var Button_6: UIButton!
    @IBOutlet weak var Button_7: UIButton!
    @IBOutlet weak var Button_8: UIButton!
    @IBOutlet weak var Button_9: UIButton!
    @IBOutlet weak var Button_0: UIButton!
    @IBOutlet weak var Button_done: UIButton!
    @IBOutlet weak var Button_delete: UIButton!
    
    var NumKeys:[UIButton] = []
    
    @IBOutlet weak var NumberLabel: UILabel!
    @IBOutlet weak var KeypadLabel: UILabel!
    @IBOutlet weak var InfoLabel: UILabel!
    
    var value:String = ""
    
    var ended = false
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dispatch according to incoming
        if testName == "ForwardDigitSpan" {
            base = DigitSpanForward()
        } else if testName == "BackwardDigitSpan" {
            base = DigitSpanBackward()
        } else if testName == "SerialSeven" {
            base = DigitSerialSeven()
        } else {
            assert(true, "Error, got here with wrong name")
        }
        base!.base = self
        
        
        NumKeys.append(Button_1)
        NumKeys.append(Button_2)
        NumKeys.append(Button_3)
        NumKeys.append(Button_4)
        NumKeys.append(Button_5)
        NumKeys.append(Button_6)
        NumKeys.append(Button_7)
        NumKeys.append(Button_8)
        NumKeys.append(Button_9)
        NumKeys.append(Button_0)
        NumKeys.append(Button_done)
        NumKeys.append(Button_delete)
        
        value = ""
        InfoLabel.text = ""
        NumberLabel.text = ""
        KeypadLabel.text = ""
        
        StartButton.isHidden = false
        EndButton.isHidden = true
        BackButton.isHidden = false
        
        base!.DoInitialize()
    }
    
    func enableKeypad() {
        for key in NumKeys {
            key.isHidden = false
            key.isEnabled = true
        }
    }
    
    func disableKeypad() {
        for key in NumKeys {
            key.isEnabled = false
        }
    }
    
    func hideKeypad() {
        for key in NumKeys {
            key.isEnabled = false
            key.isHidden = true
        }
    }
    
    @IBAction func KeyPadKeyPressed(_ sender: UIButton) {
        value = value + sender.currentTitle!
        KeypadLabel.text = value
        let elapsedTime = (Int)(1000*Foundation.Date().timeIntervalSince(base!.levelStartTime))
        base!.gotKeys[(String)(elapsedTime)] = sender.currentTitle!
    }
    
    @IBAction func DoneKeyPressed(_ sender: UIButton) {
        let elapsedTime = (Int)(1000*Foundation.Date().timeIntervalSince(base!.levelStartTime))
        base!.gotKeys[(String)(elapsedTime)] = "done"

        base!.DoEnterDone()
    }
    
    @IBAction func DeleteKeyPressed(_ sender: UIButton) {
        value = String(value.characters.dropLast())
        KeypadLabel.text = value
        let elapsedTime = (Int)(1000*Foundation.Date().timeIntervalSince(base!.levelStartTime))
        base!.gotKeys[(String)(elapsedTime)] = "del"
    }
    
    
    @IBAction func StartPressed(_ sender: UIButton) {
        ended = false
        StartButton.isHidden = true
        EndButton.isHidden = false
        BackButton.isHidden = true
        base!.DoStart()
    }
    
    @IBAction func EndPressed(_ sender: UIButton) {
        base!.DoEnd()
    }
    
    // This may be call more than when EndPressed, DoEnd may be call within the subclass, which should call this
    func EndTest() {
        ended = true
        value = ""
        NumberLabel.text = ""
        KeypadLabel.text = ""

        disableKeypad()
        StartButton.isHidden = false
        EndButton.isHidden = true
        BackButton.isHidden = false
    }
    
    func DisplayStringShowContinue(val:String) {
        if BackButton.isHidden == true {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                if val.characters.count == 0 {
                    //self.ContinueButton.isHidden = false
                    self.InfoLabel.text = "Start entering the number sequence given by patient, followed by done"
                    self.value = ""
                    self.KeypadLabel.text = ""
                    self.base!.levelStartTime = Foundation.Date()
                    self.base!.gotKeys = [:]
                    self.enableKeypad()
                } else {
                    let c = String(val.characters.first!)
                    self.value = self.value + c
                    self.NumberLabel.text = self.value
                    
                    let utterence = AVSpeechUtterance(string: c)
                    self.speechSynthesizer.speak(utterence)
                    
                    self.DisplayStringShowContinue(val: String(val.characters.dropFirst(1)))
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if !ended {
            base!.DoEnd()
        }
    }
    
    
}


// A hacky superclass that implementations can subclass as subclassing DigitBase don't work (cannot  initialize supervlasses within the sotrybaord)
class DigitBaseClass {
    var testName = ""
    var testStatus = -1
    
    var base:DigitBase = DigitBase()
    
    var startTime = Foundation.Date()
    var levelStartTime = Foundation.Date()
    
    var gotKeys : [String:String] = [:]

    
    func DoInitialize() {  }
    
    func DoStart()      {  }
    
    func DoEnterDone()  {  }
    
    func DoEnd()        {  }
}
