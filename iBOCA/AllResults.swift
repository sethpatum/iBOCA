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
        print(toJson())
        results.removeAllObjects()
    }
    
    
    // convert theresults to an e-mail
    func emailBody() -> String {
        var e : String = ""
        
        e += "<head>\n"
        e += "<style>\n"
        e += "table { font-family: arial, sans-serif; border-collapse: collapse; }\n"
        e += "td, th { border: 1px solid #dddddd; text-align: left; padding: 8px; }\n"
        e += "tr:nth-child(even) { background-color: #dddddd; }\n"
        e += "</style>\n"
        e += "</head>\n"
        e += "<body>\n"
        
        if(name != nil) {
            e += "<h4>Subject Code: \(name!)</h4>\n"
        }
        
        if(MR != nil) {
            e += "<h4>MR#:\(MR!)</h4>\n"
        }
        
        if(Gender != nil) {
            e += "<h4>Gender:\(Gender!)</h4>\n"
        }

        if(age != nil) {
            e += "<h4>Age:\(age!)</h4>\n"
        }
        
        if(Education != nil) {
            e += "<h4>Education:\(Education!)</h4>\n"
        }
        
        if(Race != nil) {
            e += "<h4>Race:\(Race!)</h4>\n"
        }

        if(Ethnicity != nil) {
            e += "<h4>Ethnicity:\(Ethnicity!)</h4>\n<p>\n"
        }
        
          if(numResults() > 0) {
            e += "<p>\n"
             e += "<h2>Summary of Results</h2>\n<p>\n"
            e += "<table>\n"
            e += "<tr> <th>Test</th> <th>Errors</th> <th>Time(seconds)</th> </tr>\n"
            

            for i in 0...numResults()-1 {
                let r = get(i)
                e += "<tr>\n <td>\(r.name!)</td>"
                if r.numErrors > 0 {
                    e += "<td> \(r.numErrors) </td>"
                } else {
                    e += "<td> No errors </td>"
                }
                let elapsedTime = r.endTime!.timeIntervalSince(r.startTime! as Date)
                let duration = Int(elapsedTime)
                e += "<td>\(duration)</td>"

                e += "</tr>\n"

            }
            e += "</table>"
            e += "<p>\n"
        }
        
        
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
        
        e += "\n<p>\n" + toJson() + "\n<p>\n"
        e += "</body>\n"
        
        return e
    }
    
    
    func toJson() -> String {
        var e : String = ""
        var jst : [String:String] = [:]
        
        if(name != nil) {
            jst["Subject Code"] = name!
        }
        
        if(MR != nil) {
            jst["MR#"] = MR!
        }
        
        if(Gender != nil) {
            jst["Gender"] = Gender!
        }
        
        if(age != nil) {
            jst["Age"] = age!
        }
        
        if(Education != nil) {
            jst["Education"] = Education!
        }
        
        if(Race != nil) {
            jst["Race"] = Race!
        }
        
        if(Ethnicity != nil) {
            jst["Ethnicity"] = Ethnicity!
        }
        
        var tst : [String:String] = [:]
        tst["Device Name"] = UIDevice.current.name
        tst["Device ID"] = UIDevice.current.identifierForVendor?.uuidString
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd HH:MM"
        tst["Test Start Time"] = formatter.string(from: testStartTime)
  
        let elapsedTime = (Int)(Foundation.Date().timeIntervalSince(testStartTime))
        tst["Test Duration"] = "\((Int)(elapsedTime/3600)):\((Int)(elapsedTime/60)%60):\(elapsedTime%60)"
        
        tst["iBOCA version"] = (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0") + " (Build " +  (Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "0") + ")"

        e += "{ \"Setup\":" + sortedJson(dict: tst) + ", "
        e += "\"Demographics\":" + sortedJson(dict: jst)
        
        if numResults() > 0 {
            e += ", \"Tests\":["
            for i in 0...numResults()-1 {
                let r = get(i)
                if i > 0 {
                    e += ", "
                }
                e +=  "{\"" + r.name! + "\":" + sortedJson(dict: r.toJson()) + "}\n"
            }
            e += "]"
        }
        e += "}"
        return e;
    }
    
    // If a set of keys are Integers, sort them 
    func sortedJson(dict : [String:Any]) -> String {
        var ret = "{"
        var sorted = Array(dict).sorted(by: {$0.0 < $1.0})
        var isint: Bool = false
        if dict.count > 0 {
            isint = dict.keys.first!.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
            if isint {
                sorted = Array(dict).sorted(by: {Int($0.0)! < Int($1.0)!})
            }
        }
        
        var start = true
        for (k,v) in sorted {
            if start {
                start = false
            } else {
                ret += ", "
            }
            
            let kk : String = "\"" + String(k) + "\""

            if v is [String:Any] {
                let vstr : String = kk + ":" + sortedJson(dict: v as! [String : Any])
                ret.append(vstr)
            } else if v is Int {
                ret.append(kk + ":" + String(describing: v))
            } else {
                ret.append(kk + ":\"" + String(describing: v) + "\"")
            }
        }
        
        ret += "}"
        return ret
    }
    
    func returnEmailStringBase64EncodedImage(_ image:UIImage) -> String {
        //BUGBUG: Fix this!!
        let imgData:Data = UIImagePNGRepresentation(image)! as Data;
        let dataString = imgData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        return dataString
    }
}
