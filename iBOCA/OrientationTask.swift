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

var Season : String?
var State : String?
var Town : String?
var Address : String?
var Date : String?
class OrientationTask:  ViewController {
    

    @IBOutlet weak var SeasonPicker: UIPickerView!
    let seasonData = ["Spring", "Summer", "Fall", "Winter", "Don't know"]
 
    @IBOutlet weak var StatePicker: UIPickerView!
    let stateData = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia","Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    
    @IBAction func updateDate(sender: AnyObject) {
        let d:UIDatePicker = sender as! UIDatePicker
        let formatter = NSDateFormatter()
        formatter.dateFormat = "y-MM-dd"
        Date = formatter.stringFromDate(d.date)
    }
    
    @IBOutlet weak var addressField: UITextField!
    @IBAction func updateAddress(sender: AnyObject) {
        Address = addressField.text
    }
    
    @IBOutlet weak var townField: UITextField!
    @IBAction func updateTown(sender: AnyObject) {
         Town = townField.text
        
        
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
