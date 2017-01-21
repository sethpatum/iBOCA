//
//  ScaleView.swift
//  Integrated test v1
//
//  Created by saman on 8/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit

class ScaleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.white
    }
    
    
    func reset() {
        setNeedsDisplay()
    }
    
    
    func lineseg(xStart:CGFloat, xEnd:CGFloat, cStart:CGFloat, cEnd:CGFloat) {
        var prev = CGPoint(x:xStart, y:10)
        
        let context = UIGraphicsGetCurrentContext();
        let aFont = UIFont(name: "Optima-Bold", size: 10)
//        let attr:CFDictionary = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.blackColor()]
        let attr:NSDictionary = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.black]

        
        for i in 0...100 {
            let path = UIBezierPath()
            path.lineWidth = 5
            path.lineCapStyle = CGLineCap.round
            
            var v = CGFloat(i)*(xEnd-xStart)/100.0 + xStart
            let next = CGPoint(x:v, y:10.0)
            path.move(to: prev)
            path.addLine(to: next)
            
            let c = CGFloat(i)*(cEnd-cStart)/100.0 + cStart
            let cgc = getColor(i: Double(c))
            let uic = UIColor(cgColor:cgc)
            uic.set()
            path.stroke()
            prev = next
            
            if i % 10 == 0 {
                let text = CFAttributedStringCreate(nil, String(Int(c)) as CFString!, attr)
                let line = CTLineCreateWithAttributedString(text!)
                context!.textMatrix = CGAffineTransform(a: CGFloat(1), b: CGFloat(0), c: CGFloat(0), d: CGFloat(-1), tx: CGFloat(0), ty: CGFloat(0))
                context!.textPosition = CGPoint(x: v, y: 25)
                CTLineDraw(line, context!)
                
            }
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        let mid = bounds.width / 2 - 20
        let end = bounds.width - 80.0
        lineseg(xStart: 80.0, xEnd:mid, cStart:0.0, cEnd:10.0)
        lineseg(xStart: mid, xEnd:end, cStart:10.0, cEnd:60.0)
        
    }
    
    
    func getColor(i: Double) -> CGColor {
        if (i < 5.0) {
            let h = CGFloat(0.3 - i / 15.0)
            return UIColor(hue: h, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
        } else if (i < 60) {
            let b = CGFloat((60.0 - i)/55.0)
            return UIColor(hue: 0.0, saturation: 1.0, brightness: b, alpha: 1.0).cgColor
        } else {
            return UIColor(hue: 0.0, saturation: 1.0, brightness: 0.0, alpha: 1.0).cgColor
        }
    }
    
    
}
