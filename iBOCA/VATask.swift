//
//  VisualAssociationTask.swift
//  iBOCA
//
//  Created by School on 8/6/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import Foundation

import UIKit

var StartTime = Foundation.Date()

var mixedImages = [String]()
var halfImages = [String]()
var recognizeIncorrectVA = [String]()

var afterBreakVA = Bool()

var imageSetVA = Int()

var startTimeVA = TimeInterval()
var timerVA = Timer()

class VATask: UIViewController, UIPickerViewDelegate {
    
    var recallErrors = [Int]()
    var recallTimes = [Double]()
    
    var recognizeErrors = [Int]()
    var recognizeTimes = [Double]()
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var start: UIButton!
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var delayLabel: UILabel!
    
    var delayTime = Double()
    
    @IBOutlet weak var correct: UIButton!
    @IBOutlet weak var incorrect: UIButton!
    @IBOutlet weak var dk: UIButton!
    
    
    @IBOutlet weak var testPicker: UIPickerView!
    var TestTypes : [String] = ["1", "2", "3"]
    
    @IBOutlet weak var testPickerLabel: UILabel!
    
    
    var mixed0 = ["Backpack-Soccer", "Chair-Dog", "Dogbowl-Rope", "Mixer-Tennis", "Pot-Shoe"]
    var half0 = ["Backpack", "Chair", "Dogbowl", "Mixer", "Pot"]
    var incorrect0 = ["Backpack-Other", "Chair-Other", "Dogbowl-Other", "Mixer-Other", "Pot-Other"]
        //["red", "yellow", "blue", "black"]
    
    var mixed1 = ["Barney-FishingRod", "Chess-Calculator", "Goal-Bike", "Painting-Cello", "Racquet-Baseball"]
    var half1 = ["Barney", "Chess", "Goal", "Painting", "Racquet"]
    var incorrect1 = ["Barney-Other", "Chess-Other", "Goal-Other", "Painting-Other", "Racquet-Other"]
        //["red", "yellow", "blue", "black"]
    
    var mixed2 = ["Birdcage-Car", "Dog-Hat", "Horn-Duck", "Plant-Rabbit", "Teapot-Flower"]
    var half2 = ["Birdcage", "Dog", "Horn", "Plant", "Teapot"]
    var incorrect2 = ["Birdcage-Other", "Dog-Other", "Horn-Other", "Plant-Other", "Teapot-Other"]
        //["red", "yellow", "blue", "black"]
    /*
    var mixed3 = ["CarDog", "HornDuck", "PlantRabbit", "ToasterWrench"]
    var half3 = ["Car", "Horn", "Plant", "Toaster"]
    var incorrect3 = ["BikeOwl", "GolfShovel", "PiggybankPlant", "TeapotFlower"]
        //["red", "yellow", "blue", "black"]
    */
    var imageName = ""
    var image = UIImage()
    var imageView = UIImageView()
    var gestureHalf = UIPanGestureRecognizer()
    var gestureDisplay = UIPanGestureRecognizer()
    
    var imageName1 = ""
    var image1 = UIImage()
    var imageView1 = UIImageView()
    
    var imageName2 = ""
    var image2 = UIImage()
    var imageView2 = UIImageView()
    
    var arrowButton1 = UIButton()
    var arrowButton2 = UIButton()
    
    var orderRecognize = [Int]()
    
    var firstDisplay = Bool()
    
    var testCount = Int()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //navigationItem.title = "back"
        
        testPicker.delegate = self
        testPicker.transform = CGAffineTransform(scaleX: 0.8, y: 1.0)
        
        gestureHalf = UIPanGestureRecognizer(target: self, action: #selector(wasDraggedHalf))
        
        gestureDisplay = UIPanGestureRecognizer(target: self, action: #selector(wasDraggedDisplay))
        
        if(afterBreakVA == true){
            timerVA = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateInDelay), userInfo: nil, repeats: true)
            delayLabel.text = "Recommended delay: 5 minutes"
            
            testPicker.isHidden = true
            testPickerLabel.isHidden = true
            
            start.removeTarget(self, action: #selector(startNewTask), for:.touchUpInside)
            start.removeTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
            start.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
        }
            
        else{
            testPicker.reloadAllComponents()
            testPicker.selectRow(0, inComponent: 0, animated: true)
            testPicker.isHidden = false
            testPickerLabel.isHidden = false
            
            imageSetVA = 0
            mixedImages = mixed0
            halfImages = half0
            recognizeIncorrectVA = incorrect0
            
            start.removeTarget(self, action: #selector(startNewTask), for:.touchUpInside)
            start.removeTarget(self, action: #selector(startAlert), for:.touchUpInside)
            start.addTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
            
        }
        
        print(afterBreakVA)
        
        back.isEnabled = true
        start.isEnabled = true
        
        correct.isHidden = true
        incorrect.isHidden = true
        dk.isHidden = true
        
    }
    
    func startAlert() {
        back.isEnabled = false
        
        let startAlert = UIAlertController(title: "Start", message: "Choose start option.", preferredStyle: .alert)
        
        startAlert.addAction(UIAlertAction(title: "Start New Task", style: .default, handler: { (action) -> Void in
            print("start new")
//            Status[TestVisualAssociation] = TestStatus.Running
            
            imageSetVA = 0
            mixedImages = self.mixed0
            halfImages = self.half0
            recognizeIncorrectVA = self.incorrect0
            
            self.testPicker.reloadAllComponents()
            
            self.testPicker.selectRow(0, inComponent: 0, animated: true)
            
            self.testPicker.isHidden = false
            
            self.testPickerLabel.isHidden = false
            
            self.startNewTask()
            //action
        }))
        
        if(afterBreakVA == true){
            startAlert.addAction(UIAlertAction(title: "Resume Task", style: .default, handler: { (action) -> Void in
                print("resume old")
                
                self.testPicker.isHidden = true
                
                self.testPickerLabel.isHidden = true
                
                self.start.isHidden = true
                
                self.resumeTask()
                //action
            }))
        }
        
        startAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            print("cancel")
            self.back.isEnabled = true
            //action
        }))
        
        self.present(startAlert, animated: true, completion: nil)
        
    }
    
    func startNewTask(){
        
        timerVA.invalidate()
        
        recallErrors = [Int]()
        recallTimes = [Double]()
        recognizeErrors = [Int]()
        recognizeTimes = [Double]()
        orderRecognize = [Int]()
        testCount = 0
        resultLabel.text = ""
        timerLabel.text = ""
        delayLabel.text = ""
        afterBreakVA = false
        
        
        firstDisplay = true
        timerLabel.text = ""
        delayLabel.text = ""
        
        testPicker.reloadAllComponents()
        testPicker.selectRow(0, inComponent: 0, animated: true)
        testPicker.isHidden = false
        testPickerLabel.isHidden = false
        
        imageSetVA = 0
        mixedImages = mixed0
        halfImages = half0
        recognizeIncorrectVA = incorrect0
        
        start.isHidden = false
        start.isEnabled = true
        
        start.removeTarget(self, action: #selector(startNewTask), for:.touchUpInside)
        start.removeTarget(self, action: #selector(startAlert), for:.touchUpInside)
        start.addTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
        
    }
    
    func startDisplayAlert() {
        
        Status[TestVisualAssociation] = TestStatus.Running
        
        start.isHidden = true
        testPicker.isHidden = true
        
        testPickerLabel.isHidden = true
        
        back.isEnabled = false
        
        firstDisplay = true
        
        let newStartAlert = UIAlertController(title: "Display", message: "Ask patient to name and remember the two items in the photograph.", preferredStyle: .alert)
        newStartAlert.addAction(UIAlertAction(title: "Start", style: .default, handler: { (action) -> Void in
            print("start")
            self.display()
            //action
        }))
        self.present(newStartAlert, animated: true, completion: nil)
        
    }
    
    func numberOfComponentsInPickerView(_ pickerView : UIPickerView!) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == testPicker {
            
            return TestTypes.count
        }
        else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == testPicker {
            
            return TestTypes[row]
        }
        else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print("2:", pickerView)
        if pickerView == testPicker {
            
            if row == 0 {
                imageSetVA = 0
                mixedImages = mixed0
                halfImages = half0
                recognizeIncorrectVA = incorrect0
            }
            if row == 1 {
                imageSetVA = 1
                mixedImages = mixed1
                halfImages = half1
                recognizeIncorrectVA = incorrect1
            }
            if row == 2 {
                imageSetVA = 2
                mixedImages = mixed2
                halfImages = half2
                recognizeIncorrectVA = incorrect2
            }
            
            start.isEnabled = true
            
        }
        
    }

    
    func display(){
        
        testCount = 0
        
        outputDisplayImage(mixedImages[testCount])
        
        
    }
    
    func outputDisplayImage(_ name: String) {
        
        imageView.removeFromSuperview()
        
        imageName = name
        
        image = UIImage(named: imageName)!
        
        var x = CGFloat()
        var y = CGFloat()
        if 0.56*image.size.width < image.size.height {
            y = 575.0
            x = (575.0*(image.size.width)/(image.size.height))
        }
        else {
            x = 575.0
            y = (575.0*(image.size.height)/(image.size.width))
        }
        
        imageView = UIImageView(frame:CGRect(x: (512.0-(x/2)), y: (471.0-(y/2)), width: x, height: y))
        
        imageView.image = image
        
        imageView.isUserInteractionEnabled = true
        imageView.removeGestureRecognizer(gestureHalf)
        imageView.addGestureRecognizer(gestureDisplay)
        
        self.view.addSubview(imageView)
        
    }
    
    func wasDraggedDisplay(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.view)
        
        let img = gesture.view!
        img.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: 471.0)
        
        if gesture.state == UIGestureRecognizerState.ended {
            if img.center.x < 200 {
                
                testCount += 1
                if(testCount == mixedImages.count){
                    
                    imageView.removeFromSuperview()
                    
                    if(firstDisplay == false){
                        imageView.removeGestureRecognizer(gestureDisplay)
                        beginDelay()
                    }
                    else{
                        
                        firstDisplay = false
                        
                        let nextAlert = UIAlertController(title: "Display", message: "Ask patient to name and remember the two items in the photograph again.", preferredStyle: .alert)
                        nextAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
                            print("continuing")
                            self.display()
                            //action
                        }))
                        present(nextAlert, animated: true, completion: nil)
                    }
                    
                }
                    
                else{
                    
                    print("next pic!")
                    img.center = CGPoint(x: 512.0, y: 471.0)
                    
                    outputDisplayImage(mixedImages[testCount])
                    
                }
                
            }
                
            else{
                
                print("back to center!")
                img.center = CGPoint(x: 512.0, y: 471.0)
                
            }
            
        }
        
    }
    
    func beginDelay(){
        imageView.removeFromSuperview()
        print("in delay...")
        
        delayLabel.text = "Recommended delay: 5 minutes"
        
        afterBreakVA = true
        
        back.isEnabled = true
        start.isEnabled = true
        start.isHidden = false
        
        start.removeTarget(self, action: #selector(startNewTask), for:.touchUpInside)
        start.removeTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
        start.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
        
        timerVA = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateInDelay), userInfo: nil, repeats: true)
        
        startTimeVA = NSDate.timeIntervalSinceReferenceDate
        
    }
    
    func updateInDelay(_ timer: Timer) {
        
        let currTime = Foundation.Date.timeIntervalSinceReferenceDate
        var diff: TimeInterval = currTime - startTimeVA
        
        let minutes = UInt8(diff / 60.0)
        
        diff -= (TimeInterval(minutes)*60.0)
        
        let seconds = UInt8(diff)
        
        diff = TimeInterval(seconds)
        
        let strMinutes = minutes > 9 ? String(minutes):"0"+String(minutes)
        let strSeconds = seconds > 9 ? String(seconds):"0"+String(seconds)
        
        timerLabel.text = "\(strMinutes) : \(strSeconds)"
        
    }
    
    /*
     func updateInRecall(timer: NSTimer) {
     
     }
     */
    
    func outputImage(_ name: String) {
        
        imageView.removeFromSuperview()
        
        imageName = name
        
        image = UIImage(named: imageName)!
        
        var x = CGFloat()
        var y = CGFloat()
        if 0.56*image.size.width < image.size.height {
            y = 575.0
            x = (575.0*(image.size.width)/(image.size.height))
        }
        else {
            x = 575.0
            y = (575.0*(image.size.height)/(image.size.width))
        }
        
        imageView = UIImageView(frame:CGRect(x: (512.0-(x/2)), y: (471.0-(y/2)), width: x, height: y))
        
        imageView.image = image
        
        imageView.isUserInteractionEnabled = false
        
        self.view.addSubview(imageView)
        
    }
    
    func resumeTask(){
        
        delayTime = findTime()
        
        timerVA.invalidate()
        timerLabel.text = ""
        delayLabel.text = ""
        
        let recallAlert = UIAlertController(title: "Recall", message: "Ask patient to name which item is missing from the picture and record their answer.", preferredStyle: .alert)
        recallAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
            print("recalling...")
            self.recall()
            //action
        }))
        self.present(recallAlert, animated: true, completion: nil)
        
        
    }
    
    func recall(){
        
        correct.isHidden = false
        incorrect.isHidden = false
        dk.isHidden = false
        
        correct.isEnabled = true
        incorrect.isEnabled = true
        dk.isEnabled = true
        
        testCount = 0
        
        outputImage(halfImages[testCount])
        
        startTimeVA = NSDate.timeIntervalSinceReferenceDate
        
    }
    
    
    @IBAction func correctButton(_ sender: Any) {
        correct.isEnabled = false
        incorrect.isEnabled = false
        dk.isEnabled = false
        
        recallErrors.append(0)
        recallTimes.append(findTime())
        
        imageView.addGestureRecognizer(gestureHalf)
        imageView.isUserInteractionEnabled = true
        
    }
    
    @IBAction func incorrectButton(_ sender: Any) {
        
        correct.isEnabled = false
        incorrect.isEnabled = false
        dk.isEnabled = false
        
        recallErrors.append(1)
        recallTimes.append(findTime())
        
        imageView.addGestureRecognizer(gestureHalf)
        imageView.isUserInteractionEnabled = true
        
    }
    
    
    @IBAction func dkButton(_ sender: Any) {
        
        correct.isEnabled = false
        incorrect.isEnabled = false
        dk.isEnabled = false
        
        recallErrors.append(2)
        recallTimes.append(findTime())
        
        imageView.addGestureRecognizer(gestureHalf)
        imageView.isUserInteractionEnabled = true
        
    }
    
    func findTime()->Double{
        
        let currTime = NSDate.timeIntervalSinceReferenceDate
        let time = Double(Int((currTime - startTimeVA)*10))/10.0
        return time
        
    }
    
    func wasDraggedHalf(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.view)
        
        let img = gesture.view!
        img.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: 471.0)
        
        if gesture.state == UIGestureRecognizerState.ended {
            if img.center.x < 200 {
                
                testCount += 1
                if(testCount == halfImages.count){
                    
                    imageView.removeFromSuperview()
                    correct.isHidden = true
                    incorrect.isHidden = true
                    dk.isHidden = true
                    
                    let recognizeAlert = UIAlertController(title: "Recognize", message: "Ask patient to choose the photograph they have seen before.", preferredStyle: .alert)
                    recognizeAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
                        print("recognizing...")
                        self.recognize()
                        //action
                    }))
                    self.present(recognizeAlert, animated: true, completion: nil)
                    
                }
                    
                else{
                    
                    print("next pic!")
                    img.center = CGPoint(x: 512.0, y: 471.0)
                    
                    outputImage(halfImages[testCount])
                    
                    correct.isEnabled = true
                    incorrect.isEnabled = true
                    dk.isEnabled = true
                    
//                    startTimeVA = NSDate.timeIntervalSinceReferenceDate
                    
                }
                
            }
                
            else{
                
                print("back to center!")
                img.center = CGPoint(x: 512.0, y: 471.0)
                
            }
            
        }
        
    }
    
    func recognize(){
        
        print("IN RECOGNIZE!!!")
        
        testCount = 0
        
        randomizeRecognize()
        
        if(orderRecognize[testCount] == 0) {
            outputRecognizeImages(mixedImages[testCount], name2: recognizeIncorrectVA[testCount])
        }
        else{
            outputRecognizeImages(recognizeIncorrectVA[testCount], name2: mixedImages[testCount])
        }
        
        arrowButton1.isHidden = false
        arrowButton1.isEnabled = true
        
        arrowButton2.isHidden = false
        arrowButton2.isEnabled = true
        
        startTimeVA = NSDate.timeIntervalSinceReferenceDate
        
    }
    
    func outputRecognizeImages(_ name1: String, name2: String){
        
        arrowButton1.removeFromSuperview()
        arrowButton2.removeFromSuperview()
        
        imageName1 = name1
        imageName2 = name2
        
        image1 = UIImage(named: name1)!
        image2 = UIImage(named: name2)!
        
        var x1 = CGFloat()
        var x2 = CGFloat()
        
        var y1 = CGFloat()
        var y2 = CGFloat()
        
        if 0.56*image1.size.width < image1.size.height {
            y1 = 350.0
            x1 = (350.0*(image1.size.width)/(image1.size.height))
        }
        else {
            x1 = 350.0
            y1 = (350.0*(image1.size.height)/(image1.size.width))
        }
        
        if 0.56*image2.size.width < image2.size.height {
            y2 = 350.0
            x2 = (350.0*(image2.size.width)/(image2.size.height))
        }
        else {
            x2 = 350.0
            y2 = (350.0*(image2.size.height)/(image2.size.width))
        }
        
        arrowButton1.frame = CGRect(x: (256.0-(x1/2)), y: (471.0-(y1/2)), width: x1, height: y1)
        arrowButton1.setImage(image1, for: .normal)
        arrowButton1.addTarget(self, action: #selector(recognize1), for:.touchUpInside)
        self.view.addSubview(arrowButton1)
        
        arrowButton2.frame = CGRect(x: (768.0-(x2/2)), y: (471.0-(y2/2)), width: x2, height: y2)
        arrowButton2.setImage(image2, for: .normal)
        arrowButton2.addTarget(self, action: #selector(recognize2), for:.touchUpInside)
        self.view.addSubview(arrowButton2)
        
    }
    
    func randomizeRecognize(){
        
        //if 0, correct image on left; if 1, correct on right
        
        for k in 0 ..< 5 {
            self.orderRecognize.append(Int(arc4random_uniform(2)))
        }
        
    }
    
    @IBAction func recognize1(_ sender: AnyObject){
        
        arrowButton1.isEnabled = false
        arrowButton2.isEnabled = false
        
        if(orderRecognize[testCount] == 0){
            recognizeErrors.append(0)
            recognizeTimes.append(findTime())
        }
        else{
            recognizeErrors.append(1)
            recognizeTimes.append(findTime())
        }
        
        recognizeNext()
        
    }
    
    @IBAction func recognize2(_ sender: AnyObject){
        
        arrowButton1.isEnabled = false
        arrowButton2.isEnabled = false
        
        if(orderRecognize[testCount] == 0){
            recognizeErrors.append(1)
            recognizeTimes.append(findTime())
        }
        else{
            recognizeErrors.append(0)
            recognizeTimes.append(findTime())
        }
        
        recognizeNext()
        
    }
    
    
    func recognizeNext() {
        
        testCount += 1
        
        if(testCount == mixedImages.count){
            
            arrowButton1.isHidden = true
            arrowButton2.isHidden = true
            
            done()
            
        }
            
        else{
            
            arrowButton1.isEnabled = true
            arrowButton2.isEnabled = true
            
            if(orderRecognize[testCount] == 0) {
                outputRecognizeImages(mixedImages[testCount], name2: recognizeIncorrectVA[testCount])
            }
            else{
                outputRecognizeImages(recognizeIncorrectVA[testCount], name2: mixedImages[testCount])
            }
            
        }
        
        
    }
    
    func done(){
        let result = Results()
        result.name = "VA Task"
        result.startTime = StartTime
        result.endTime = Foundation.Date()
        
        Status[TestVisualAssociation] = TestStatus.Done

        back.isEnabled = true
        start.isEnabled = true
        
        afterBreakVA = false
        
        var recallResult = ""
        var recognizeResult = ""
        var delayResult = ""
        var imageSetResult = ""
        
        imageSetResult = "Image set = \(imageSetVA+1)\n"
        
        delayResult = "Delay length of \(delayTime) seconds\n"
        
        for k in 0 ..< mixedImages.count {
            
            if(recallErrors[k] == 0){
                result.longDescription.add("Recalled \(mixedImages[k]) correctly in \(recallTimes[k]) seconds")
                recallResult += "Recalled \(mixedImages[k]) correctly in \(recallTimes[k]) seconds\n"
            }
            if(recallErrors[k] == 1){
                result.longDescription.add("Recalled \(mixedImages[k]) incorrectly in \(recallTimes[k]) seconds")
                recallResult += "Recalled \(mixedImages[k]) incorrectly in \(recallTimes[k]) seconds\n"
            }
            if(recallErrors[k] == 2){
                result.longDescription.add("Couldn't recall \(mixedImages[k]) in \(recallTimes[k]) seconds")
                recallResult += "Couldn't recall \(mixedImages[k]) in \(recallTimes[k]) seconds\n"
            }
            
            
            if(recognizeErrors[k] == 0){
                result.longDescription.add("Recognized \(mixedImages[k]) correctly in \(recognizeTimes[k]) seconds")
                recognizeResult += "Recognized \(mixedImages[k]) correctly in \(recognizeTimes[k]) seconds\n"
            }
            if(recognizeErrors[k] == 1){
                result.longDescription.add("Recognized \(mixedImages[k]) incorrectly in \(recognizeTimes[k]) seconds ")
                recognizeResult += "Recognized \(mixedImages[k]) incorrectly in \(recognizeTimes[k]) seconds\n"
            }
            
        }
        
        resultLabel.text = imageSetResult + delayResult + recallResult + recognizeResult
        result.json = ["None":""]
        resultsArray.add(result)
        
        start.isHidden = false
        start.isEnabled = true
        start.removeTarget(self, action: #selector(startNewTask), for:.touchUpInside)
        start.removeTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
        start.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
        
    }
    
    func delay(_ delay:Double, closure:()->()) {
        /*
        dispatch_after(
            dispatch_time( dispatch_time_t(DISPATCH_TIME_NOW), Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        */
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            //dispatchMain()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    
}
