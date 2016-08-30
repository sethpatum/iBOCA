//
//  Demographics.swift
//  iBOCA
//
//  Created by Ellison Lim on 8/29/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit
import MessageUI
import AVFoundation
var name : String?
var age : String?
var MR : String?
var Gender : String?
var Education : String?
var Race : String?
var Ethnicity : String?


func makeAgeData() -> [String] {
    var str:[String] = []
    for i in 1...120 {
        str.append(String(i))
    }
    return str
}


class Demographics: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate,UIPickerViewDelegate {
    
    @IBOutlet weak var GenderPicker: UIPickerView!
    let genderData = ["Male", "Female", "Other", "Prefer Not To Say"]
    
    
    @IBOutlet weak var EducationPicker: UIPickerView!
    let educationData = ["< 9 yrs", "9-11 yrs", "High School Graduate", "Associates Degree", "Bachelors Degree", "Post Graduate Degree"]
    
    
    @IBOutlet weak var EthnicityPicker: UIPickerView!
    var ethnicData = ["Caucasian", "African American", "Latino", "Other"]
    
    @IBOutlet weak var RacePicker: UIPickerView!
    var raceData = ["English", "Spanish", "Other",]
    
    @IBOutlet weak var AgePicker: UIPickerView!
    var ageData:[String] = makeAgeData()
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var MRLabel: UILabel!
    @IBOutlet weak var MRField: UITextField!
    
    
    @IBAction func updateName(sender: AnyObject) {
        name = nameField.text
    }
    
    @IBAction func updateMR(sender: AnyObject) {
        MR = MRField.text
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AgePicker.delegate = self
        GenderPicker.delegate = self
        EthnicityPicker.delegate = self
        EducationPicker.delegate = self
        RacePicker.delegate = self
        
        
        
        name = ""
        MR = ""
        age = ageData[AgePicker.selectedRowInComponent(0)]
        Gender = genderData[GenderPicker.selectedRowInComponent(0)]
        Ethnicity = ethnicData[EthnicityPicker.selectedRowInComponent(0)]
        Education = educationData[EducationPicker.selectedRowInComponent(0)]
        Race = raceData[RacePicker.selectedRowInComponent(0)]
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
                    //pickerview setup
    func numberOfComponentsInPickerView(pickerView : UIPickerView!) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == AgePicker {
            return ageData.count
        } else if pickerView == GenderPicker {
            return genderData.count
        } else if pickerView == EthnicityPicker {
            return ethnicData.count
        } else if pickerView == EducationPicker {
            return educationData.count
        } else if pickerView == RacePicker {
            return raceData.count
        }
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == AgePicker {
            age = ageData[row]
            return ageData[row]
        } else if pickerView == GenderPicker {
            Gender = genderData[row]
            return genderData[row]
        } else if pickerView == EthnicityPicker {
            Ethnicity = ethnicData[row]
            return ethnicData[row]
        } else if pickerView == EducationPicker {
            Education = educationData[row]
            return educationData[row]
        } else if pickerView == RacePicker {
            Race = raceData[row]
            return raceData[row]
        }
       return ""
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == AgePicker {
            age = ageData[row]
        } else if pickerView == GenderPicker {
            Gender = genderData[row]
        } else if pickerView == EthnicityPicker {
            Ethnicity = ethnicData[row]
            if Ethnicity == "Other" {
                addOtherCondition(pickerView)
            }
        } else if pickerView == EducationPicker {
           Education = educationData[row]
        } else if pickerView == RacePicker {
            Race = raceData[row]
            if Race == "Other" {
                addOtherCondition(pickerView)
            }
        }
    }
    
    func addOtherCondition(pickerView:UIPickerView){
        let alert = UIAlertController(title: "Other", message: "Enter other ", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
            
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Done", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            //self.resultComments[self.count-startCount] = textField.text!
            let result = textField.text
            
            var cnt : Int = 0
            if pickerView == self.EthnicityPicker {
                self.ethnicData.append(result!)
                cnt = self.ethnicData.count
                Ethnicity = result!
            } else if pickerView == self.RacePicker {
                self.raceData.append(result!)
                cnt = self.raceData.count
                Race = result!
            }
            pickerView.reloadAllComponents()
            pickerView.selectRow(cnt-1, inComponent: 0, animated: true)
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func TestDone(sender: AnyObject) {
    print(name)
    print(MR)
    print(Gender)
    print(Ethnicity)
    print(Education)
    print(age)
    print(Race)
    }
}
