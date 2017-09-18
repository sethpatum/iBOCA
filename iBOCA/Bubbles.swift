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
                  ("2", 420, 250),
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
                   ("9", 570, 215),
                   ("i", 770, 320),
                   ("10",420, 145),
                   ("j", 450, 420)]),
     ("Trails B1", [("1", 170, 300),
                    ("a", 40, 245),
                    ("2", 170, 50),
                    ("b", 850, 40),
                    ("3", 560, 90),
                    ("c", 970, 105),
                    ("4", 570, 215),
                    ("d", 770, 320),
                    ("5",420, 145),
                    ("e", 450, 420),
                    ("6", 710, 380),
                    ("f", 950, 300),
                    ("7", 970, 565),
                    ("g", 500, 580),
                    ("8", 580, 525),
                    ("h", 110, 540),
                    ("9", 290, 520),
                    ("i", 70, 450),
                    ("10", 280, 325),
                    ("j", 190, 180)]),
     ("Trails B2", [("1", 450, 420),
                    ("a", 420, 145),
                    ("2", 770, 320),
                    ("b", 570, 215),
                    ("3", 970, 105),
                    ("c", 560, 90),
                    ("4", 850, 40),
                    ("d", 170, 50),
                    ("5", 40, 245),
                    ("e", 170, 300),
                    ("6", 190, 180),
                    ("f", 280, 325),
                    ("7", 70, 450),
                    ("g", 290, 520),
                    ("8", 110, 540),
                    ("h", 580, 525),
                    ("9", 500, 580),
                    ("i", 970, 565),
                    ("10",950, 300),
                    ("j", 710, 380)]),
     ("Trails B3", [("1", 190, 180),
                    ("a", 280, 325),
                    ("2", 70, 450),
                    ("b", 290, 520),
                    ("3", 110, 540),
                    ("c", 580, 525),
                    ("4", 500, 580),
                    ("d", 970, 565),
                    ("5",950, 300),
                    ("e", 710, 380),
                    ("6", 450, 420),
                    ("f", 420, 145),
                    ("7", 770, 320),
                    ("g", 570, 215),
                    ("8", 970, 105),
                    ("h", 560, 90),
                    ("9", 850, 40),
                    ("i", 170, 50),
                    ("10", 40, 245),
                    ("j", 170, 300),]),
        ("Trails B4", [("1", 250, 150),
                       ("a", 160, 300),
                       ("2", 150, 550),
                       ("b", 50, 525),
                       ("3", 160, 190),
                       ("c", 30, 20),
                       ("4", 250, 40),
                       ("d", 850, 70),
                       ("5", 950, 150),
                       ("e", 740, 120),
                       ("6", 620, 170),
                       ("f", 500, 320),
                       ("7", 440, 270),
                       ("g", 310, 550),
                       ("8", 510, 570),
                       ("h", 650, 300),
                       ("9", 820, 370),
                       ("i", 950, 540),
                       ("10",640, 580),
                       ("j", 750, 450)]),
        ("Trails B5", [("1", 750, 450),
                       ("a", 640, 580),
                       ("2", 950, 540),
                       ("b", 820, 370),
                       ("3", 650, 300),
                       ("c", 510, 570),
                       ("4", 310, 550),
                       ("d", 440, 270),
                       ("5", 500, 320),
                       ("e", 620, 170),
                       ("6", 740, 120),
                       ("f", 950, 150),
                       ("7", 850, 70),
                       ("g", 250, 40),
                       ("8", 30, 20),
                       ("h", 160, 190),
                       ("9", 50, 525),
                       ("i", 150, 550),
                       ("10",160, 300),
                       ("j", 250, 150)]),
        ("Trails B6", [("1", 450, 330),
                       ("a", 720, 440),
                       ("2", 800, 200),
                       ("b", 190, 270),
                       ("3", 340, 280),
                       ("c", 560, 410),
                       ("4", 160, 360),
                       ("d", 140, 520),
                       ("5", 490, 510),
                       ("e", 880, 530),
                       ("6", 820, 290),
                       ("f", 920, 120),
                       ("7", 440, 190),
                       ("g", 650, 130),
                       ("8", 130, 100),
                       ("h", 510, 120),
                       ("9", 120, 190),
                       ("i", 110, 440),
                       ("10", 60, 560),
                       ("j", 760, 540),
                       ("11",960, 580),
                       ("k", 970, 40),
                       ("12",600, 50),
                       ("l", 830, 80)])]



class BubblesA {
    var bubblelist : [(String, Int,Int)] = []
    let radius = 20
    
    var currentBubble = -1
    var lastBubble = -1
    
    var nextBubble = 0
    
    var seqCount = 0
    
    var segmenttimes:[(Int, String, Int)] = []
    var jsontimes : [String:Any] = [:]
    
    var startTime = Foundation.Date()
    
    var xmin = 1000
    var xmax = 9
    var ymin = 1000
    var ymax = 0
    func getrange() {
        for (s, x, y) in bubblelist {
            xmin = min(x, xmin)
            xmax = max(x, xmax)
            ymin = min(y, ymin)
            ymax = max(y, ymax)
        }
    }
    
    //Rotate (180 degrees) or mirror (on x or y) the point
    var xt:Bool = false
    var yt:Bool = false
    
    func transform(coord:(String, Int, Int)) -> (String, Int, Int) {
        var x = coord.1
        var y = coord.2
        
        let bcount = (24 - bubblelist.count) * 8
        x = (x - xmin)*(950-40-2*bcount)/(xmax - xmin) + 40 + bcount
        y = (y - ymin)*(580-40-2*bcount)/(ymax - ymin) + 40 + bcount
        
        if xt  {
            x  = 1010 - x
        }
        if yt {
            y = 625 - y
        }
        //return (coord.0, Int(CGFloat(x)*screenSize!.maxX/1024.0), Int(CGFloat(y)*screenSize!.maxY/768.0))
        return (coord.0, x, y)
    }
    
    
    init() {
        for i in 0...numBubbles-1 {
            bubblelist.append(TrailsTests[selectedTest].1[i])
        }
        getrange()
        bubblelist = bubblelist.map(transform)
        startTime = Foundation.Date()
        jsontimes.removeAll()
        segmenttimes.removeAll()
        seqCount = 0
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
        
        seqCount += 1
        return true
        
    }
    
    func inCorrectBubble()->Bool{
        let currTime = Foundation.Date()
        // the path has to start with the previous end of selection and go to the one higher than that
        if (currentBubble == nextBubble) && (lastBubble == nextBubble - 1){
            
            nextBubble += 1
            
            if nextBubble == bubblelist.count {
                print("Done")
                nextBubble = 0
                stopTrailsA = true
                displayImgTrailsA = true
            }
            
            segmenttimes.append((Int(timePassedTrailsA), "\(lastBubble)->\(currentBubble):OK ", Int(1000*currTime.timeIntervalSince(startTime))))
            jsontimes[String(seqCount-1)] = ["Start":lastBubble, "End":currentBubble, "Correct":true, "Time (ms)":Int(1000*currTime.timeIntervalSince(startTime))]
            
            timedConnectionsA.append(timePassedTrailsA)
            return true
            
        }
        
        if currentBubble == nextBubble-1 {
            segmenttimes.append((Int(timePassedTrailsA), "\(lastBubble)->\(currentBubble):OK ", Int(1000*currTime.timeIntervalSince(startTime))))
            jsontimes[String(seqCount-1)] = ["Start":lastBubble, "End":currentBubble, "Correct":true, "Time (ms)":Int(1000*currTime.timeIntervalSince(startTime))]

            return true
            
        }
        
        segmenttimes.append((Int(timePassedTrailsA), "\(lastBubble)->\(currentBubble):OK ", Int(1000*currTime.timeIntervalSince(startTime))))
        jsontimes[String(seqCount-1)] = ["Start":lastBubble, "End":currentBubble, "Correct":false, "Time (ms)":Int(1000*currTime.timeIntervalSince(startTime))]
        
        currentBubble = lastBubble
        return false
    }
    
    
    
}
