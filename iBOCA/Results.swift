//
//  Results.swift
//  Integrated test v1
//
//  Created by saman on 8/8/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit

var resultsArray : AllResults = AllResults()

class Results: NSObject {
    var name:String?
    var startTime:Foundation.Date?
    var endTime:Foundation.Date?
    var shortDescription:String?
    var primaryDescription:String?
    var longDescription : NSMutableArray = NSMutableArray()
    var numErrors : Int = 0
    var screenshot : [UIImage] = []
    var json : [String:Any] = [:]
    
    var collapsed : Bool = true // for use by the View Controller
    
    // Constructor
    func Results(_ nm:String, startTime:Foundation.Date, endTime:Foundation.Date) {
        name = nm
        self.startTime = startTime
        self.endTime = endTime
    }
    
    // Return the string function to put on the header
    func header() -> String {
        let elapsedTime = endTime!.timeIntervalSince(startTime! as Date)
        let duration = Int(elapsedTime)
        var res = name! + " (" + String(duration) + " secs): "
        if numErrors > 0 {
            res = res + "\(numErrors) Errors "
        }
        if shortDescription != nil {
            res = res + shortDescription!
        }
        return res
    }
    
    
    // Number of rows should be long description + # of screenshots
    func numRows() -> Int {
            return longDescription.count + screenshot.count
    }
    
    
    // All rows are same height, except the screeshot
    func heightForRow(_ i:Int) -> Int {
        if i < longDescription.count {
             return 60
        }
        if i >= longDescription.count {
            return Int(screenshot[i-longDescription.count].size.height) + 10
        }
        return 0
    }
    
    
    // either a text row are a screenshot raw
    func setRow(_ i:Int, cell:UITableViewCell) {
        if i < longDescription.count {
            cell.textLabel?.text = longDescription.object(at: i) as? String
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.textLabel?.numberOfLines = 0
        }
       if i >= longDescription.count {
            cell.imageView?.image = screenshot[i-longDescription.count]
            cell.textLabel?.text = nil
        } else {
            cell.imageView?.image = nil
        }
    }
    
    func TakeScreeshot() {
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        screenshot.append(UIGraphicsGetImageFromCurrentImageContext()!)
    }
    
    func displayLocal(_ view:UIView?, imageView:UIImageView?, results:UILabel) {
//        if resultsDisplayOn == true {
            if view != nil && imageView != nil {
                view!.addSubview(imageView!)
            }
            var str:String = ""
            for info in longDescription {
                str += info as! String
                str += "\n"
            }
            results.text = str
        }
        
//    }
    
    
    func toJson() -> [String:Any] {
        let tlen = Int(endTime!.timeIntervalSince(startTime!)*1000)
        let js : [String:Any] = ["Started At":startTime!, "Test length (msec)": tlen, "results":json]
        
        return js
    }
   
}
