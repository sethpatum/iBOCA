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
var numBubbles = 0


class TrailsAViewController: ViewController, UIPickerViewDelegate {
    
    var drawingView: DrawingViewTrails!
    var imageView: UIImageView!
    
    var ended = false
    
    var startTime = TimeInterval()
    var startTime2 = Foundation.Date()
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!

    
    @IBOutlet weak var testPicker: UIPickerView!
    var TestTypes : [String] = []
    
    @IBOutlet weak var numBubblesPicker: UIPickerView!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    
    
    
    @IBAction func StartButton(sender: AnyObject) {
        testPicker.isHidden = true
        
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
        testPicker.isHidden = false
        
        numBubblesPicker.delegate = self
        numBubblesPicker.transform = CGAffineTransform(scaleX: 0.8, y: 1.0)
        numBubblesPicker.selectRow(TrailsTests[selectedTest].1.count - 3, inComponent: 0, animated:true)
        numBubbles = numBubblesPicker.selectedRow(inComponent: 0) + 2
        numBubblesPicker.isHidden = false
        
        
        startButton.isHidden = false

        timerLabel.text = ""
        resultsLabel.text = ""
        
        
        self.title = TestTypes[selectedTest]
    }
    
    
    func startTest() {
        startButton.isEnabled = false
        testPicker.isHidden = true
        numBubblesPicker.isHidden = true
        ended = false

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
        
        _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(update(timer:)), userInfo: nil, repeats: true)
        
        startTime = NSDate.timeIntervalSinceReferenceDate
        timedConnectionsA = [Double]()
        stopTrailsA = false
        displayImgTrailsA = false
        
        drawingView.canDraw = true
        
        bubbleColor = UIColor.red
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if !ended {
            done()
        }
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
        } else  if pickerView == numBubblesPicker {
            return TrailsTests[selectedTest].1.count - 2
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == testPicker {
            selectedTest = row
            numBubblesPicker.reloadAllComponents()
            return TestTypes[row]
        } else  if pickerView == numBubblesPicker {
            numBubbles = row + 2
            return String(row + 2)
        } else {
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == testPicker {
            selectedTest = row
            numBubblesPicker.reloadAllComponents()
            numBubblesPicker.selectRow(TrailsTests[selectedTest].1.count - 3, inComponent: 0, animated:true)
        } else  if pickerView == numBubblesPicker {
            numBubbles = row + 2
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
        ended = true
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
            result.name = "Trails B Test"
            result.startTime = startTime2 as Date
            result.endTime = Foundation.Date()
            result.screenshot.append(image)
            
            var num = timePassedTrailsA
            let minutes = UInt8(num / 60.0)
            num -= (TimeInterval(minutes)*60.0)
            let seconds = UInt8(num)
            num = TimeInterval(seconds)
            
            result.longDescription.add(String(describing: self.title))
            result.longDescription.add("\(drawingView.nextBubb) correct and \(drawingView.incorrect) incorrect in \(minutes) minutes and \(seconds) second")
            result.longDescription.add("The segments are \(drawingView.bubbles.segmenttimes)\n")
            result.longDescription.add("The incorrect segments are \(drawingView.incorrectlist)")
            result.shortDescription = "\(drawingView.incorrect) errors with \(drawingView.nextBubb) correct bubbles (test \(self.title!))"
            result.numErrors = drawingView.incorrect
            
            result.json["Path"] = drawingView.bubbles.jsontimes
            result.json["Name"] = self.title
            result.json["Total Bubbles"] = numBubbles
            result.json["Errors"] = drawingView.incorrect
            result.json["Correct Path Length"] = drawingView.nextBubb
            result.json["Full Path"] = drawingView.resultpath
            resultsArray.add(result)
            
            Status[TestTrails] = TestStatus.Done
            testPicker.isHidden = false
            numBubblesPicker.isHidden = false
        }
        
        displayImgTrailsA = false
        
        startButton.isEnabled = true
        testPicker.isHidden = false
        numBubblesPicker.isHidden = false
        
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
