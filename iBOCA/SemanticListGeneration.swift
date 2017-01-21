//
//  SemanticListGeneration.swift
//  iBOCA
//
//  Created by Seth Amarasinghe on 9/5/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit
var Category : String?

class SemanticListGeneration: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var IncorrectButton: UIButton!
    @IBOutlet weak var CorrectButton: UIButton!
    @IBOutlet weak var RepeatButton: UIButton!
    
    
  
    @IBOutlet weak var CategoryPicker: UIPickerView!
    let CategoryData = ["Animals", "Occupations", "Fruit", "Vegitables", "Clothing", "Furniture"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoryPicker.delegate = self
        
        Category = CategoryData[CategoryPicker.selectedRow(inComponent: 0)]

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponentsInPickerView(_ pickerView : UIPickerView!) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == CategoryPicker {
            return CategoryData.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == CategoryPicker {
            Category = CategoryData[row]
            return CategoryData[row]
        } else {
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == CategoryPicker {
            Category = CategoryData[row]
        } else  {
        }
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
