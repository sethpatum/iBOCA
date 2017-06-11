//
//  DigitBothDirection.swift
//  iBOCA
//
//  Created by saman on 6/11/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

import UIKit

// Inherited by both Forward and Backward digit span. They overrite two methods and done!
class DigitBothDirection:DigitBaseClass {
    var level = 0
    var genval:String = ""
    var preDisplay = true
    var redo = 0
    let MAX_REDO = 2
    let MAX_LEVEL = 6
    
    var genStrings:[String] = []
    var gotStrings:[String] = []
    var gotLevels:[Int] = []
    var gotDuration:[Int] = []
    var totErrors = 0
    var currRound = 0
    
    var resultList : [String:Any] = [:]
    
    
    override func DoInitialize() {
        base.InfoLabel.text = "Press start to begin \(TestName())"
        level  = 0
        redo = 0
        base.disableKeypad()
    }
    
    override func DoStart() {
        base.InfoLabel.text = "Press Continue to get the first set of numbers"
        base.ContinueButton.isHidden = false
        preDisplay = true
        level = 0
        redo = 0
        
        startTime = Foundation.Date()
        genStrings = []
        gotStrings = []
        gotLevels  = []
        gotDuration = []
        totErrors = 0
        currRound = 0
        resultList = [:]
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
            base.NumberLabel.text = ""
            levelStartTime = Foundation.Date()
            gotKeys = [:]
            base.enableKeypad()
        }
    }
    
    override func DoEnterDone() {
        base.disableKeypad()
        
        genStrings.append(genval)
        gotStrings.append(base.value)
        gotLevels.append(level+1)
        let levelEndTime = Foundation.Date()
        let elapsedTime = (Int)(1000*levelEndTime.timeIntervalSince(levelStartTime))
        gotDuration.append(elapsedTime)
        
        var tempList:[String:Any] = [:]
        tempList["Generated"] = genval
        tempList["Entered"] = base.value
        tempList["ElapsedTime (msec)"] = elapsedTime
        tempList["Keystrokes (msec:key)"] = gotKeys
        
        resultList[String(currRound)] = tempList
        
        currRound += 1
        
        
        let pgenval = ProcesString(val: genval)
        if base.value == pgenval {
            base.InfoLabel.text = "Correct! Press continue to get the next set of numbers"
            level += 1
            if level >= MAX_LEVEL {
                base.InfoLabel.text = "Correct!, test done"
                EndTest()
            } else {
                redo = 0
                preDisplay = true
                base.ContinueButton.isHidden = false
            }
        } else {
            redo += 1
            totErrors += 1
            if redo >= MAX_REDO {
                base.InfoLabel.text = "Too many incorrect answers, test ending"
                EndTest()
            } else {
                base.InfoLabel.text = "Incorrect, Press continue to repeat with new numbers"
                preDisplay = true
                base.ContinueButton.isHidden = false
            }
        }
    }
    
    override func DoEnd() {
        base.InfoLabel.text = "Test ended"
        EndTest()
    }
    
    func EndTest() {
        let endTime = Foundation.Date()
        
        let result = Results()
        result.name = TestName()
        result.startTime = startTime
        result.endTime = endTime
        
        result.shortDescription = "\(level) level with \(totErrors) errors"
        
        for (i, l) in gotLevels.enumerated() {
            result.longDescription.add("\(l): \(genStrings[i])-->\(gotStrings[i])  \(gotDuration[i]) msec")
        }
        
        result.json["Details"] = resultList
        result.json["Levels"] = level
        result.json["Errors"] = totErrors
        
        resultsArray.add(result)
        
        base.EndTest()
    }
    
    func ProcesString(val: String) -> String {
        return val
    }
    
    func TestName() -> String {
        return "Forward Digit Span Test"
    }
}

