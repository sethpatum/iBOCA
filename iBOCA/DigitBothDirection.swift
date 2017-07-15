//
//  DigitBothDirection.swift
//  iBOCA
//
//  Created by saman on 6/11/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

import UIKit
import AVFoundation

// Inherited by both Forward and Backward digit span. They overrite two methods and done!
class DigitBothDirection:DigitBaseClass {
    var genval:String = ""
    var redo = 0
    let MAX_REDO = 2
    
    var genStrings:[String] = []
    var gotStrings:[String] = []
    var gotLevels:[Int] = []
    var gotDuration:[Int] = []
    var totErrors = 0
    var currRound = 0
        
    var resultList : [String:Any] = [:]
    
    override func DoInitialize() {
        TestInitialize()
        base.InfoLabel.text = "Press start to begin \(testName) and tell the patiant the first set of numbers"
        level  = LevelStart() - 1
        redo = 0
        base.disableKeypad()
    }
    
    override func DoStart() {
        base.InfoLabel.text = "Tell the patient the numbers, followed by intering his/her response"
        level = LevelStart() - 1
        redo = 0
        
        startTime = Foundation.Date()
        genStrings = []
        gotStrings = []
        gotLevels  = []
        gotDuration = []
        totErrors = 0
        currRound = 0
        resultList = [:]
        StartDisplay()
    }
    
    func StartDisplay() {
        genval = ""
        base.value = ""
        base.NumberLabel.text = ""
        base.KeypadLabel.text = ""
        var candidate = [0, 1, 2, 4, 5, 6, 7, 8, 9]
        for i in 0...level {
            let pos = (Int)(arc4random_uniform(UInt32(candidate.count)))
            genval = genval + String(candidate[pos])
            candidate.remove(at: pos)
        }
        base.DisplayStringShowContinue(val: genval)
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
            base.InfoLabel.text = "Correct! Tell the next set of numbers"
            level += 1
            if level >= LevelEnd() {
                base.InfoLabel.text = "Correct!, test done"
                EndTest()
            } else {
                redo = 0
                StartDisplay()
            }
        } else {
            redo += 1
            totErrors += 1
            if redo >= MAX_REDO {
                base.InfoLabel.text = "Too many incorrect answers, test ending"
                EndTest()
            } else {
                base.InfoLabel.text = "Incorrect, Repeat with new numbers"
                StartDisplay()
            }
        }
    }
    
    override func DoEnd() {
        base.InfoLabel.text = "Test ended"
        Status[testStatus] = TestStatus.Done
        EndTest()
    }
    
    func EndTest() {
        let endTime = Foundation.Date()
        
        let result = Results()
        result.name = testName
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
        Status[testStatus] = TestStatus.Done
    }
    
    // Mainly redefined in the subclass
    func TestInitialize() {
        
    }
    
    func ProcesString(val: String) -> String {
        return val
    }
    
    func LevelStart() -> Int {
        return 0
    }
    
    func LevelEnd() -> Int {
        return 6
    }
}

