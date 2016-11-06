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
    fileprivate var currPath = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = UIColor.white
        currPath.lineWidth = 5
        currPath.lineCapStyle = CGLineCap.round
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.black.set()
        isOpaque = false
        backgroundColor = nil
        currPath.stroke()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        currPath.move(to: touch.location(in: self))
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        currPath.addLine(to: touch.location(in: self))
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func drawandclearResults() {
        UIColor.black.set()
        isOpaque = false
        backgroundColor = nil
        currPath.stroke()
        currPath.removeAllPoints()
        setNeedsDisplay()
    }
    
}
