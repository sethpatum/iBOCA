//
//  ForwardDigitSpan.swift
//  iBOCA
//
//  Created by Ellison Lim on 8/2/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit

class ForwardDigitSpan: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var Label0: UILabel!
    
    @IBOutlet weak var Label1: UILabel!

    @IBOutlet weak var Label2: UILabel!
    
    @IBOutlet weak var Label3: UILabel!
    
    @IBOutlet weak var Label4: UILabel!
   
    @IBOutlet weak var Label5: UILabel!
    
    @IBOutlet weak var Label6: UILabel!
    
    var numResponse : [String] = []
    var numOrder : [String] = []
    
    @IBAction func tester(sender: AnyObject) {
        let num0 = String(arc4random_uniform(9))
        let num1 = String(arc4random_uniform(9))
        let num2 = String(arc4random_uniform(9))
        let num3 = String(arc4random_uniform(9))
        let num4 = String(arc4random_uniform(9))
        let num5 = String(arc4random_uniform(9))
        let num6 = String(arc4random_uniform(9))
        
        self.Label0.text = num0
        self.Label1.text = num1
        self.Label2.text = num2
        self.Label3.text = num3
        self.Label4.text = num4
        self.Label5.text = num5
        self.Label6.text = num6
        
        print(num0)
        print(num1)
        print(num2)
        print(num3)
        print(num4)
        print(num5)
        print(num6)
        print("LineBreak")
        numOrder += [num0, num1, num2, num3, num4, num5, num6]
        print(numOrder)
        
    }
    
    
    
    @IBAction func button0(sender: AnyObject) {
        numResponse.append("0")
        print(numResponse)
    }
    
    @IBAction func button1(sender: AnyObject) {
         numResponse.append("1")
        print(numResponse)
    }
    @IBAction func button2(sender: AnyObject) {
         numResponse.append("2")
        print(numResponse)
    }
    @IBAction func button3(sender: AnyObject) {
         numResponse.append("3")
        print(numResponse)
    }
    @IBAction func button4(sender: AnyObject) {
         numResponse.append("4")
        print(numResponse)
    }
    @IBAction func button5(sender: AnyObject) {
         numResponse.append("5")
        print(numResponse)
    }
    @IBAction func button6(sender: AnyObject) {
         numResponse.append("6")
        print(numResponse)
    }
    @IBAction func button7(sender: AnyObject) {
         numResponse.append("7")
        print(numResponse)
    }
    @IBAction func button8(sender: AnyObject) {
         numResponse.append("8")
        print(numResponse)
    }
    @IBAction func button9(sender: AnyObject) {
         numResponse.append("9")
        print(numResponse)
    }
    

    var Results: [String] = []
    var count = 0
    @IBAction func testDone(sender: AnyObject) {
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
            count+=1
        }
        if(numResponse[3] != numOrder[3]){
          print(" for Number 5, Expected: " + numOrder[3] + " Got: " + numResponse[3])
            count+=1
        }
        if(numResponse[4] != numOrder[4]){
           print(" for Number 5, Expected: " + numOrder[4] + " Got: " + numResponse[4])
            count+=1
        }
        if(numResponse[5] != numOrder[5]){
            print(" for Number 6, Expected: " + numOrder[5] + " Got: " + numResponse[5])
            count+=1
        }
        if(numResponse[6] != numOrder[6]){
            print(" for Number 7, Expected: " + numOrder[6] + " Got: " + numResponse[6])
            count+=1
        }
        else{
            print("this shouldn't happen")
        }
        self.resultLabel.text = "doodly"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
