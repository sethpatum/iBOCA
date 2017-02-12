//
//  ForwardDigitSpan.swift
//  iBOCA
//
//  Created by Ellison Lim on 8/2/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit

class ForwardDigitSpan: UIViewController {
     var test = 0
    
    @IBOutlet weak var countingLabel: UILabel!
    var timer = Timer()
    var counter = 0
    func updateCounter() {
        counter += 1
        countingLabel.text = String(counter)
    }
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var CurrentInput: UILabel!
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
    var Resultsp1: [String] = []
    var count = 0

    
    @IBAction func BackButton(_ sender: Any) {
        let result = Results()
        result.name = "Forward Digit Span"
        result.startTime = startTime
        result.endTime = Foundation.Date()
        
        for r in Resultsp1 {
            result.longDescription.add(r)
        }
        
        resultsArray.add(result)
        Status[TestForwardDigitSpan] = TestStatus.Done
        
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
        print (test)
        if(test >= 0 && test < 5){
        var num0 = String(arc4random_uniform(9))
        var num1 = String(arc4random_uniform(9))
            while num1 == num0{
            num1 = String(arc4random_uniform(9))
            }
        var num2 = String(arc4random_uniform(9))
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
            numOrder += [num0, num1, num2, num3]
        }
        if(test >= 1 && test < 5){
        var num4 = String(arc4random_uniform(9))
            while num4 == num3 {
                num4 = String(arc4random_uniform(9))
            }
            self.Label4.text = num4
            numOrder += [num4]
        }
        if(test >= 2 && test < 5){
        var num5 = String(arc4random_uniform(9))
            while num5 == num4 {
                num5 = String(arc4random_uniform(9))
            }
             self.Label5.text = num5
             numOrder += [num5]
        }
        if(test >= 3 && test < 5){
        var num6 = String(arc4random_uniform(9))
            while num6 == num5 {
                num6 = String(arc4random_uniform(9))
            }
            self.Label6.text = num6
             numOrder += [num6]
        }
        if(test >= 4 && test < 5){
            var num7 = String(arc4random_uniform(9))
            while num7 == num6 {
                num7 = String(arc4random_uniform(9))
            }
            self.Label7.text = num7
            numOrder += [num7]
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
        if(test < 4){
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
         timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(ForwardDigitSpan.updateCounter), userInfo: nil, repeats: true)
    }
    
    
    var responses = 0
    
    //var nums : [String] = []
    var nums1 = ""
    @IBAction func button0(_ sender: AnyObject) {
        numResponse.append("0")
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
    }
    
    @IBAction func button1(_ sender: AnyObject) {
         numResponse.append("1")
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
    }
    @IBAction func button2(_ sender: AnyObject) {
         numResponse.append("2")
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
 
    }
    @IBAction func button3(_ sender: AnyObject) {
         numResponse.append("3")
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

    }
    @IBAction func button4(_ sender: AnyObject) {
         numResponse.append("4")
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
 
    }
    @IBAction func button5(_ sender: AnyObject) {
         numResponse.append("5")
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
     
    }
    @IBAction func button6(_ sender: AnyObject) {
         numResponse.append("6")
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
  
    }
    @IBAction func button7(_ sender: AnyObject) {
         numResponse.append("7")
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
   
    }
    @IBAction func button8(_ sender: AnyObject) {
         numResponse.append("8")
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
  
    }
    @IBAction func button9(_ sender: AnyObject) {
         numResponse.append("9")
        print(numResponse)
        nums1 += numResponse[responses]
        CurrentNums.text = nums1
        responses += 1
        if (responses == (test + 4)){
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
        nums1 = ""
        CurrentNums.text = nums1
        Resultsp1 = (numOrder) + (numResponse)
        test += 1
        numResponse = []
        numOrder = []
        Randomize.isHidden = false
        responses = 0
        testDone.isHidden = true
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
            CurrentInput.isHidden = true
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
