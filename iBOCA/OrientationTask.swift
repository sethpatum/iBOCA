//
//  OrientationTask.swift
//  iBOCA
//
//  Created by Ellison Lim on 8/1/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit
import MessageUI

var firstTimeThrough = true
                    //declare variables to be defined by pickerviews
var Season : String?
var State : String?
var Town : String?
var Address : String?
var Date : String?

var startTime = Foundation.Date()

class OrientationTask:  ViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate,UIPickerViewDelegate  {
    
            //pickerview content set up(defines options)
    @IBOutlet weak var SeasonPicker: UIPickerView!
    let seasonData = ["Spring", "Summer", "Fall", "Winter", "Do not know"]
 
    @IBOutlet weak var StatePicker: UIPickerView!
    let stateData = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia","Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming", "Don't Know"]
   
    @IBOutlet weak var currentDate: UIDatePicker!
    
    var body:String?
    //text field input and results
    
    @IBAction func updateDate(_ sender: AnyObject) {
        let d:UIDatePicker = sender as! UIDatePicker
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        Date = formatter.string(from: d.date)
    }
    
    @IBOutlet weak var TownPicker: UIPickerView!
    let townData = ["Correct", "Incorrect"]
    
    @IBOutlet weak var AddressPicker: UIPickerView!
    let addressData = ["Correct", "Incorrect"]
    
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
                                //declare pickerviews
        SeasonPicker.delegate = self
        StatePicker.delegate = self
        TownPicker.delegate = self
        AddressPicker.delegate = self
        
       /* // load the defaults from presistant memory
        emailOn = !NSUserDefaults.standardUserDefaults().boolForKey("emailOff")
        resultsDisplayOn = !NSUserDefaults.standardUserDefaults().boolForKey("resultsDisplayOff")
        announceOn = NSUserDefaults.standardUserDefaults().boolForKey("announceOn")
        cloudOn = !NSUserDefaults.standardUserDefaults().boolForKey("cloudOff")
        testmodeOn = NSUserDefaults.standardUserDefaults().boolForKey("testmodeOn")
        
        uniqueName = UIDevice.currentDevice().identifierForVendor!.UUIDString
        ipadName = UIDevice.currentDevice().name
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("emailAddress") != nil) {
            emailAddress = NSUserDefaults.standardUserDefaults().objectForKey("emailAddress") as! String
        }
        */
        
        Town = townData[TownPicker.selectedRow(inComponent: 0)]
        Address = addressData[AddressPicker.selectedRow(inComponent: 0)]
        State = stateData[StatePicker.selectedRow(inComponent: 0)]
        Season = seasonData[SeasonPicker.selectedRow(inComponent: 0)]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        Date = formatter.string(from: currentDate.date)
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
        body = textView.text
        
        if text == "\n" {
            textView.resignFirstResponder()
            
            return false
        }
        
        return true
    }

    @IBAction func DoneButton(_ sender: AnyObject) {
       /* var Results: [String] = [];
        Results.append(Season!)
        Results.append(State!)
        Results.append(Town!)
        Results.append(Date!)
        Results.append(Address!)
        print(Results)
        */
        let result = Results()
        result.name = "Orientation"
        result.startTime = startTime
        result.endTime = Foundation.Date()
        result.shortDescription = "Season: \(Season), State: \(State), Town: \(Town), Date: \(Date), Address: \(Address)"
        resultsArray.add(result)
        Status[TestOrientation] = TestStatus.Done
    }
    //pickerview setup and whatnot
    
    func numberOfComponentsInPickerView(_ pickerView : UIPickerView!) -> Int{
        return 1
    }
        //returns length of pickerview contents
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        print("0:", pickerView)
        if pickerView == SeasonPicker {
            return seasonData.count
        }
        else if pickerView == StatePicker {
            return stateData.count
        }
        else if pickerView == TownPicker {
            return townData.count
        }
        else if pickerView == AddressPicker {
            return addressData.count
        }
        return 1
    }
            ////sets the final variables to selected row of the pickerview's text
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("1:",pickerView)
        if pickerView == SeasonPicker {
            Season = seasonData[row]
            return seasonData[row]
        }
        else if pickerView == StatePicker {
            State = stateData[row]
            return stateData[row]
        }
        else if pickerView == TownPicker {
            Town = townData[row]
            return townData[row]
        }
 
        else if pickerView == AddressPicker {
            Address = addressData[row]
            return addressData[row]
        }
        return ""
    }
        //sets final variables to the selected row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print("2:", pickerView)
        if pickerView == SeasonPicker {
            Season = seasonData[row]
        }
        else if pickerView == StatePicker {
            State = stateData[row]
        }
        else if pickerView == TownPicker {
            Town = townData[row]
        }
        else if pickerView == AddressPicker {
            Address = addressData[row]
        }
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
  */
    
 
    
    
}
