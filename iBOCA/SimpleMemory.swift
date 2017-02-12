//
//  SimpleMemoryTask.swift
//  iBOCA
//
//  Created by School on 8/29/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import Foundation

import UIKit

var afterBreakSM = Bool()

var recognizeIncorrectSM = [String]()

var imagesSM = [String]()

var imageSetSM = Int()
var incorrectImageSetSM = Int()

var startTimeSM = TimeInterval()
var timerSM = Timer()
var StartTimer = Foundation.Date()
class SimpleMemoryTask: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var delayLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var testPicker: UIPickerView!
    var TestTypes : [String] = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    @IBOutlet weak var incorrectPicker: UIPickerView!
    var IncorrectTypes: [String] = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    @IBOutlet weak var testPickerLabel: UILabel!
    @IBOutlet weak var incorrectPickerLabel: UILabel!
    
    var recognizeErrors = [Int]()
    var recognizeTimes = [Double]()
    
    @IBOutlet weak var next1: UIButton!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var back: UIButton!
    
    var testCount = 0
    
    var images0 = ["binoculars", "can", "cat", "elbow", "pipe", "rainbow"]
    var images1 = ["bottle", "coral", "ladder", "owl", "saw", "shoe"]
    var images2 = ["bee", "corn", "lamp", "sheep", "violin", "watch"]
    var images3 = ["basket", "candle", "doll", "knife", "skeleton", "star"]
    var images4 = ["briefcase", "chair", "duck", "microphone", "needle", "stairs"]
    var images5 = ["baseball", "drum", "necklace", "shovel", "tank", "toilet"]
    var images6 = ["anchor", "eyebrow", "flashlight", "glove", "moon", "sword"]
    var images7 = ["lion", "nut", "piano", "ring", "scissors", "whisk"]
    
    var imageName = ""
    var image = UIImage()
    var imageView = UIImageView()
    var gesture = UIPanGestureRecognizer()
    
    var imageName1 = ""
    var image1 = UIImage()
    
    var imageName2 = ""
    var image2 = UIImage()
    
    var buttonList = [UIButton]()
    
    var buttonTaps = [Bool]()
    
    var recallIncorrect = Int()
    var recallPlus = UIButton()
    var recallMinus = UIButton()
    var recallLabel = UILabel()
    
    var arrowButton1 = UIButton()
    var arrowButton2 = UIButton()
    
    var orderRecognize = [Int]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        testPicker.delegate = self
        testPicker.transform = CGAffineTransform(scaleX: 0.8, y: 1.0)
        
        incorrectPicker.delegate = self
        incorrectPicker.transform = CGAffineTransform(scaleX: 0.8, y: 1.0)
        
        gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged))

        arrowButton1 = UIButton(type: UIButtonType.custom) as UIButton
        
        arrowButton2 = UIButton(type: UIButtonType.custom) as UIButton
        
        next1.isHidden = true
        
        back.isEnabled = true
        
        start.isHidden = false
        
        if(afterBreakSM == true){
            timerSM = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateInDelay), userInfo: nil, repeats: true)
            delayLabel.text = "Recommended delay: 1 minute"
//            start.isHidden = false
            testPicker.isHidden = true
            incorrectPicker.isHidden = true
            
            testPickerLabel.isHidden = true
            incorrectPickerLabel.isHidden = true
            
            start.removeTarget(self, action: #selector(startNewTask), for:.touchUpInside)
            start.removeTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
            start.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
        }
        else{
//            start.isHidden = true
            
            testPicker.reloadAllComponents()
            incorrectPicker.reloadAllComponents()
            
            testPicker.selectRow(0, inComponent: 0, animated: true)
            incorrectPicker.selectRow(0, inComponent: 0, animated: true)
            
            testPicker.isHidden = false
            incorrectPicker.isHidden = false
            
            testPickerLabel.isHidden = false
            incorrectPickerLabel.isHidden = false
            
            recognizeIncorrectSM = images0
            imagesSM = images0
            
            start.isEnabled = false
            
            start.removeTarget(self, action: #selector(startNewTask), for:.touchUpInside)
            start.removeTarget(self, action: #selector(startAlert), for:.touchUpInside)
            start.addTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
//            startAlert()
        }
        
    }
    
    func startAlert(){
        
        back.isEnabled = false
        next1.isHidden = true
        
        let startAlert = UIAlertController(title: "Start", message: "Choose start option", preferredStyle: .alert)
        
        startAlert.addAction(UIAlertAction(title: "Start New Task", style: .default, handler: { (action) -> Void in
            print("start new")
            Status[TestSimpleMemory] = TestStatus.Running
//            self.startNewTask()
            
            recognizeIncorrectSM = self.images0
            imagesSM = self.images0
            
            self.testPicker.reloadAllComponents()
            self.incorrectPicker.reloadAllComponents()
            
            self.testPicker.selectRow(0, inComponent: 0, animated: true)
            self.incorrectPicker.selectRow(0, inComponent: 0, animated: true)
            
            self.testPicker.isHidden = false
            self.incorrectPicker.isHidden = false
            
            self.testPickerLabel.isHidden = false
            self.incorrectPickerLabel.isHidden = false
            
            self.startNewTask()
            
            //action
        }))
        
        if(afterBreakSM == true){
            startAlert.addAction(UIAlertAction(title: "Resume Task", style: .default, handler: { (action) -> Void in
                print("resume old")
                
                self.testPicker.isHidden = true
                self.incorrectPicker.isHidden = true
                
                self.testPickerLabel.isHidden = true
                self.incorrectPickerLabel.isHidden = true
                
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
        
        DispatchQueue.main.async {
            self.present(startAlert, animated: true, completion: nil)
        }
        
    }
    func startNewTask(){
        
        timerSM.invalidate()
        
        buttonTaps = [Bool]()
        testCount = 0
        recognizeTimes = [Double]()
        recognizeErrors = [Int]()
        orderRecognize = [Int]()
        resultLabel.text = ""
        timerLabel.text = ""
        delayLabel.text = ""
        afterBreakSM = false
        
        
        start.isHidden = false
        start.isEnabled = false
        
        start.removeTarget(self, action: #selector(startNewTask), for:.touchUpInside)
        start.removeTarget(self, action: #selector(startAlert), for:.touchUpInside)
        start.addTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
        
        
        
    }
    
    func startDisplayAlert(){
        
        start.isHidden = true
        testPicker.isHidden = true
        incorrectPicker.isHidden = true
        
        testPickerLabel.isHidden = true
        incorrectPickerLabel.isHidden = true
        
        back.isEnabled = false
        
        let newStartAlert = UIAlertController(title: "Display", message: "Name and try to remember these images", preferredStyle: .alert)
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
        if pickerView == incorrectPicker {
            
            return IncorrectTypes.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == testPicker {
            
            return TestTypes[row]
        }
        if pickerView == incorrectPicker {
            
            return IncorrectTypes[row]
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print("2:", pickerView)
        if pickerView == testPicker {
            
            if row == 0 {
                imagesSM = images0
            }
            if row == 1 {
                imagesSM = images1
            }
            if row == 2 {
                imagesSM = images2
            }
            if row == 3 {
                imagesSM = images3
            }
            if row == 4 {
                imagesSM = images4
            }
            if row == 5 {
                imagesSM = images5
            }
            if row == 6 {
                imagesSM = images6
            }
            if row == 7 {
                imagesSM = images7
            }
            
            if(TestTypes[testPicker.selectedRow(inComponent: 0)] == IncorrectTypes[incorrectPicker.selectedRow(inComponent: 0)]){
                start.isEnabled = false
            }
            else{
                start.isEnabled = true
            }

        }
        else if pickerView == incorrectPicker {
            if row == 0 {
                recognizeIncorrectSM = images0
            }
            if row == 1 {
                recognizeIncorrectSM = images1
            }
            if row == 2 {
                recognizeIncorrectSM = images2
            }
            if row == 3 {
                recognizeIncorrectSM = images3
            }
            if row == 4 {
                recognizeIncorrectSM = images4
            }
            if row == 5 {
                recognizeIncorrectSM = images5
            }
            if row == 6 {
                recognizeIncorrectSM = images6
            }
            if row == 7 {
                recognizeIncorrectSM = images7
            }
            
            if(TestTypes[testPicker.selectedRow(inComponent: 0)] == IncorrectTypes[incorrectPicker.selectedRow(inComponent: 0)]){
                start.isEnabled = false
            }
            else{
                start.isEnabled = true
            }
            
        }
        
        print("imagesSM = \(imagesSM), recognizeIncorrectSM = \(recognizeIncorrectSM)")
    }
    
    func display(){
        
        testCount = 0
        
        print("testCount = \(testCount), imagesSM = \(imagesSM)")
        print("imagesSM[testCount] = \(imagesSM[testCount])")
        
        outputImage(name: imagesSM[testCount])
        
    }
    
    func outputImage(name: String){
        
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
        
        imageView.addGestureRecognizer(gesture)
        imageView.isUserInteractionEnabled = true
        
        self.view.addSubview(imageView)
        
    }
    
    func outputRecognizeImages(name1: String, name2: String){
        
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
    
    
    func wasDragged(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.view)
        
        let img = gesture.view!
        img.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: 471.0)
        
        if gesture.state == UIGestureRecognizerState.ended {
            if img.center.x < 200 {
                
                testCount += 1
                if(testCount == imagesSM.count){
                    
                    imageView.removeFromSuperview()
                    
                    print("delay")
                    
                    beginDelay()
                    
                }
                    
                else{
                    
                    print("next pic!")
                    img.center = CGPoint(x: 512.0, y: 471.0)
                    
                    outputImage(name: imagesSM[testCount])
                    
                    startTimeSM = NSDate.timeIntervalSinceReferenceDate
                    
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
        print("in delay!")
        
        delayLabel.text = "Recommended delay: 1 minute"
        
        afterBreakSM = true
        
        start.removeTarget(self, action: #selector(startNewTask), for:.touchUpInside)
        start.removeTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
        start.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
        
        back.isEnabled = true
        
        start.isHidden = false
        
        timerSM = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateInDelay), userInfo: nil, repeats: true)
        
        startTimeSM = NSDate.timeIntervalSinceReferenceDate
        
        
    }
    
    func updateInDelay(timer:Timer){
        
        let currTime = NSDate.timeIntervalSinceReferenceDate
        var diff: TimeInterval = currTime - startTimeSM
        
        let minutes = UInt8(diff / 60.0)
        
        diff -= (TimeInterval(minutes)*60.0)
        
        let seconds = UInt8(diff)
        
        diff = TimeInterval(seconds)
        
        let strMinutes = minutes > 9 ? String(minutes):"0"+String(minutes)
        let strSeconds = seconds > 9 ? String(seconds):"0"+String(seconds)
        
        timerLabel.text = "\(strMinutes) : \(strSeconds)"
        
    }
    
    func resumeTask(){
        
        timerSM.invalidate()
        timerLabel.text = ""
        delayLabel.text = ""
        
        let recallAlert = UIAlertController(title: "Recall", message: "Name the items that were displayed earlier", preferredStyle: .alert)
        recallAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
            print("recalling...")
            self.recall()
            //action
        }))
        self.present(recallAlert, animated: true, completion: nil)
        
    }
    
    func findTime()->Double{
        
        let currTime = NSDate.timeIntervalSinceReferenceDate
        var diff: TimeInterval = currTime - startTimeSM
        let minutes = UInt8(diff / 60.0)
        diff -= (TimeInterval(minutes)*60.0)
        let seconds = Double(Int(diff*1000))/1000.0
        return seconds
        
    }
    
    func recall(){
        
        next1.isHidden = false
        next1.isEnabled = true
        
        next1.addTarget(self, action: #selector(nextButtonRecall), for: UIControlEvents.touchUpInside)
        
        var places = [(312, 175), (312, 250), (312, 325), (312, 400), (312, 475), (312, 550)]
        
        //deleted: , (312, 625)
        
        for k in 0 ..< 6 {
            let(a,b) = places[k]
            
            let x : CGFloat = CGFloat(a)
            let y : CGFloat = CGFloat(b)
            
            let button = UIButton(type: UIButtonType.system)
            buttonList.append(button)
            buttonTaps.append(false)
            button.frame = CGRect(x: x, y: y, width: 400, height: 70)
            button.titleLabel!.font = UIFont.systemFont(ofSize: 50)
            
            button.setTitle(imagesSM[k], for: UIControlState.normal)
            
            /*
            if(k < 6){
                button.setTitle(imagesSM[k], for: UIControlState.normal)
            }
            else{
                button.setTitle("incorrect", for: UIControlState.normal)
            }
            */
            button.tintColor = UIColor.lightGray
            
            button.addTarget(self, action: #selector(recallTapped), for: UIControlEvents.touchUpInside)
            
            self.view.addSubview(button)
        }
        
        recallPlus = UIButton(type: UIButtonType.system)
        recallPlus.frame = CGRect(x: 60, y: 650, width: 350, height: 70)
        recallPlus.titleLabel!.font = UIFont.systemFont(ofSize: 50)
        recallPlus.setTitle("add incorrect", for: UIControlState.normal)
        recallPlus.tintColor = UIColor.blue
        recallPlus.addTarget(self, action: #selector(recallPlusTapped), for: UIControlEvents.touchUpInside)
        self.view.addSubview(recallPlus)
        
        recallMinus = UIButton(type: UIButtonType.system)
        recallMinus.frame = CGRect(x: 450, y: 650, width: 410, height: 70)
        recallMinus.titleLabel!.font = UIFont.systemFont(ofSize: 50)
        recallMinus.setTitle("subtract incorrect", for: UIControlState.normal)
        recallMinus.tintColor = UIColor.blue
        recallMinus.addTarget(self, action: #selector(recallMinusTapped), for: UIControlEvents.touchUpInside)
        self.view.addSubview(recallMinus)
        
        recallLabel.frame = CGRect(x: 900, y: 650, width: 100, height: 70)
        recallLabel.font = UIFont.systemFont(ofSize: 50)
        recallLabel.text = "0"
        self.view.addSubview(recallLabel)
        
        print("here!!")
        
    }
    
    func recallPlusTapped(sender: UIButton!){
        
        recallIncorrect += 1
        recallLabel.text = String(recallIncorrect)
        
    }
    func recallMinusTapped(sender: UIButton!){
        
        recallIncorrect -= 1
        recallLabel.text = String(recallIncorrect)
        
    }
    
    func recallTapped(sender: UIButton!){
        for i in 0...buttonList.count-1 {
            if sender == buttonList[i] {
                print("In button \(i)")
                
                buttonTaps[i] = !(buttonTaps[i])
                
                if(buttonTaps[i] == true){
                    buttonList[i].tintColor = UIColor.blue
                }
                else{
                    buttonList[i].tintColor = UIColor.lightGray
                }
                
                /*
                 //change color to indicate tap
                 sender.backgroundColor = UIColor.darkGrayColor()
                 sender.enabled = false
                 
                 pressed.append(i)
                 */
                
            }
        }
    }
    
    
    @IBAction func nextButtonRecall(sender: AnyObject) {
        
        next1.isHidden = true
        next1.isEnabled = false
        
        for k in 0 ..< buttonList.count {
            buttonList[k].removeFromSuperview()
        }
        buttonList = [UIButton]()
        
        recallMinus.removeFromSuperview()
        recallPlus.removeFromSuperview()
        recallLabel.removeFromSuperview()
        
        let recognizeAlert = UIAlertController(title: "Recognize", message: "Choose the item you have seen before", preferredStyle: .alert)
        recognizeAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
            print("recognizing...")
            self.recognize()
            //action
        }))
        self.present(recognizeAlert, animated: true, completion: nil)
        
        
    }
    
    func recognize(){
        
        testCount = 0
        
        randomizeRecognize()
        
        if(orderRecognize[testCount] == 0){
            outputRecognizeImages(name1: imagesSM[testCount], name2: recognizeIncorrectSM[testCount])
        }
        else{
            outputRecognizeImages(name1: recognizeIncorrectSM[testCount], name2: imagesSM[testCount])
        }
        
        arrowButton1.isHidden = false
        arrowButton1.isEnabled = true
        
        arrowButton2.isHidden = false
        arrowButton2.isEnabled = true
        
        print("in recognize()")
        
    }
    
    @IBAction func recognize1(sender: AnyObject){
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
        
        nextButtonRecognize()
        
    }
    
    @IBAction func recognize2(sender: AnyObject){
        
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
        
        nextButtonRecognize()
        
    }
    
    func nextButtonRecognize(){
        
        testCount += 1
        
        if(testCount == imagesSM.count){
            
            arrowButton1.isHidden = true
            arrowButton2.isHidden = true
            
            done()
            
        }
            
        else{
            
            arrowButton1.isEnabled = true
            arrowButton2.isEnabled = true
            
            print("in nextButtonRecognize, testcount = \(testCount), orderRecognie.count = \(orderRecognize.count)")
            
            if(orderRecognize[testCount] == 0) {
                outputRecognizeImages(name1: imagesSM[testCount], name2: recognizeIncorrectSM[testCount])
            }
            else{
                outputRecognizeImages(name1: recognizeIncorrectSM[testCount], name2: imagesSM[testCount])
            }
            
        }
        
    }
    
    func done(){
        
        back.isEnabled = true
        
        afterBreakSM = false
        
        var recallResult = ""
        var recognizeResult = ""
        
        for k in 0 ..< imagesSM.count {
            
            if(buttonTaps[k] == true) {
                recallResult += "Recalled \(imagesSM[k]) correctly\n"
            }
            if(buttonTaps[k] == false) {
                recallResult += "Recalled \(imagesSM[k]) incorrectly\n"
            }
            
            if(recognizeErrors[k] == 0){
                recognizeResult += "Recognized \(imagesSM[k]) correctly in \(recognizeTimes[k]) seconds\n"
            }
            if(recognizeErrors[k] == 1){
                recognizeResult += "Recognized \(imagesSM[k]) incorrectly in \(recognizeTimes[k]) seconds\n"
            }
            let result = Results()
            result.name = "Simple Memory"
            result.startTime = StartTimer
            result.endTime = Foundation.Date()
            result.shortDescription = "(\(recognizeResult) and \(recallResult))"
            resultsArray.add(result)
        }
        
        recallResult += "\(recallIncorrect) item(s) incorrectly recalled"
        
        resultLabel.text = recallResult + recognizeResult
        Status[TestSimpleMemory] = TestStatus.Done
        
        
        start.isHidden = false
        start.isEnabled = true
        start.removeTarget(self, action: #selector(startNewTask), for:.touchUpInside)
        start.removeTarget(self, action: #selector(startDisplayAlert), for:.touchUpInside)
        start.addTarget(self, action: #selector(startAlert), for:.touchUpInside)
        
    }
    
    func randomizeRecognize(){
        
        //if 0, correct image on left; if 1, correct on right
        
        for k in 0 ..< 6 {
            orderRecognize.append(Int(arc4random_uniform(2)))
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
