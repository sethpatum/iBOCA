//
//  TrailsAViewController.swift
//  Integrated test v1
//
//  Created by Seth Amarasinghe on 7/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//
import UIKit

var stopTrailsA:Bool = false

var timePassedTrailsA = 0.0
var timedConnectionsA = [Double]()
var displayImgTrailsA = false
var bubbleColor:UIColor?

var selectedTest = 0


class TrailsAViewController: ViewController, UIPickerViewDelegate {
    
    var drawingView: DrawingViewTrails!
    
    var imageView: UIImageView!
    
    var startTime = TimeInterval()
    var startTime2 = Foundation.Date()
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var testPicker: UIPickerView!
    var TestTypes : [String] = []
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    @IBAction func StartButton(sender: AnyObject) {
        
        
        self.title = TrailsTests[selectedTest].0
        
        startTest()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for test in TrailsTests {
            TestTypes.append(test.0)
        }
        testPicker.delegate = self
        testPicker.transform = CGAffineTransform(scaleX: 0.8, y: 1.0)
        selectedTest = testPicker.selectedRow(inComponent: 0)
        endButton.isHidden = true
        doneButton.isHidden = false
        startButton.isHidden = false
        testPicker.isHidden = false
        timerLabel.text = ""
        resultsLabel.text = ""
        
        
        self.title = TestTypes[selectedTest]
        
        endButton.isEnabled = false
        
    }
    
    
    func startTest() {
        startButton.isEnabled = false
        testPicker.isHidden = true
        endButton.isEnabled = true
        endButton.isHidden = false
        doneButton.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        if drawingView !== nil {
            drawingView.removeFromSuperview()
        }
        
        if imageView !== nil {
            
            imageView.removeFromSuperview()
            imageView.image = nil
            
        }
        
        timedConnectionsA = [Double]()
        
        let drawViewFrame = CGRect(x: 0.0, y: 135.0, width: view.bounds.width, height: view.bounds.height-135)
        drawingView = DrawingViewTrails(frame: drawViewFrame)
        
        print("\(view.bounds.width) \(view.bounds.height)")
        
        view.addSubview(drawingView)
        
        drawingView.reset()
        
        startTime2 = Foundation.Date()
        
        var timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(update(timer:)), userInfo: nil, repeats: true)
        
        startTime = NSDate.timeIntervalSinceReferenceDate
        timedConnectionsA = [Double]()
        stopTrailsA = false
        displayImgTrailsA = false
        
        drawingView.canDraw = true
        
        bubbleColor = UIColor.red
    }
    
    @IBAction func StopButton(sender: AnyObject) {
        startButton.isEnabled = true
        testPicker.isHidden = false
        endButton.isHidden = true
        doneButton.isHidden = false
        
        stopTrailsA = true
        done()
    }
    
    
    /*   @IBAction func HelpButton(sender: AnyObject) {
     if(selectedTest == "Trails A" || selectedTest == "Trails A Practice") {
     let vc = storyboard!.instantiateViewController(withIdentifier: "Trails A Help") as UIViewController
     navigationController!.pushViewController(vc, animated:true)
     } else {
     let vc = storyboard!.instantiateViewController(withIdentifier: "Trails B Help") as UIViewController
     navigationController!.pushViewController(vc, animated:true)
     }
     stopTrailsA = true
     done()
     } */
    
    
    
    func numberOfComponentsInPickerView(_ pickerView : UIPickerView!) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == testPicker {
            return TestTypes.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == testPicker {
            selectedTest = row
            return TestTypes[row]
        } else {
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == testPicker {
            selectedTest = row
        } else  {
        }
    }
    
    
    
    /* Not sure how to conver to swift 3 -Saman
     override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
     return UIInterfaceOrientationMask.Landscape
     } */
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update(timer: Timer) {
        
        if stopTrailsA == false {
            let currTime = NSDate.timeIntervalSinceReferenceDate
            var diff: TimeInterval = currTime - startTime
            
            timePassedTrailsA = diff
            
            let minutes = UInt8(diff / 60.0)
            
            diff -= (TimeInterval(minutes)*60.0)
            
            let seconds = UInt8(diff)
            
            diff = TimeInterval(seconds)
            
            let strMinutes = minutes > 9 ? String(minutes):"0"+String(minutes)
            let strSeconds = seconds > 9 ? String(seconds):"0"+String(seconds)
            
            timerLabel.text = "\(strMinutes) : \(strSeconds)"
        }
        else {
            timer.invalidate()
        }
        
        if displayImgTrailsA == true {
            done()
        }
    }
    
    func done() {
        if drawingView != nil {
            drawingView.canDraw = false
            let imageSize = CGSize(width: screenSize!.maxX, height: screenSize!.maxY - 135)
            imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 135), size: imageSize))
            /*           if resultsDisplayOn == true {
             self.view.addSubview(imageView)
             }
             let image = drawCustomImage(imageSize)
             imageView.image = image */
            let image = drawCustomImage(size: imageSize)
            
            // add to results
            let result = Results()
            result.name = self.title
            result.startTime = startTime2 as Date
            result.endTime = Foundation.Date()
            result.screenshot.append(image)
            
            var num = timePassedTrailsA
            let minutes = UInt8(num / 60.0)
            num -= (TimeInterval(minutes)*60.0)
            let seconds = UInt8(num)
            num = TimeInterval(seconds)
            
            result.longDescription.add("\(drawingView.incorrect) incorrect in \(minutes) minutes and \(seconds) second")
            result.longDescription.add("The of segments are \(drawingView.bubbles.segmenttimes)\n")
            result.longDescription.add("The incorrect segments are \(drawingView.incorrectlist)")
            
            resultsArray.add(result)
        }
        
        displayImgTrailsA = false
        
        startButton.isEnabled = true
        testPicker.isHidden = false
        endButton.isHidden = true
        doneButton.isHidden = false
        
        bubbleColor = UIColor(red:0.6, green:0.0, blue:0.0, alpha:1.0)
        
    }
    
    
    func drawCustomImage(size: CGSize) -> UIImage {
        
        // Setup our context
        //let bounds = CGRect(origin: CGPoint.zero, size: size)
        let opaque = false
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        //let context = UIGraphicsGetCurrentContext()
        
        // Setup complete, do drawing here
        drawingView.drawResultBackground()  //background bubbles
        
        
        
        // Drawing complete, retrieve the finished image and cleanup
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}
