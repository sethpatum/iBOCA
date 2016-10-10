//
//  3DFigureDraw.swift
//  iBOCA
//
//  Created by Seth Amarasinghe on 10/10/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import Foundation
import UIKit

class ThreeDFigureDraw: UIView {
    private var currPath = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = UIColor.whiteColor()
        currPath.lineWidth = 5
        currPath.lineCapStyle = CGLineCap.Round
    }
    
    override func drawRect(rect: CGRect) {
        UIColor.blackColor().set()
        opaque = false
        backgroundColor = nil
        currPath.stroke()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        currPath.moveToPoint(touch.locationInView(self))
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        currPath.addLineToPoint(touch.locationInView(self))
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    func drawandclearResults() {
        UIColor.blackColor().set()
        opaque = false
        backgroundColor = nil
        currPath.stroke()
        currPath.removeAllPoints()
        setNeedsDisplay()
    }
    
}
