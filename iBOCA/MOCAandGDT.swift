//
//  MOCAandGDT.swift
//  iBOCA
//
//  Created by saman on 6/27/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation
import UIKit

class MOCAandGDT: ViewController, UIPickerViewDelegate  {
    
    
    var startTime  = Foundation.Date()

    
    @IBOutlet weak var MOCAexecutive: UIPickerView!
    @IBOutlet weak var MOCAnaming: UIPickerView!
    @IBOutlet weak var MOCAattention: UIPickerView!
    @IBOutlet weak var MOCAreadlist: UIPickerView!
    @IBOutlet weak var MOCAserial7: UIPickerView!
    @IBOutlet weak var MOCAlanguage: UIPickerView!
    @IBOutlet weak var MOCAfluency: UIPickerView!
    @IBOutlet weak var MOCAabstraction: UIPickerView!
    @IBOutlet weak var MOCArecall: UIPickerView!
    @IBOutlet weak var MOCAorientation: UIPickerView!

    @IBOutlet weak var MOCAtotal: UILabel!
    
    @IBOutlet weak var Comments: UITextView!
    
    var buttonlist : [UIPickerView] = []
    let buttonval  = [5, 3, 2, 1, 3, 2, 1, 2, 5, 6]
    var buttonresults : [Int]  = [Int](repeating: 0, count: 10)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonlist.append(MOCAexecutive)
        buttonlist.append(MOCAnaming)
        buttonlist.append(MOCAattention)
        buttonlist.append(MOCAreadlist)
        buttonlist.append(MOCAserial7)
        buttonlist.append(MOCAlanguage)
        buttonlist.append(MOCAfluency)
        buttonlist.append(MOCAabstraction)
        buttonlist.append(MOCArecall)
        buttonlist.append(MOCAorientation)
        
        for bl in buttonlist {
            bl.delegate = self
        }
        
        
        MOCAtotal.text = "0"
        
        Comments.text = ""
    }
    
    
    func numberOfComponentsInPickerView(_ pickerView : UIPickerView!) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{

        for (i, bl) in buttonlist.enumerated() {
            if pickerView == bl {
                return buttonval[i]+1
            }
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        for (i, bl) in buttonlist.enumerated() {
            if pickerView == bl {
                buttonresults[i] = row
                setMOCAtotal()
                return
            }
        }
    }
    
    func setMOCAtotal() {
        var tot = 0
        for v in buttonresults {
            tot += v
        }
        MOCAtotal.text = String(tot)
    }
    

    func done() {
        let result = Results()
        result.name = "MOCA Results"
        result.startTime = startTime
        result.endTime = Foundation.Date()
        result.json["MOCA Executive"]   = buttonresults[0]
        result.json["MOCA Naming"]      = buttonresults[1]
        result.json["MOCA Attention"]   = buttonresults[2]
        result.json["MOCA Read List"]   = buttonresults[3]
        result.json["MOCA Serial 7"]    = buttonresults[4]
        result.json["MOCA Language"]    = buttonresults[5]
        result.json["MOCA Fluency"]     = buttonresults[6]
        result.json["MOCA Abstraction"] = buttonresults[7]
        result.json["MOCA Recall"]      = buttonresults[8]
        result.json["MOCA Orientation"] = buttonresults[9]
        result.json["MOCA TOTAL"] = MOCAtotal.text

        result.json["Comments"] = Comments.text
        
        result.shortDescription = "MOCA=\(MOCAtotal.text!)"
        
        resultsArray.add(result)
        Status[TestMOCAandGDTResults] = TestStatus.Done
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        done()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

