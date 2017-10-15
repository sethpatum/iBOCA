//
//  GoldStandard.swift
//  iBOCA
//
//  Created by saman on 10/15/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation
import UIKit

class GoldStandard: ViewController, UIPickerViewDelegate  {
    
    
    var startTime  = Foundation.Date()
    
    
    @IBOutlet weak var LetterFluency: UIPickerView!
    @IBOutlet weak var MotorGNG: UIPickerView!
    @IBOutlet weak var MYBerrors: UIPickerView!
    @IBOutlet weak var MYBcorrected: UIPickerView!
    @IBOutlet weak var MYBtime: UITextField!
    
    var buttonlist : [UIPickerView] = []
    let buttonval  = [30, 10, 12, 12]
    var buttonresults : [Int]  = [Int](repeating: 0, count: 4)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonlist.append(LetterFluency)
        buttonlist.append(MotorGNG)
        buttonlist.append(MYBerrors)
        buttonlist.append(MYBcorrected)
        
        for bl in buttonlist {
            bl.delegate = self
        }
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
                return
            }
        }
    }
    
    
    func done() {
        let result = Results()
        result.name = "Gold Standard Results"
        result.startTime = startTime
        result.endTime = Foundation.Date()
        result.json["Letter Fluncy"]     = buttonresults[0]
        result.json["Motor go / no-go"]  = buttonresults[1]
        result.json["Months of Year Backwards - Errors"]    = buttonresults[2]
        result.json["Months of Year Backwards - Corrected"] = buttonresults[3]
        result.json["Months of Year Backwards - Time"]    = MYBtime.text
        
        
      result.shortDescription = "GoldStandard"
        
        resultsArray.add(result)
        Status[TestGoldStandard] = TestStatus.Done
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


