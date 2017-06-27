//
//  LandingPage.swift
//  iBOCA
//
//  Created by saman on 6/27/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation
import UIKit

let TestOrientation = 1
let TestSimpleMemory = 2
let TestVisualAssociation = 3
let TestTrails = 4
let TestForwardDigitSpan = 5
let TestBackwardsDigitSpan = 6
let TestCatsAndDogs = 7
let Test3DFigureCopy = 8
let TestSerialSevens = 9
let TestForwardSpatialSpan = 10
let TestBackwardSpatialSpan = 11
let TestNampingPictures = 12
let TestSemanticListGeneration = 13
let TestMOCAandGDTResults = 14


enum TestStatus {
    case NotStarted, Running, Done
}

var Status  = [TestStatus](repeating: TestStatus.NotStarted, count: 15)


class LandingPage: UIViewController {
    
    @IBOutlet weak var GotoTests: UIButton!
    
    @IBAction func GotoTests(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if atBIDMCOn {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "main")
            self.present(nextViewController, animated:true, completion:nil)
        } else {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Demographics")
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Status[TestOrientation] = TestStatus.NotStarted
        Status[TestSimpleMemory] = TestStatus.NotStarted
        Status[TestVisualAssociation] = TestStatus.NotStarted
        Status[TestTrails] = TestStatus.NotStarted
        Status[TestForwardDigitSpan] = TestStatus.NotStarted
        Status[TestBackwardsDigitSpan] = TestStatus.NotStarted
        Status[TestCatsAndDogs] = TestStatus.NotStarted
        Status[Test3DFigureCopy] = TestStatus.NotStarted
        Status[TestSerialSevens] = TestStatus.NotStarted
        Status[TestForwardSpatialSpan] = TestStatus.NotStarted
        Status[TestBackwardSpatialSpan] = TestStatus.NotStarted
        Status[TestNampingPictures] = TestStatus.NotStarted
        Status[TestSemanticListGeneration] = TestStatus.NotStarted
 
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
