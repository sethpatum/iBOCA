//
//  SemanticListGeneration.swift
//  iBOCA
//
//  Created by Seth Amarasinghe on 9/5/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit

class SemanticListGeneration: UIViewController {

    
    
    @IBOutlet weak var IncorrectButton: UIButton!
    @IBOutlet weak var CorrectButton: UIButton!
    @IBOutlet weak var RepeatButton: UIButton!
    
    @IBOutlet weak var CategoryPicker: UIPickerView!
    
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
