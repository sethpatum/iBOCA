//
//  PatiantID.swift
//  iBOCA
//
//  Created by saman on 6/25/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

class PatiantID {
    var testAdminName    : String = ""
    var currNum : Int = 0
    var currInitials : String = ""
    var currDate : String = ""
    
    
    init() {
        if UserDefaults.standard.object(forKey: "testAdministrator") != nil {
            testAdminName = UserDefaults.standard.object(forKey: "testAdministrator") as! String
        }
        setInitials()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        currDate = formatter.string(from: Foundation.Date())
        
        if UserDefaults.standard.object(forKey: "lastTestDate") != nil {
            let ltd = UserDefaults.standard.object(forKey: "lastTestDate") as! String
            if ltd == currDate {
                if UserDefaults.standard.object(forKey: "lastPatiantNumber") != nil {
                    currNum = (UserDefaults.standard.object(forKey: "lastPatiantNumber") as! Int) + 1
                }
            } else {
                UserDefaults.standard.set(currDate, forKey:"lastTestDate")
            }
        } else {
            UserDefaults.standard.set(currDate, forKey:"lastTestDate")
        }
    }
    
    func nameSet(name : String) {
        if name != testAdminName {
            testAdminName = name
            UserDefaults.standard.set(testAdminName, forKey:"testAdministrator")
            setInitials()
            currNum = 0
            UserDefaults.standard.set(currNum, forKey:"lastPatiantNumber")
        }
    }
    
    func changeID(proposed : String) -> Bool {
        let r1 = proposed.range(of: "-", options: String.CompareOptions.backwards, range: nil, locale: nil)
        if r1 == nil {
            return false
        }
        let r2 = proposed.index((r1?.lowerBound)!, offsetBy: 1)
        let r3 = r2 ..< proposed.endIndex
        let str = proposed[r3]
        if str == "" {
            return false
        }
        if Int(str) == nil {
            return false
        }
        currNum = Int(str)!
        UserDefaults.standard.set(currNum, forKey:"lastPatiantNumber")
        return true
    }
    
    func getID() -> String {
        return "\(currInitials)-\(currDate)-" + String(format: "%03d", currNum)
    }
    
    func incID() {
        currNum += 1
        UserDefaults.standard.set(currNum, forKey:"lastPatiantNumber")
    }
    
    func getName() -> String {
        return testAdminName
    }
    
    func getInitials() -> String {
        return currInitials
    }
    
    func setInitials() {
        if testAdminName == "" {
            currInitials = "??"
            return
        }

        for (index, char) in testAdminName.characters.enumerated() {
            let indexminus1 = index - 1
            if index == 0 {
                currInitials = String(char).uppercased()
            } else if testAdminName[testAdminName.characters.index(testAdminName.startIndex, offsetBy:indexminus1)] == " " {
                self.currInitials += String(char).uppercased()
            }
        }
    }
}
