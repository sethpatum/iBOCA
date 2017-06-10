//
//  DigitSpanForward.swift
//  iBOCA
//
//  Created by saman on 6/10/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

import UIKit

class DigitSpanForward:DigitBaseClass {
    var level = 0
    var genval:String = ""
    var preDisplay = true
    
    override func DoInitialize() {
        base.InfoLabel.text = "Press start to begin Forard Digit Span test"
        level  = 0
        base.disableKeypad()
    }
    
    override func DoStart() {
        base.InfoLabel.text = "Press Continue to get the first set of numbers"
        base.ContinueButton.isHidden = false
        preDisplay = true
    }
    
    override func DoContinue() {
        base.ContinueButton.isHidden = true
        if preDisplay {
            base.InfoLabel.text = "Tell the numbers to the patient"
            genval = ""
            base.value = ""
            base.NumberLabel.text = base.value
            for i in 0...level {
                var num:String = String(arc4random_uniform(9))
                // Check if the previous character is the same
                if genval.characters.count > 0 {
                    while(String(genval.characters.last!) == num) {
                        num = String(arc4random_uniform(9))
                    }
                }
                 genval = genval + num
            }
            preDisplay = false
            base.DisplayStringShowContinue(val: genval)
        } else {
            base.value = ""
            base.NumberLabel.text = base.value
            base.enableKeypad()
        }
    }
    
    override func DoEnterDone() {
        base.disableKeypad()
        level = level + 1
        preDisplay = true
        base.ContinueButton.isHidden = false
        base.InfoLabel.text = "Press continue to get the next set of numbers"
    }
    
    override func DoEnd() {
        base.disableKeypad()
        base.value = ""
        base.NumberLabel.text = base.value
        level = 0
        base.InfoLabel.text = "Test ended"
    
    }
}

