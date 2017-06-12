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
var startTime = Foundation.Date()


class OrientationTask:  ViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate,UIPickerViewDelegate  {
    
    var Week : String?
    var State : String?
    var Town : String?
    var Date : String?
    var Time : String?
    var TimeOK : Bool = false
    var DateOK : Bool = false
    
    
    //pickerview content set up(defines options)
    
    @IBOutlet weak var WeekPicker: UIPickerView!
    let weekData = ["Monday", "Tuesday", "Wednesday", "Thusday", "Friday", "Saturday", "Sunday", "Do not know"]
    
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
        let v = startTime.timeIntervalSince(d.date)
        if abs(v) < 60*60*24 {
            DateOK = true
        }
    }
    
    @IBOutlet weak var TownPicker: UIPickerView!
    let townData = ["Correct", "Incorrect"]
    
    
    @IBOutlet weak var currentTime: UIDatePicker!
    
    @IBAction func updateTime(_ sender: Any) {
        let d:UIDatePicker = sender as! UIDatePicker
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        Time = formatter.string(from: d.date)
        TimeOK = TimeDiffOK(date1: startTime, date2: d.date)
    }
    
    @IBAction func DontKnowDate(_ sender: Any) {
        Date = "Dont Know"
        currentDate.isUserInteractionEnabled = false
        currentDate.alpha = 0.5
        DateOK = false
    }
    
    
    @IBAction func DontKnowWeek(_ sender: Any) {
        Week = "Dont Know"
        WeekPicker.isUserInteractionEnabled = false
        WeekPicker.alpha = 0.5
    }
    
    
    @IBAction func DontKnowState(_ sender: Any) {
        State = "Dont Know"
        StatePicker.isUserInteractionEnabled = false
        StatePicker.alpha = 0.5
    }
    
    
    @IBAction func DontKnowTown(_ sender: Any) {
        Town = "Dont Know"
        TownPicker.isUserInteractionEnabled = false
        TownPicker.alpha = 0.5
    }
    
    @IBAction func DontKnowTime(_ sender: Any) {
        Time = "Dont Know"
        currentTime.isUserInteractionEnabled = false
        currentTime.alpha = 0.5
        TimeOK = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //declare pickerviews
        WeekPicker.delegate = self
        StatePicker.delegate = self
        TownPicker.delegate = self
        
        
        Town = townData[TownPicker.selectedRow(inComponent: 0)]
        State = stateData[StatePicker.selectedRow(inComponent: 0)]
        Week = weekData[WeekPicker.selectedRow(inComponent: 0)]
        
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        currentDate.setDate(formatter.date(from:"2017/01/01")!,  animated: false)
        Date = formatter.string(from: currentDate.date)
        DateOK = false
        
        
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        currentTime.setDate(formatter.date(from:"2017/01/01 12:00")!,  animated: false)
        formatter.dateFormat = "HH:MM"
        Time = formatter.string(from: currentTime.date)
        TimeOK = false
        
        
        currentDate.isUserInteractionEnabled = true
        currentTime.isUserInteractionEnabled = true
        WeekPicker.isUserInteractionEnabled = true
        StatePicker.isUserInteractionEnabled = true
        TownPicker.isUserInteractionEnabled = true
        currentDate.alpha = 1.0
        currentTime.alpha = 1.0
        WeekPicker.alpha = 1.0
        StatePicker.alpha = 1.0
        TownPicker.alpha = 1.0
        
        startTime = Foundation.Date()
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
        let result = Results()
        result.name = "Orientation"
        result.startTime = startTime
        result.endTime = Foundation.Date()
        
        result.json["Week Given"] = Week!
        result.json["State Given"] = State!
        result.json["Town Given"] = Town!
        result.json["Date Given"] = Date!
        result.json["Time Given"] = Time!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        let rightDate = formatter.string(from: startTime)
        result.json["Date Tested"] = rightDate
        formatter.dateFormat = "HH:MM"
        let rightTime = formatter.string(from: startTime)
        result.json["Time Tested"] = rightTime
        formatter.dateFormat = "EEEE"
        let rightWeek = formatter.string(from: startTime)
        result.json["Week Tested"] = rightWeek
        let WeekOK = rightWeek == Week!
        
        result.json["Time Correct"] = TimeOK
        result.json["Date Correct"] = DateOK
        result.json["Week Correct"] = WeekOK
        
        result.shortDescription = "State: \(State!) "
        if Town! != "Correct" {
            result.shortDescription = result.shortDescription! + "Town: \(Town!) "
        }
        if WeekOK == false {
            result.shortDescription = result.shortDescription! + " Week: \(Week!)(\(rightWeek)) "
        }
        if DateOK == false {
            result.shortDescription = result.shortDescription! + " Date: \(Date!)(\(rightDate)) "
        }
        if TimeOK == false {
            result.shortDescription = result.shortDescription! + " Time: \(Time!)(\(rightTime)) "
        }
        
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
        if pickerView == WeekPicker {
            return weekData.count
        }
        else if pickerView == StatePicker {
            return stateData.count
        }
        else if pickerView == TownPicker {
            return townData.count
        }
        return 1
    }
    
    ////sets the final variables to selected row of the pickerview's text
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("1:",pickerView)
        if pickerView == WeekPicker {
            Week = weekData[row]
            return weekData[row]
        }
        else if pickerView == StatePicker {
            State = stateData[row]
            return stateData[row]
        }
        else if pickerView == TownPicker {
            Town = townData[row]
            return townData[row]
        }
        
        return ""
    }
    
    //sets final variables to the selected row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print("2:", pickerView)
        if pickerView == WeekPicker {
            Week = weekData[row]
        }
        else if pickerView == StatePicker {
            State = stateData[row]
        }
        else if pickerView == TownPicker {
            Town = townData[row]
        }
    }
    
    func TimeDiffOK(date1: Date, date2: Date) -> Bool {
        var h1 = Calendar.current.component(.hour, from: date1)
        var h2 = Calendar.current.component(.hour, from: date2)
        let m1 = Calendar.current.component(.minute, from: date1)
        let m2 = Calendar.current.component(.minute, from: date2)
        
        // Deal with noon and 1PM
        if h1 == 12 && h2 == 1 {
            h2 = 13
        }
        if h1 == 1 && h2 == 12 {
            h1 = 13
        }
        return abs(h1*60 + m1 - h2*60 - m2) < 15*60
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
  */
}
