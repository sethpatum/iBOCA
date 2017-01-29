//
//  BubblesA.swift
//  Integrated test v1
//
//  Created by School on 7/16/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import Foundation
import UIKit

let TrailsTests : [(String, [(String, Int, Int)])] =
    [("Practice",[("1", 810, 280),
                  ("a", 710, 245),
                  ("2", 820, 150),
                  ("b", 300, 130),
                  ("3", 375, 380)]),
     ("Trails B0", [("1", 710, 380),
                   ("a", 950, 300),
                   ("2", 970, 565),
                   ("b", 500, 580),
                   ("3", 580, 525),
                   ("c", 110, 540),
                   ("4", 290, 520),
                   ("d", 70, 450),
                   ("5", 280, 325),
                   ("e", 190, 180),
                   ("6", 170, 300),
                   ("f", 40, 245),
                   ("7", 170, 50),
                   ("g", 850, 40),
                   ("8", 560, 90),
                   ("h", 970, 105),
                   ("9", 970, 105),
                   ("i", 970, 105),
                   ("10", 970, 105),
                   ("j", 970, 105)]),
        ("Trails B1", [("1", 710, 380),
                       ("a", 950, 300),
                       ("2", 970, 565),
                       ("b", 500, 580),
                       ("3", 580, 525),
                       ("c", 110, 540),
                       ("4", 290, 520),
                       ("d", 70, 450),
                       ("5", 280, 325),
                       ("e", 190, 180),
                       ("6", 170, 300),
                       ("f", 40, 245),
                       ("7", 170, 50),
                       ("g", 850, 40),
                       ("8", 560, 90),
                       ("h", 970, 105),
                       ("9", 970, 105),
                       ("i", 970, 105),
                       ("10", 970, 105),
                       ("j", 970, 105)]),
        ("Trails B2", [("1", 710, 380),
                       ("a", 950, 300),
                       ("2", 970, 565),
                       ("b", 500, 580),
                       ("3", 580, 525),
                       ("c", 110, 540),
                       ("4", 290, 520),
                       ("d", 70, 450),
                       ("5", 280, 325),
                       ("e", 190, 180),
                       ("6", 170, 300),
                       ("f", 40, 245),
                       ("7", 170, 50),
                       ("g", 850, 40),
                       ("8", 560, 90),
                       ("h", 970, 105),
                       ("9", 970, 105),
                       ("i", 970, 105),
                       ("10", 970, 105),
                       ("j", 970, 105)]),
        ("Trails B3", [("1", 710, 380),
                       ("a", 950, 300),
                       ("2", 970, 565),
                       ("b", 500, 580),
                       ("3", 580, 525),
                       ("c", 110, 540),
                       ("4", 290, 520),
                       ("d", 70, 450),
                       ("5", 280, 325),
                       ("e", 190, 180),
                       ("6", 170, 300),
                       ("f", 40, 245),
                       ("7", 170, 50),
                       ("g", 850, 40),
                       ("8", 560, 90),
                       ("h", 970, 105),
                       ("9", 970, 105),
                       ("i", 970, 105),
                       ("10", 970, 105),
                       ("j", 970, 105)]),
        ("Trails B4", [("1", 710, 380),
                       ("a", 950, 300),
                       ("2", 970, 565),
                       ("b", 500, 580),
                       ("3", 580, 525),
                       ("c", 110, 540),
                       ("4", 290, 520),
                       ("d", 70, 450),
                       ("5", 280, 325),
                       ("e", 190, 180),
                       ("6", 170, 300),
                       ("f", 40, 245),
                       ("7", 170, 50),
                       ("g", 850, 40),
                       ("8", 560, 90),
                       ("h", 970, 105),
                       ("9", 970, 105),
                       ("i", 970, 105),
                       ("10", 970, 105),
                       ("j", 970, 105)]),
        ("Trails B5", [("1", 710, 380),
                       ("a", 950, 300),
                       ("2", 970, 565),
                       ("b", 500, 580),
                       ("3", 580, 525),
                       ("c", 110, 540),
                       ("4", 290, 520),
                       ("d", 70, 450),
                       ("5", 280, 325),
                       ("e", 190, 180),
                       ("6", 170, 300),
                       ("f", 40, 245),
                       ("7", 170, 50),
                       ("g", 850, 40),
                       ("8", 560, 90),
                       ("h", 970, 105),
                       ("9", 970, 105),
                       ("i", 970, 105),
                       ("10", 970, 105),
                       ("j", 970, 105)])]


class BubblesA {
    var bubblelist : [(String, Int,Int)] = []
    let radius = 20
    
    var currentBubble = -1
    var lastBubble = -1
    
    var nextBubble = 0
    
    var segmenttimes:[(Int, String)] = []
    
    
    //Rotate (180 degrees) or mirror (on x or y) the point
    var xt:Bool = false
    var yt:Bool = false
    
    func transform(coord:(String, Int, Int)) -> (String, Int, Int) {
        var x = coord.1
        var y = coord.2
        if xt  {
            x  = 1010 - x
        }
        if yt {
            y = 625 - y
        }
        return (coord.0, Int(CGFloat(x)*screenSize!.maxX/1024.0), Int(CGFloat(y)*screenSize!.maxY/768.0))
    }
    
    
    init() {
        bubblelist = TrailsTests[selectedTest].1
        bubblelist = bubblelist.map(transform)
    }
    
    
    func inBubble(x:CGFloat, y:CGFloat)->Int{
        
        for (index,bubble) in bubblelist.enumerated(){
            let (_, a, b) = bubble
            
            let z = (x-CGFloat(a))*(x-CGFloat(a)) + (y-CGFloat(b))*(y-CGFloat(b))
            
            if z <= 700.0 {
                //println("inside bubble " + name)
                return index
            }
            
        }
        
        return -1
    }
    
    func inNewBubble(x:CGFloat, y:CGFloat) -> Bool {
        let curr = inBubble(x: x, y:y)
        if curr == currentBubble {
            return false
        }
        if curr == -1 {
            return false
        }
        print("Found new bubble \(curr)")
        
        
        lastBubble = currentBubble
        currentBubble = curr
        
        segmenttimes.append((Int(timePassedTrailsA), "\(lastBubble)->\(currentBubble)"))
        
        return true
        
    }
    
    func inCorrectBubble()->Bool{
        
        // the path has to start with the previous end of selection and go to the one higher than that
        if (currentBubble == nextBubble) && (lastBubble == nextBubble - 1){
            
            nextBubble += 1
            
            if nextBubble == bubblelist.count {
                print("Done")
                nextBubble = 0
                stopTrailsA = true
                displayImgTrailsA = true
            }
            
            timedConnectionsA.append(timePassedTrailsA)
            return true
            
        }
        
        if currentBubble == nextBubble-1 {
            
            return true
            
        }
        
        //        currentBubble = lastBubble
        
        return false
        
    }
    
    
    
}
