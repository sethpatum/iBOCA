//
//  DigitSpanForward.swift
//  iBOCA
//
//  Created by saman on 6/10/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

import UIKit

class DigitSpanForward: DigitBase {

    var level = 0
    var genval:String = ""
    var preDisplay = true
    
    override func DoInitialize() {
        InfoLabel.text = "Press start to begin Forard Digit Span test"
        level  = 0
        disableKeypad()
    }
    
    override func DoStart() {
        InfoLabel.text = "Press Continue to get the first set of numbers"
        ContinueButton.isHidden = false
        preDisplay = true
    }
    
    override func DoContinue() {
        ContinueButton.isHidden = true
        if preDisplay {
            InfoLabel.text = "Tell the numbers to the patient"
            genval = ""
            value = ""
            NumberLabel.text = value
            for i in 0...level {
                 genval = genval + String(arc4random_uniform(9))
            }
            preDisplay = false
            DisplayStringShowContinue(val: genval)
        } else {
            value = ""
            NumberLabel.text = value
            enableKeypad()
        }
    }
    

    
    override func DoEnterDone() {
        disableKeypad()
        level = level + 1
        preDisplay = true
        ContinueButton.isHidden = false
        InfoLabel.text = "Press continue to get the next set of numbers"
    }
    
    override func DoEnd() {
        disableKeypad()
        value = ""
        NumberLabel.text = value
        level = 0
        InfoLabel.text = "Test ended"
    
    }
}

