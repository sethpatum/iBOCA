//
//  SerialSevens.swift
//  iBOCA
//
//  Created by Ellison Lim on 8/5/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit

class SerialSevens: UIViewController {
    var timer = NSTimer()
    var counter = 0
    
    func updateCounter() {
        countingLabel.text = String(counter++)
    }
    
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var expectedNums: UILabel!
    @IBOutlet weak var recordedNums: UILabel!
    @IBOutlet weak var currentNum: UILabel!
    
    @IBOutlet weak var start100: UIButton!
    @IBOutlet weak var start90: UIButton!
    @IBOutlet weak var start80: UIButton!
    @IBOutlet weak var start70: UIButton!
    @IBOutlet weak var start60: UIButton!
    @IBOutlet weak var start50: UIButton!
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    @IBOutlet weak var nextInput: UIButton!
    
    
    @IBOutlet weak var countingLabel: UILabel!
    var expectedNum : [Int] = []
    
    @IBAction func press100(sender: AnyObject) {
        expectedNums.text = "93, 86, 79, 72, 65"
        start90.hidden = true
        start80.hidden = true
        start70.hidden = true
        start60.hidden = true
        start50.hidden = true
        button0.hidden = false ; button1.hidden = false ; button2.hidden = false
        button3.hidden = false ; button4.hidden = false ; button5.hidden = false
        button6.hidden = false ; button7.hidden = false ; button8.hidden = false
        button9.hidden = false
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }
    
    @IBAction func press90(sender: AnyObject) {
        expectedNums.text = "83, 76, 69, 62, 55"
        start100.hidden = true
        start80.hidden = true
        start70.hidden = true
        start60.hidden = true
        start50.hidden = true
        
        button0.hidden = false ; button1.hidden = false ; button2.hidden = false
        button3.hidden = false ; button4.hidden = false ; button5.hidden = false
        button6.hidden = false ; button7.hidden = false ; button8.hidden = false
        button9.hidden = false
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }
    @IBAction func press80(sender: AnyObject) {
        expectedNums.text = "73, 66, 59, 52, 45"
        start100.hidden = true
        start90.hidden = true
        start70.hidden = true
        start60.hidden = true
        start50.hidden = true
        
        button0.hidden = false ; button1.hidden = false ; button2.hidden = false
        button3.hidden = false ; button4.hidden = false ; button5.hidden = false
        button6.hidden = false ; button7.hidden = false ; button8.hidden = false
        button9.hidden = false
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }
    @IBAction func press70(sender: AnyObject) {
       expectedNums.text = "63, 56, 49, 42, 35"
        start90.hidden = true
        start80.hidden = true
        start100.hidden = true
        start60.hidden = true
        start50.hidden = true
        
        button0.hidden = false ; button1.hidden = false ; button2.hidden = false
        button3.hidden = false ; button4.hidden = false ; button5.hidden = false
        button6.hidden = false ; button7.hidden = false ; button8.hidden = false
        button9.hidden = false
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }
    @IBAction func press60(sender: AnyObject) {
       expectedNums.text = "53, 46, 39, 32, 25"
        start90.hidden = true
        start80.hidden = true
        start70.hidden = true
        start100.hidden = true
        start50.hidden = true
        
        button0.hidden = false ; button1.hidden = false ; button2.hidden = false
        button3.hidden = false ; button4.hidden = false ; button5.hidden = false
        button6.hidden = false ; button7.hidden = false ; button8.hidden = false
        button9.hidden = false
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }
    @IBAction func press50(sender: AnyObject) {
       expectedNums.text = "43, 36, 29, 22, 15"
        start90.hidden = true
        start80.hidden = true
        start70.hidden = true
        start60.hidden = true
        start100.hidden = true
        
        button0.hidden = false ; button1.hidden = false ; button2.hidden = false
        button3.hidden = false ; button4.hidden = false ; button5.hidden = false
        button6.hidden = false ; button7.hidden = false ; button8.hidden = false
        button9.hidden = false
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }
    var recordNum : [Int] = []
    var numb = ""
    @IBAction func press0(sender: AnyObject) {
        recordNum.append(0)
        print(recordNum)
        
        if (recordNum.count > 1){
            numb = String(recordNum[0]) + String(recordNum[1])
            button0.enabled = false
            button1.enabled = false
            button2.enabled = false
            button3.enabled = false
            button4.enabled = false
            button5.enabled = false
            button6.enabled = false
            button7.enabled = false
            button8.enabled = false
            button9.enabled = false
        }
        else{
             numb = String(recordNum[0])
        }
        currentNum.text = numb
    }
    @IBAction func press1(sender: AnyObject) {
        recordNum.append(1)
        print(recordNum)
        if (recordNum.count > 1){
             numb = String(recordNum[0]) + String(recordNum[1])
            button0.enabled = false
            button1.enabled = false
            button2.enabled = false
            button3.enabled = false
            button4.enabled = false
            button5.enabled = false
            button6.enabled = false
            button7.enabled = false
            button8.enabled = false
            button9.enabled = false
        }
        else{
             numb = String(recordNum[0])
        }
        currentNum.text = numb
    }
    @IBAction func press2(sender: AnyObject) {
        recordNum.append(2)
        print(recordNum)
        if (recordNum.count > 1 && recordNum.count < 3){
            numb = String(recordNum[0]) + String(recordNum[1])
            nextInput.hidden = false
            button0.enabled = false
            button1.enabled = false
            button2.enabled = false
            button3.enabled = false
            button4.enabled = false
            button5.enabled = false
            button6.enabled = false
            button7.enabled = false
            button8.enabled = false
            button9.enabled = false
        }
        else{
            numb = String(recordNum[0])
            nextInput.hidden = true
        }
        currentNum.text = numb
    }
    @IBAction func press3(sender: AnyObject) {
        recordNum.append(3)
        print(recordNum)
        if (recordNum.count > 1 && recordNum.count < 3){
            numb = String(recordNum[0]) + String(recordNum[1])
            nextInput.hidden = false
            button0.enabled = false
            button1.enabled = false
            button2.enabled = false
            button3.enabled = false
            button4.enabled = false
            button5.enabled = false
            button6.enabled = false
            button7.enabled = false
            button8.enabled = false
            button9.enabled = false
        }
        else{
            numb = String(recordNum[0])
            nextInput.hidden = true
        }
        currentNum.text = numb
    }
    @IBAction func press4(sender: AnyObject) {
        recordNum.append(4)
        print(recordNum)
        if (recordNum.count > 1 && recordNum.count < 3){
            numb = String(recordNum[0]) + String(recordNum[1])
            nextInput.hidden = false
            button0.enabled = false
            button1.enabled = false
            button2.enabled = false
            button3.enabled = false
            button4.enabled = false
            button5.enabled = false
            button6.enabled = false
            button7.enabled = false
            button8.enabled = false
            button9.enabled = false
        }
        else{
            numb = String(recordNum[0])
            nextInput.hidden = true
        }
        currentNum.text = numb
    }
    @IBAction func press5(sender: AnyObject) {
        recordNum.append(5)
        print(recordNum)
        if (recordNum.count > 1 && recordNum.count < 3){
            numb = String(recordNum[0]) + String(recordNum[1])
            nextInput.hidden = false
            button0.enabled = false
            button1.enabled = false
            button2.enabled = false
            button3.enabled = false
            button4.enabled = false
            button5.enabled = false
            button6.enabled = false
            button7.enabled = false
            button8.enabled = false
            button9.enabled = false
        }
        else{
            numb = String(recordNum[0])
            nextInput.hidden = true
        }
        currentNum.text = numb
    }
    @IBAction func press6(sender: AnyObject) {
        recordNum.append(6)
        print(recordNum)
        if (recordNum.count > 1 && recordNum.count < 3){
            numb = String(recordNum[0]) + String(recordNum[1])
            nextInput.hidden = false
            button0.enabled = false
            button1.enabled = false
            button2.enabled = false
            button3.enabled = false
            button4.enabled = false
            button5.enabled = false
            button6.enabled = false
            button7.enabled = false
            button8.enabled = false
            button9.enabled = false
        }
        else{
            numb = String(recordNum[0])
            nextInput.hidden = true
        }
        currentNum.text = numb
    }
    @IBAction func press7(sender: AnyObject) {
        recordNum.append(7)
        print(recordNum)
        if (recordNum.count > 1 && recordNum.count < 3){
            numb = String(recordNum[0]) + String(recordNum[1])
            nextInput.hidden = false
            button0.enabled = false
            button1.enabled = false
            button2.enabled = false
            button3.enabled = false
            button4.enabled = false
            button5.enabled = false
            button6.enabled = false
            button7.enabled = false
            button8.enabled = false
            button9.enabled = false
        }
        else{
            numb = String(recordNum[0])
            nextInput.hidden = true
        }
        currentNum.text = numb
    }
    @IBAction func press8(sender: AnyObject) {
        recordNum.append(8)
        print(recordNum)
        if (recordNum.count > 1 && recordNum.count < 3){
            numb = String(recordNum[0]) + String(recordNum[1])
            nextInput.hidden = false
            button0.enabled = false
            button1.enabled = false
            button2.enabled = false
            button3.enabled = false
            button4.enabled = false
            button5.enabled = false
            button6.enabled = false
            button7.enabled = false
            button8.enabled = false
            button9.enabled = false
        }
        else{
            numb = String(recordNum[0])
            nextInput.hidden = true
        }
        currentNum.text = numb
    }
    @IBAction func press9(sender: AnyObject) {
        recordNum.append(9)
        print(recordNum)
        if (recordNum.count > 1 && recordNum.count < 3){
            numb = String(recordNum[0]) + String(recordNum[1])
            nextInput.hidden = false
            button0.enabled = false
            button1.enabled = false
            button2.enabled = false
            button3.enabled = false
            button4.enabled = false
            button5.enabled = false
            button6.enabled = false
            button7.enabled = false
            button8.enabled = false
            button9.enabled = false
        }
        else{
            numb = String(recordNum[0])
            nextInput.hidden = true
        }
        currentNum.text = numb
    }
    
    @IBAction func ResetButton(sender: AnyObject) {
        recordNum = []
        numb = ""
        nextInput.hidden = true
        currentNum.text = numb
        button0.enabled = true
        button1.enabled = true
        button2.enabled = true
        button3.enabled = true
        button4.enabled = true
        button5.enabled = true
        button6.enabled = true
        button7.enabled = true
        button8.enabled = true
        button9.enabled = true
    }
    
    var Records: [String] = []
    var responseNum = 0
    @IBAction func nextInput(sender: AnyObject) {
        let name = String(recordNum[0]) + String(recordNum[1])
        recordNum = []
        currentNum.text = ""
        Records.append(name)
        let name2 = String(Records)
        recordedNums.text = name2
        print(Records)
        timer.invalidate()
        counter = 0
        countingLabel.text = String(counter)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        nextInput.hidden = true
        responseNum += 1
        if (responseNum >= 5){
            button0.hidden = true
            button1.hidden = true
            button2.hidden = true
            button3.hidden = true
            button4.hidden = true
            button5.hidden = true
            button6.hidden = true
            button7.hidden = true
            button8.hidden = true
            button9.hidden = true
            nextInput.hidden = true
            resetButton.hidden = true
            start100.hidden = true
            start90.hidden = true
            start80.hidden = true
            start70.hidden = true
            start60.hidden = true
            start50.hidden = true
            timer.invalidate()
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            button0.hidden = true
            button1.hidden = true
            button2.hidden = true
            button3.hidden = true
            button4.hidden = true
            button5.hidden = true
            button6.hidden = true
            button7.hidden = true
            button8.hidden = true
            button9.hidden = true
            nextInput.hidden = true
        
        
        func updateCounter() {
            countingLabel.text = String(counter++)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}