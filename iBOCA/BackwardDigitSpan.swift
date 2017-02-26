//
//  BackwardDigitSpan.swift
//  iBOCA
//
//  Created by Ellison Lim on 8/3/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit

class BackwardDigitSpan: UIViewController {
    
    @IBOutlet weak var countingLabel: UILabel!
    
    var timer = Timer()
    var counter = 0
    func updateCounter() {
        counter += 1
        countingLabel.text = String(counter)
    }
    
    var test = 0
    var errors = 0
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var currentInput: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var CurrentNums: UILabel!
    @IBOutlet weak var instruct1: UILabel!
    @IBOutlet weak var instruct2: UILabel!
    
    @IBOutlet weak var Randomize: UIButton!
    
    @IBOutlet weak var testDone: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var resultLabel2: UILabel!
    @IBOutlet weak var Label0: UILabel!
    
    @IBOutlet weak var Label1: UILabel!
    
    @IBOutlet weak var Label2: UILabel!
    
    @IBOutlet weak var Label3: UILabel!
    
    @IBOutlet weak var Label4: UILabel!
    
    @IBOutlet weak var Label5: UILabel!
    
    @IBOutlet weak var Label6: UILabel!
    
    @IBOutlet weak var Label7: UILabel!
    
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
    
    
    var numResponse : [String] = []
    var numOrder : [String] = []
    
    var ResultsList: [String] = []
    var count = 0
    var numNum : u_long = 0
    
    var resultTmpList : [String:Any] = [:]
    var resultList : [String:Any] = [:]
    
    var startTime = Foundation.Date()
    var startSetTime = Foundation.Date()

    
    @IBAction func BackButton(_ sender: Any) {
      
        let result = Results()
        result.name = "Backward Digit Span"
        result.startTime = startTime
        result.endTime = Foundation.Date()
        
        for r in ResultsList {
            result.longDescription.add(r)
        }
        result.json = resultList
        resultsArray.add(result)
        Status[TestBackwardsDigitSpan] = TestStatus.Done
        
        let mainView = self.storyboard?.instantiateViewController(withIdentifier: "main")
        self.present(mainView!, animated:true)
    }
    
    @IBAction func tester(_ sender: AnyObject) {
        var num0 = " "
        var num1 = " "
        var num2 = " "
        var num3 = " "
        var num4 = " "
        var num5 = " "
        var num6 = " "
        var num7 = " "
        if(test >= 0 && test < 5){
             num0 = String(arc4random_uniform(9))
             num1 = String(arc4random_uniform(9))
            while num1 == num0{
                num1 = String(arc4random_uniform(9))
            }
             num2 = String(arc4random_uniform(9))
            while num2 == num1 {
                num2 = String(arc4random_uniform(9))
            }
             num3 = String(arc4random_uniform(9))
            while num3 == num2 {
                num3 = String(arc4random_uniform(9))
            }
            self.Label0.text = num0
            self.Label1.text = num1
            self.Label2.text = num2
            self.Label3.text = num3
            numOrder.append(num3)
            numOrder.append(num2)
            numOrder.append(num1)
            numOrder.append(num0)
        }
        if(test >= 1 && test < 5){
            num4 = String(arc4random_uniform(9))
            while num4 == num3 {
                num4 = String(arc4random_uniform(9))
            }
            self.Label4.text = num4
            numOrder.insert(num4, at:0)
        }
        if(test >= 2 && test < 5){
            num5 = String(arc4random_uniform(9))
            while num5 == num4 {
                num5 = String(arc4random_uniform(9))
            }
            self.Label5.text = num5
            numOrder.insert(num5, at:0)
        }
        if(test >= 3 && test < 5){
            num6 = String(arc4random_uniform(9))
            while num6 == num5 {
                num6 = String(arc4random_uniform(9))
            }
            self.Label6.text = num6
            numOrder.insert(num6, at:0)
        }
        if(test >= 4 && test < 5){
            num7 = String(arc4random_uniform(9))
            while num7 == num6 {
                num7 = String(arc4random_uniform(9))
            }
            self.Label7.text = num7
            numOrder.insert(num7, at:0)
        }
        if(test >= 5){
            self.Label0.text = ""
            self.Label1.text = ""
            self.Label2.text = ""
            self.Label3.text = ""
            self.Label4.text = ""
            self.Label5.text = ""
            self.Label6.text = ""
            self.Label7.text = ""
        }
        print(numOrder)
        Randomize.isHidden = true
        if(test < 5){
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
            resetButton.isHidden = false
        }
        
        startSetTime = Foundation.Date()
        resultTmpList.removeAll()
        numNum = 0
        for i in numOrder {
            numNum = numNum*10 + u_long(i)!
        }

         timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(BackwardDigitSpan.updateCounter), userInfo: nil, repeats: true)
    }
    
    
    var responses = 0
    
    var nums1 = ""
    
    
    func processButton() {
        print(numResponse)
        nums1 += numResponse[responses]
        CurrentNums.text = nums1
        responses += 1
        if ( responses == (test + 4)){
            testDone.isHidden = false
        }
        if(responses >= (test + 4)){
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
            testDone.isHidden = true
        }
        let currTime = Foundation.Date()
        resultTmpList[String(responses)] = ["Value":numResponse.last!, "Time (ms)":Int(currTime.timeIntervalSince(startSetTime)*1000)]
      
    }
    
    @IBAction func button0(_ sender: AnyObject) {
        numResponse.append("0")
        processButton()
    }
    @IBAction func button1(_ sender: AnyObject) {
        numResponse.append("1")
        processButton()
    }
    @IBAction func button2(_ sender: AnyObject) {
        numResponse.append("2")
        processButton()
    }
    @IBAction func button3(_ sender: AnyObject) {
        numResponse.append("3")
        processButton()
    }
    @IBAction func button4(_ sender: AnyObject) {
        numResponse.append("4")
        processButton()
    }
    @IBAction func button5(_ sender: AnyObject) {
        numResponse.append("5")
        processButton()
    }
    @IBAction func button6(_ sender: AnyObject) {
        numResponse.append("6")
        processButton()
    }
    @IBAction func button7(_ sender: AnyObject) {
        numResponse.append("7")
        processButton()
    }
    @IBAction func button8(_ sender: AnyObject) {
        numResponse.append("8")
        processButton()
    }
    @IBAction func button9(_ sender: AnyObject) {
        numResponse.append("9")
        processButton()
    }
    
    
    @IBAction func ResetButton(_ sender: AnyObject) {
        numResponse = []
        responses = 0
        testDone.isHidden = true
        nums1 = ""
        CurrentNums.text = ""
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

    
    @IBAction func testDone(_ sender: AnyObject) {
        timer.invalidate()
        counter = 0
        countingLabel.text = String(counter)
        let orderNums = String(describing: numResponse)
        let originalNums = String(describing: numOrder)
        self.resultLabel.text = originalNums
        self.resultLabel2.text = orderNums
        if orderNums != originalNums{
            errors += 1
        }
        nums1 = ""
        CurrentNums.text = nums1
        ResultsList = (numOrder) + (numResponse)
        test += 1
        numResponse = []
        numOrder = []
        Randomize.isHidden = false
        responses = 0
        testDone.isHidden = true
        resultList[String(test)] = ["Number":numNum, "Digits":resultTmpList, "Errors":errors]
        if (test >= 5){
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
            self.instruct1.text = ""
            self.instruct2.text = ""
            resetButton.isHidden = true
            countingLabel.isHidden = true
            currentInput.isHidden = true
            timerLabel.isHidden = true
             timer.invalidate() 
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testDone.isHidden = true
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
        resetButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     */
    
    
}
