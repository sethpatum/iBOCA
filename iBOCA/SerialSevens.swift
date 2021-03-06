//
//  SerialSevens.swift
//  iBOCA
//
//  Created by Ellison Lim on 8/5/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit

class SerialSevens: ViewController {
    var timer = Timer()
    var counter = 0
    var StartTime = Foundation.Date()
    
    var Records: [String] = []
    var responseNum = 0

    func updateCounter() {
        counter += 1
        countingLabel.text = String(counter)
    }
    
    var testCount = 0
    var resultTmpList : [String:Any] = [:]
    var resultList : [String:Any] = [:]
    
    var numErrors = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var expectedNums: UILabel!
    @IBOutlet weak var recordedNums: UILabel!
    @IBOutlet weak var currentNum: UILabel!
    
    @IBOutlet weak var Errors: UILabel!
    @IBOutlet weak var start100: UIButton!
    @IBOutlet weak var start90: UIButton!
    @IBOutlet weak var start80: UIButton!
    @IBOutlet weak var start70: UIButton!
    @IBOutlet weak var start60: UIButton!
    @IBOutlet weak var start50: UIButton! //start buttons
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton! //patient input buttons
    
    @IBOutlet weak var nextInput: UIButton!
    
    
    @IBOutlet weak var countingLabel: UILabel!
    var testName = 0
    var  correctNumb = 0
    
    @IBAction func backButton(_ sender: Any) { //appends to results upon clicking back
        let result = Results()
        result.name = "Serial Sevens"
        result.startTime = startTime
        result.endTime = Foundation.Date()
        result.numErrors = numErrors
        
        for r in Records {
            result.longDescription.add(r)
        }
        result.json["tested"] = resultList
        resultsArray.add(result)
        Status[TestSerialSevens] = TestStatus.Done
        
        let mainView = self.storyboard?.instantiateViewController(withIdentifier: "main")
        self.present(mainView!, animated:true)
    }
    
    
    func processSelect() {
        button0.isHidden = false
        button1.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
        button4.isHidden = false
        button5.isHidden = false
        button6.isHidden = false
        button7.isHidden = false
        button8.isHidden = false
        button9.isHidden = false
        resultTmpList.removeAll()
        StartTime = Foundation.Date()
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(SerialSevens.updateCounter), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func press100(_ sender: AnyObject) { //hides start buttons and selects the sequence for 100
        correctNumb = 93
        expectedNums.text = String(correctNumb)
        start90.isHidden = true
        start80.isHidden = true
        start70.isHidden = true
        start60.isHidden = true
        start50.isHidden = true
        testName = 100
        processSelect()
    }
    
    @IBAction func press90(_ sender: AnyObject) { //hides start buttons and selects the sequence for 90
        correctNumb = 83
        expectedNums.text = String(correctNumb)
        start100.isHidden = true
        start80.isHidden = true
        start70.isHidden = true
        start60.isHidden = true
        start50.isHidden = true
        testName = 90
        processSelect()
    }
    @IBAction func press80(_ sender: AnyObject) {
        correctNumb = 73
        expectedNums.text = String(correctNumb)
        start100.isHidden = true
        start90.isHidden = true
        start70.isHidden = true
        start60.isHidden = true
        start50.isHidden = true
        testName = 80
        processSelect()
    }
    @IBAction func press70(_ sender: AnyObject) {
        correctNumb = 63
        expectedNums.text = String(correctNumb)
        start90.isHidden = true
        start80.isHidden = true
        start100.isHidden = true
        start60.isHidden = true
        start50.isHidden = true
        testName = 70
        processSelect()
    }
    @IBAction func press60(_ sender: AnyObject) {
        correctNumb = 53
        expectedNums.text = String(correctNumb)
        start90.isHidden = true
        start80.isHidden = true
        start70.isHidden = true
        start100.isHidden = true
        start50.isHidden = true
        testName = 60
        processSelect()
    }
    @IBAction func press50(_ sender: AnyObject) {
        correctNumb = 43
        expectedNums.text = String(correctNumb)
        start90.isHidden = true
        start80.isHidden = true
        start70.isHidden = true
        start60.isHidden = true
        start100.isHidden = true
        testName = 50
        processSelect()
    }
    
    var recordNum : [Int] = []
    var numb = ""
    
    func processPress() {   //records the button press, and hides the other numbers
        print(recordNum)
        if (recordNum.count > 1 && recordNum.count < 3){
            numb = String(recordNum[0]) + String(recordNum[1])
            nextInput.isHidden = false
            button0.isEnabled = false
            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
            button4.isEnabled = false
            button5.isEnabled = false
            button6.isEnabled = false
            button7.isEnabled = false
            button8.isEnabled = false
            button9.isEnabled = false
        }
        else{
            numb = String(recordNum[0])
            nextInput.isHidden = true
        }
        currentNum.text = numb
    }
    
    @IBAction func press0(_ sender: AnyObject) {    //appends the pressed button to recordNum
        recordNum.append(0)
        processPress()
    }
    @IBAction func press1(_ sender: AnyObject) {
        recordNum.append(1)
        processPress()
    }
    @IBAction func press2(_ sender: AnyObject) {
        recordNum.append(2)
        processPress()
    }
    @IBAction func press3(_ sender: AnyObject) {
        recordNum.append(3)
        processPress()
    }
    @IBAction func press4(_ sender: AnyObject) {
        recordNum.append(4)
        processPress()
    }
    @IBAction func press5(_ sender: AnyObject) {
        recordNum.append(5)
        processPress()
    }
    @IBAction func press6(_ sender: AnyObject) {
        recordNum.append(6)
        processPress()
    }
    @IBAction func press7(_ sender: AnyObject) {
        recordNum.append(7)
        processPress()
    }
    @IBAction func press8(_ sender: AnyObject) {
        recordNum.append(8)
        processPress()
    }
    @IBAction func press9(_ sender: AnyObject) {
        recordNum.append(9)
        processPress()
    }
    
    @IBAction func ResetButton(_ sender: AnyObject) {   //clears recordNumb, hides the next button and reenables all buttons
        recordNum = []
        numb = ""
        nextInput.isHidden = true
        currentNum.text = numb
        button0.isEnabled = true
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
        button5.isEnabled = true
        button6.isEnabled = true
        button7.isEnabled = true
        button8.isEnabled = true
        button9.isEnabled = true
    }
    

    @IBAction func nextInput(_ sender: AnyObject) { //either records an error, or records as correct and moves onto the next step of the test
        let name = String(recordNum[0]) + String(recordNum[1])
        let num = Int(name)
        if num != correctNumb{
            numErrors += 1
            Errors.text = String(numErrors)
            correctNumb = num! - 7
            expectedNums.text = String(correctNumb)
        }
        if num == correctNumb{
        correctNumb = correctNumb - 7
            expectedNums.text = String(correctNumb)
        }
        recordNum = []
        currentNum.text = ""
        Records.append(name)
        let name2 = String(describing: Records)     //timer stops, displays answers and appends the input
        recordedNums.text = name2
        print(Records)
        timer.invalidate()
        counter = 0
        countingLabel.text = String(counter)
        
        let currTime = Foundation.Date()            //timer setup
        resultTmpList[String(responseNum)] = ["Value":name, "Time (msec)":Int(currTime.timeIntervalSince(startTime)*1000)]

        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(SerialSevens.updateCounter), userInfo: nil, repeats: true)
        nextInput.isHidden = true
        responseNum += 1
        

        if (responseNum >= 5){          //upon hitting 5 responses hides all buttons to prevent further input
            button0.isHidden = true
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = true
            button4.isHidden = true
            button5.isHidden = true
            button6.isHidden = true
            button7.isHidden = true
            button8.isHidden = true
            button9.isHidden = true
            nextInput.isHidden = true
            resetButton.isHidden = true
            start100.isHidden = true
            start90.isHidden = true
            start80.isHidden = true
            start70.isHidden = true
            start60.isHidden = true
            start50.isHidden = true
            timer.invalidate()
            countingLabel.isHidden = true
            timeLabel.isHidden = true
            
            resultList[String(testName)] = resultTmpList
          }
        button0.isEnabled = true
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
        button5.isEnabled = true
        button6.isEnabled = true
        button7.isEnabled = true
        button8.isEnabled = true
        button9.isEnabled = true
        
    }
    
    override func viewDidLoad() {           //hides input button at first
        super.viewDidLoad()
            button0.isHidden = true
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = true
            button4.isHidden = true
            button5.isHidden = true
            button6.isHidden = true
            button7.isHidden = true
            button8.isHidden = true
            button9.isHidden = true
            nextInput.isHidden = true
        
  //      result.res
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
