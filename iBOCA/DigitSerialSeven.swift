//
//  DigitSerialSeven.swift
//  iBOCA
//
//  Created by saman on 6/16/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation


import UIKit
import AVFoundation


class DigitSerialSeven:DigitBaseClass {
    var level = -1
    var startNum = 0
    var lastNum = 0
    let MAXLEVEL = 7
    var genval:String = ""
    
    var enteredNumber:[Int] = []
    var expectedNumber:[Int] = []
    var sequenceNumber:[Int] = []
    var gotTime:[Date] = []
    var totErrors = 0
    var keys : [[String:String]] = [[:]]
    
    override func DoInitialize() {
        testName =  "Serial Sevens Test"
        testStatus = TestSerialSevens
        base.InfoLabel.text = "Press start to begin \(testName)"
        base.disableKeypad()
        level = -1
    }
    
    override func DoStart() {
        base.InfoLabel.text = "Enter the starting number. Tell the patiant that number and instructions"
        level = -1
        startTime = Foundation.Date()
        
        enteredNumber = []
        expectedNumber = []
        sequenceNumber = []
        gotTime = []
        totErrors = 0
        keys = []
        
        base.enableKeypad()
    }
    
    
    override func DoEnterDone() {
        base.disableKeypad()
        
        if level == -1 {
            // At the begining of the test
            guard let num = Int(base.value) else {
                base.InfoLabel.text = "Error: Enter a number"
                base.enableKeypad()
                return
            }
            startNum = num
            base.value = ""
            base.KeypadLabel.text = ""
            
            if startNum < MAXLEVEL*7 + 1 {
                base.InfoLabel.text = "Error: Start Number too small"
                base.enableKeypad()
                return
            }
            
            // Got a good start
            levelStartTime = Foundation.Date()
            lastNum = startNum
            level += 1
             base.InfoLabel.text = "Ask patiant for previous number minus 7, Enter it"
       } else {
            // Middle of the test
            guard let num = Int(base.value) else {
                base.InfoLabel.text = "Error: Enter a number"
                base.enableKeypad()
                return
            }
            
            level += 1
            base.KeypadLabel.text = ""
            base.value = ""
            
            if num == lastNum - 7 {
                totErrors += 1
                base.InfoLabel.text = "Correct: Ask patiant for previous number minus 7, Enter it"
            } else {
                base.InfoLabel.text = "Incorrect: End the test or ask patiant for previous number minus 7 and enter it"
            }
            
            enteredNumber.append(num)
            expectedNumber.append(lastNum - 7)
            sequenceNumber.append(startNum - 7*level)
            keys.append(gotKeys)
            gotTime.append(Foundation.Date())
            
            lastNum = num
        }
   
        if level >= MAXLEVEL {
            // Done test
            base.InfoLabel.text = "Test Ended"
            DoEnd()
            return
        }
    
        base.enableKeypad()
    }
    
    override func DoEnd() {
        let endTime = Foundation.Date()
        
        let result = Results()
        result.name = testName
        result.startTime = startTime
        result.endTime = endTime
        
        result.longDescription.add("Starting with \(startNum)")
        result.json["Starting Number"] = startNum
        var resultList : [Int:Any] = [:]
        var sttime = levelStartTime
        for (i, l) in enteredNumber.enumerated() {
            var res : [String:Any] = [:]
            res["Entered"] = l
            res["Subtract 7"] = expectedNumber[i]
            res["Sequence 7"] = sequenceNumber[i]
            
            let elapsedTime = (Int)(1000*gotTime[i].timeIntervalSince(sttime))
            sttime = gotTime[i]
            res["time (msec)"] = elapsedTime
            resultList[i] = res
            result.longDescription.add("\(i): \(enteredNumber[i])-->\(expectedNumber[i]), \(sequenceNumber[i])  \(elapsedTime) msec")
        }
        result.json["Results"] = resultList
        
        result.shortDescription = "\(level) level with \(totErrors) errors"
        
        resultsArray.add(result)
        Status[testStatus] = TestStatus.Done
    
        base.EndTest()
    }
}
