//
//  ForwardDigitSpan.swift
//  iBOCA
//
//  Created by Ellison Lim on 8/2/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit

class ForwardDigitSpan: UIViewController {

    
    
   
    
    @IBOutlet weak var Label0: UILabel!
   
    @IBOutlet weak var Label1: UILabel!

    @IBOutlet weak var Label2: UILabel!
    
    @IBOutlet weak var Label3: UILabel!
    
    @IBOutlet weak var Label4: UILabel!
   
    @IBOutlet weak var Label5: UILabel!
    
    @IBOutlet weak var Label6: UILabel!
    
    
    @IBAction func Tester(sender: AnyObject) {
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
