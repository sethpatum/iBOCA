//
//  DigitSpanForward.swift
//  iBOCA
//
//  Created by saman on 6/10/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

import UIKit

class DigitSpanForward:DigitBothDirection {
    
    override func ProcesString(val: String) -> String {
        return val
    }
    
    override func TestName() -> String {
        return "Forward Digit Span Test"
    }
    
    override func LevelStart() -> Int {
        return 4
    }
    
    override func LevelEnd() -> Int {
        return 9
    }
}

