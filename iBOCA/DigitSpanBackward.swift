//
//  DigitSpanBackward.swift
//  iBOCA
//
//  Created by saman on 6/11/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

import UIKit

class DigitSpanBackward:DigitBothDirection {
    
    override func ProcesString(val: String) -> String {
        return String(val.characters.reversed())
    }
    
    override func TestName() -> String {
        return "Backward Digit Span Test"
    }
}

