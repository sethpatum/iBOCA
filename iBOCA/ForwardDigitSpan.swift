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
    var timer = NSTimer()
    var counter = 0
    func updateCounter() {
        countingLabel.text = String(counter++)
        print(counter)
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
    
    @IBOutlet weak var Label0: UILabel!
    
    @IBOutlet weak var Label1: UILabel!

    @IBOutlet weak var Label2: UILabel!
    
    @IBOutlet weak var Label3: UILabel!
    
    @IBOutlet weak var Label4: UILabel!
   
    @IBOutlet weak var Label5: UILabel!
    
    @IBOutlet weak var Label6: UILabel!
    
    
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
    
    
    @IBAction func tester(sender: AnyObject) {
        print (test)
        if(test >= 0 && test < 4){
        let num0 = String(arc4random_uniform(9))
        let num1 = String(arc4random_uniform(9))
        let num2 = String(arc4random_uniform(9))
        let num3 = String(arc4random_uniform(9))
            self.Label0.text = num0
            self.Label1.text = num1
            self.Label2.text = num2
            self.Label3.text = num3
            numOrder += [num0, num1, num2, num3]
        }
        if(test >= 1 && test < 4){
        let num4 = String(arc4random_uniform(9))
            self.Label4.text = num4
            numOrder += [num4]
        }
        if(test >= 2 && test < 4){
        let num5 = String(arc4random_uniform(9))
             self.Label5.text = num5
             numOrder += [num5]
        }
        if(test >= 3 && test < 4){
        let num6 = String(arc4random_uniform(9))
             self.Label6.text = num6
             numOrder += [num6]
        }
        if(test >= 4){
            self.Label0.text = ""
            self.Label1.text = ""
            self.Label2.text = ""
            self.Label3.text = ""
            self.Label4.text = ""
            self.Label5.text = ""
            self.Label6.text = ""
        }
        print(numOrder)
        Randomize.hidden = true
        if(test < 4){
        button0.hidden = false
        button1.hidden = false
        button2.hidden = false
        button3.hidden = false
        button4.hidden = false
        button5.hidden = false
        button6.hidden = false
        button7.hidden = false
        button8.hidden = false
        button9.hidden = false
        resetButton.hidden = false
        }
         timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }
    
    
    var responses = 0
    
    //var nums : [String] = []
    var nums1 = ""
    @IBAction func button0(sender: AnyObject) {
        numResponse.append("0")
        print(numResponse)
        nums1 += numResponse[responses]
        CurrentNums.text = nums1
        responses += 1
        if ( responses == (test + 4)){
            testDone.hidden = false
        }
        if(responses >= (test + 4)){
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
            testDone.hidden = true
        }
    }
    
    @IBAction func button1(sender: AnyObject) {
         numResponse.append("1")
        print(numResponse)
        nums1 += numResponse[responses]
        CurrentNums.text = nums1
        responses += 1
        if ( responses == (test + 4)){
            testDone.hidden = false
        }
        if(responses >= (test + 4)){
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
            testDone.hidden = true
        }
    }
    @IBAction func button2(sender: AnyObject) {
         numResponse.append("2")
        print(numResponse)
        nums1 += numResponse[responses]
        CurrentNums.text = nums1
        responses += 1
        if ( responses == (test + 4)){
            testDone.hidden = false
        }
        if(responses >= (test + 4)){
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
            testDone.hidden = true
        }
 
    }
    @IBAction func button3(sender: AnyObject) {
         numResponse.append("3")
        print(numResponse)
        nums1 += numResponse[responses]
        CurrentNums.text = nums1
        responses += 1
        if ( responses == (test + 4)){
            testDone.hidden = false
        }
        if(responses >= (test + 4)){
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
            testDone.hidden = true
        }

    }
    @IBAction func button4(sender: AnyObject) {
         numResponse.append("4")
        print(numResponse)
        nums1 += numResponse[responses]
        CurrentNums.text = nums1
        responses += 1
        if ( responses == (test + 4)){
            testDone.hidden = false
        }
        if(responses >= (test + 4)){
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
            testDone.hidden = true
        }
 
    }
    @IBAction func button5(sender: AnyObject) {
         numResponse.append("5")
        print(numResponse)
        nums1 += numResponse[responses]
        CurrentNums.text = nums1
        responses += 1
        if ( responses == (test + 4)){
            testDone.hidden = false
        }
        if(responses >= (test + 4)){
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
            testDone.hidden = true
        }
     
    }
    @IBAction func button6(sender: AnyObject) {
         numResponse.append("6")
        print(numResponse)
        nums1 += numResponse[responses]
        CurrentNums.text = nums1
        responses += 1
        if ( responses == (test + 4)){
            testDone.hidden = false
        }
        if(responses >= (test + 4)){
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
            testDone.hidden = true
        }
  
    }
    @IBAction func button7(sender: AnyObject) {
         numResponse.append("7")
        print(numResponse)
        nums1 += numResponse[responses]
        CurrentNums.text = nums1
        responses += 1
        if ( responses == (test + 4)){
            testDone.hidden = false
        }
        if(responses >= (test + 4)){
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
            testDone.hidden = true
        }
   
    }
    @IBAction func button8(sender: AnyObject) {
         numResponse.append("8")
        print(numResponse)
        nums1 += numResponse[responses]
        CurrentNums.text = nums1
        responses += 1
        if ( responses == (test + 4)){
            testDone.hidden = false
        }
        if(responses >= (test + 4)){
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
            testDone.hidden = true
        }
  
    }
    @IBAction func button9(sender: AnyObject) {
         numResponse.append("9")
        print(numResponse)
        nums1 += numResponse[responses]
        CurrentNums.text = nums1
        responses += 1
        if (responses == (test + 4)){
            testDone.hidden = false
        }
        if(responses >= (test + 4)){
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
            testDone.hidden = true
        }
 
    }
    
    
    @IBAction func ResetButton(sender: AnyObject) {
        numResponse = []
        responses = 0
        testDone.hidden = true
        nums1 = ""
        CurrentNums.text = ""
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
    
    var Results: [String] = []
    var count = 0
    
    @IBAction func testDone(sender: AnyObject) {
        timer.invalidate()
        counter = 0
        countingLabel.text = String(counter)
        nums1 = ""
        CurrentNums.text = nums1
        if (numResponse == numOrder){
            print("All values Correct")
            Results.append("All values Correct")
        }
        if(numResponse[0] != numOrder[0]){
         print(" for Number 1, Expected: " + numOrder[0] + " Got: " + numResponse[0])
            Results.append(" for Number 1, Expected: " + numOrder[0] + " Got: " + numResponse[0])
        }
        if(numResponse[1] != numOrder[1]){
         print(" for Number 2, Expected: " + numOrder[1] + " Got: " + numResponse[1])
            Results.append(" for Number 2, Expected: " + numOrder[1] + " Got: " + numResponse[1])
            count+=1
        }
        if(numResponse[2] != numOrder[2]){
          print(" for Number 3, Expected: " + numOrder[2] + " Got: " + numResponse[2])
            Results.append(" for Number 3, Expected: " + numOrder[2] + " Got: " + numResponse[2])
            count+=1
        }
        if(numResponse[3] != numOrder[3]){
          print(" for Number 5, Expected: " + numOrder[3] + " Got: " + numResponse[3])
            Results.append(" for Number 4, Expected: " + numOrder[3] + " Got: " + numResponse[3])
            count+=1
        }
        if (test >= 1){
            if(numResponse[4] != numOrder[4]){
                print(" for Number 5, Expected: " + numOrder[4] + " Got: " + numResponse[4])
                Results.append(" for Number 5, Expected: " + numOrder[4] + " Got: " + numResponse[4])
                count+=1
            }
        }
        if (test >= 2){
            if(numResponse[5] != numOrder[5]){
                print(" for Number 6, Expected: " + numOrder[5] + " Got: " + numResponse[5])
                Results.append(" for Number 6, Expected: " + numOrder[5] + " Got: " + numResponse[5])
                count+=1
            }
        }
        if (test >= 3){
            if(numResponse[6] != numOrder[6]){
                print(" for Number 7, Expected: " + numOrder[6] + " Got: " + numResponse[6])
                Results.append(" for Number 7, Expected: " + numOrder[6] + " Got: " + numResponse[6])
                count+=1
            }

        }
        
        self.resultLabel.text = "\(Results)"
         test += 1
        numResponse = []
        numOrder = []
        Randomize.hidden = false
        responses = 0
        testDone.hidden = true
        if (test >= 4){
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
            self.instruct1.text = ""
            self.instruct2.text = ""
            resetButton.hidden = true
            countingLabel.hidden = true
            CurrentInput.hidden = true
            timerLabel.hidden = true
            timer.invalidate()
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testDone.hidden = true
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
        resetButton.hidden = true
        // Do any additional setup after loading the view.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
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
