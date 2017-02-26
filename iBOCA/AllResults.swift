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
        var e : String = ""
        var jst : [String:String] = [:]
        
        e += "<h4>Subject Code: \(name)</h4>\n"
        jst["Subject Code"] = name
        
        e += "<h4>MR#:\(MR)</h4>\n"
        jst["MR#"] = MR
        
        e += "<h4>Gender:\(Gender)</h4>\n"
        jst["Gender"] = Gender

        e += "<h4>Age:\(age)</h4>\n"
        jst["Age"] = age
        
        e += "<h4>Education:\(Education)</h4>\n"
        jst["Education"] = Education
        
        e += "<h4>Race:\(Race)</h4>\n"
        jst["Race"] = Race

        e += "<h4>Ethnicity:\(Ethnicity)</h4>\n<p>\n"
        jst["Ethnicity"] = Ethnicity

        
        // Iterate over the results
        if(numResults() > 0) {
            for i in 0...numResults()-1 {
                let r = get(i)
                e += "<h2>\(i+1)) \(r.name!)</h2><p>\n"
        
                if(r.primaryDescription != nil){
                    e += "<h4>\(r.primaryDescription)</h4><p>\n"
                }
    
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
        
        e += "\n[" + String(describing: jst)
        for i in 0...numResults()-1 {
            let r = get(i)
            e += ", <p>"
            e +=  "[\"" + r.name! + "\":" + sortedJson(dict: r.toJson()) + "]\n"
        }
        e += "\n<p>]\n"
        
        return e
    }
    
    // If a set of keys are Integers, sort them 
    func sortedJson(dict : [String:Any]) -> String {
        var ret = "["
        var sorted = Array(dict).sorted(by: {$0.0 < $1.0})
        let isint: Int? = Int(dict.keys.first!)
        if isint != nil {
            sorted = Array(dict).sorted(by: {Int($0.0)! < Int($1.0)!})
        }
        
        var start = true
        for (k,v) in sorted {
            if start {
                start = false
            } else {
                ret += ", "
            }
            
            var kk : String = String(k)
            if isint == nil {
                kk = "\"" + String(k) + "\""
            }
            
            if v is [String:Any] {
                let vstr : String = kk + ":" + sortedJson(dict: v as! [String : Any])
                ret.append(vstr)
            } else if Int(String(describing: v)) == nil {
                ret.append(kk + ":\"" + String(describing: v) + "\"")
            }  else {
                ret.append(kk + ":" + String(describing: v))
            }
        }
        
        ret += "]"
        return ret
    }
    
    func returnEmailStringBase64EncodedImage(_ image:UIImage) -> String {
        //BUGBUG: Fix this!!
        let imgData:Data = UIImagePNGRepresentation(image)! as Data;
        let dataString = imgData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        return dataString
    }
}
