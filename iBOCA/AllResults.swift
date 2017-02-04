//
//  AllResults.swift
//  Integrated test v1
//
//  Created by saman on 8/16/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit
import MessageUI

class AllResults  {
    
    var results:NSMutableArray = NSMutableArray()
    
    // Get the results at # index
    func get(_ index: Int) -> Results {
        return results.object(at: index) as! Results
    }
    
    // add new results at end of the list
    func add(_ res:Results) {
        results.add(res)
    }
    
    // How many results are in the list
    func numResults() -> Int {
        return results.count
    }
    
    // Remove all the results
    func doneWithPatient() {
        results.removeAllObjects()
    }
    
    
    // convert theresults to an e-mail
    func emailBody() -> String {
        var e:String = ""
        
        
        // Iterate over the results
        if(numResults() > 0) {
            for i in 0...numResults()-1 {
                let r = get(i)
                e += "<h2>\(i+1)) \(r.name!)</h2><p>\n"
                
                if(r.shortDescription != nil){
                    e += "\(r.shortDescription)<p>\n"
                }
                
                let elapsedTime = r.endTime!.timeIntervalSince(r.startTime! as Date)
                let duration = Int(elapsedTime)
                e += "\(duration) seconds taken. (Test run on \(r.startTime!))<p>\n"
                
                for objs in r.longDescription {
                    if let desc = objs as? String {
                        e += "\(desc)<p>\n"
                    }
                }
                
                for shot in r.screenshot {
                    let imageString = returnEmailStringBase64EncodedImage(shot)
                    e += "<img src='data:image/png;base64,\(imageString)' width='\(shot.size.width)' height='\(shot.size.height)'><p>\n"
                }
            }
        }
        
        // Put the time scale at the end of the e-mail
        let scaleImage = UIImage(named: "timescale")
        let imageString = returnEmailStringBase64EncodedImage(scaleImage!)
        e += "<p> <h3>scale</h3>\n"
        e += "<img src='data:image/png;base64,\(imageString)' width='\(scaleImage!.size.width)' height='\(scaleImage!.size.height)'><p>\n"
        
        return e
    }
    
    func returnEmailStringBase64EncodedImage(_ image:UIImage) -> String {
        //BUGBUG: Fix this!!
        let imgData:Data = UIImagePNGRepresentation(image)! as Data;
        let dataString = imgData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        return dataString
    }
}
