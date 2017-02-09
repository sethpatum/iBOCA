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
class SimpleMemoryTask: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var delayLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
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
    var imageView1 = UIImageView()
    
    var imageName2 = ""
    var image2 = UIImage()
    var imageView2 = UIImageView()
    
    var buttonList = [UIButton]()
    
    var buttonTaps = [Bool]()
    
    var arrowButton1 = UIButton()
    var arrowButton2 = UIButton()
    
    var orderRecognize = [Int]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged))
        
        let arrowpic = UIImage(named: "arrow") as UIImage?
        
        arrowButton1 = UIButton(type: UIButtonType.custom) as UIButton
        arrowButton1.frame = CGRect(x: 211, y: 670, width: 90, height: 90)
        arrowButton1.setImage(arrowpic, for: .normal)
        arrowButton1.addTarget(self, action: #selector(recognize1), for:.touchUpInside)
        arrowButton1.isHidden = true
        self.view.addSubview(arrowButton1)
        
        arrowButton2 = UIButton(type: UIButtonType.custom) as UIButton
        arrowButton2.frame = CGRect(x: 723, y: 670, width: 90, height: 90)
        arrowButton2.setImage(arrowpic, for: .normal)
        arrowButton2.addTarget(self, action: #selector(recognize2), for:.touchUpInside)
        arrowButton2.isHidden = true
        self.view.addSubview(arrowButton2)
        
        next1.isHidden = true
        
        back.isEnabled = true
//        start.isEnabled = true
        
        if(afterBreakSM == true){
            timerSM = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateInDelay), userInfo: nil, repeats: true)
            delayLabel.text = "Recommended delay: 1 minute"
            start.isHidden = false
        }
        else{
            start.isHidden = true
            startAlert()
        }
        
    }
    
    func startAlert(){
        
        back.isEnabled = false
        next1.isHidden = true
        
        let startAlert = UIAlertController(title: "Start", message: "Choose start option", preferredStyle: .alert)
        
        startAlert.addAction(UIAlertAction(title: "Start New Task", style: .default, handler: { (action) -> Void in
            print("start new")
            Status[TestSimpleMemory] = TestStatus.Running
            self.startNewTask()
            //action
        }))
        
        if(afterBreakSM == true){
            startAlert.addAction(UIAlertAction(title: "Resume Task", style: .default, handler: { (action) -> Void in
                print("resume old")
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
    
    @IBAction func startButton(_ sender: Any) {
        
        start.isHidden = true
        back.isEnabled = false
        
        next1.isHidden = true
        
        startAlert()
        
/*
        let startAlert = UIAlertController(title: "Start", message: "Choose start option", preferredStyle: .alert)
        
        startAlert.addAction(UIAlertAction(title: "Start New Task", style: .default, handler: { (action) -> Void in
            print("start new")
            self.startNewTask()
            //action
        }))
        
        if(afterBreakSM == true){
            startAlert.addAction(UIAlertAction(title: "Resume Task", style: .default, handler: { (action) -> Void in
                print("resume old")
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
 */
        
    }
    
    func startNewTask(){
        
        timerSM.invalidate()
        
        recognizeIncorrectSM = [String]()
        imagesSM = [String]()
        buttonTaps = [Bool]()
        testCount = 0
        recognizeTimes = [Double]()
        recognizeErrors = [Int]()
        orderRecognize = [Int]()
        resultLabel.text = ""
        timerLabel.text = ""
        delayLabel.text = ""
        afterBreakSM = false
        
        
        start.isHidden = true
        
        chooseImageSet()
        
        let newStartAlert = UIAlertController(title: "Display", message: "Name and try to remember these images", preferredStyle: .alert)
        newStartAlert.addAction(UIAlertAction(title: "Start", style: .default, handler: { (action) -> Void in
            print("start")
            self.display()
            //action
        }))
        self.present(newStartAlert, animated: true, completion: nil)
        
    }
    
    func chooseImageSet(){
        
        imageSetSM = Int(arc4random_uniform(8))
        incorrectImageSetSM = imageSetSM
        
        while(imageSetSM == incorrectImageSetSM){
            incorrectImageSetSM = Int(arc4random_uniform(8))
        }
        
        if(imageSetSM == 0) {
            imagesSM = images0
        }
        if(incorrectImageSetSM == 0){
            recognizeIncorrectSM = images0
        }
        
        if(imageSetSM == 1) {
            imagesSM = images1
        }
        if(incorrectImageSetSM == 1){
            recognizeIncorrectSM = images1
        }
        
        if(imageSetSM == 2) {
            imagesSM = images2
        }
        if(incorrectImageSetSM == 2){
            recognizeIncorrectSM = images2
        }
        
        if(imageSetSM == 3) {
            imagesSM = images3
        }
        if(incorrectImageSetSM == 3){
            recognizeIncorrectSM = images3
        }
        
        if(imageSetSM == 4) {
            imagesSM = images4
        }
        if(incorrectImageSetSM == 4){
            recognizeIncorrectSM = images4
        }
        
        if(imageSetSM == 5) {
            imagesSM = images5
        }
        if(incorrectImageSetSM == 5){
            recognizeIncorrectSM = images5
        }
        
        if(imageSetSM == 6) {
            imagesSM = images6
        }
        if(incorrectImageSetSM == 6){
            recognizeIncorrectSM = images6
        }
        
        if(imageSetSM == 7) {
            imagesSM = images7
        }
        if(incorrectImageSetSM == 7){
            recognizeIncorrectSM = images7
        }
        
    }
    
    func display(){
        
        testCount = 0
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
        
        imageView1.removeFromSuperview()
        imageView2.removeFromSuperview()
        
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
        
        imageView1 = UIImageView(frame: CGRect(x: (256.0-(x1/2)), y: (471.0-(y1/2)), width: x1, height: y1))
        imageView2 = UIImageView(frame: CGRect(x: (768.0-(x2/2)), y: (471.0-(y2/2)), width: x2, height: y2))
        
        imageView1.image = image1
        imageView2.image = image2
        
        self.view.addSubview(imageView1)
        self.view.addSubview(imageView2)
        
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
        
        var places = [(312, 175), (312, 250), (312, 325), (312, 400), (312, 475), (312, 550), (312, 625)]
        
        for k in 0 ..< 7 {
            let(a,b) = places[k]
            
            let x : CGFloat = CGFloat(a)
            let y : CGFloat = CGFloat(b)
            
            let button = UIButton(type: UIButtonType.system)
            buttonList.append(button)
            buttonTaps.append(false)
            button.frame = CGRect(x: x, y: y, width: 400, height: 70)
            button.titleLabel!.font = UIFont.systemFont(ofSize: 50)
            
            if(k < 6){
                button.setTitle(imagesSM[k], for: UIControlState.normal)
            }
            else{
                button.setTitle("incorrect", for: UIControlState.normal)
            }
            
            button.tintColor = UIColor.lightGray
            
            button.addTarget(self, action: #selector(recallTapped), for: UIControlEvents.touchUpInside)
            
            self.view.addSubview(button)
        }
        
        print("here!!")
        
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
        
        let recognizeAlert = UIAlertController(title: "Recognize", message: "Choose the item you have seen before", preferredStyle: .alert)
        recognizeAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
            print("recognizing...")
            self.recognize()
            //action
        }))
        self.present(recognizeAlert, animated: true, completion: nil)
        
        
    }
    
    func recognize(){
        
//        next1.removeTarget(self, action: #selector(nextButtonRecall), for:.touchUpInside)
//        next1.addTarget(self, action: #selector(nextButtonRecognize), for:.touchUpInside)
//        next1.isHidden = false
//        next1.isEnabled = true
        
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
//        next1.isEnabled = true
        
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
//        next1.isEnabled = true
        
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
//            next1.isHidden = true
            
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
            
            done()
            
        }
            
        else{
            
//            next1.isEnabled = false
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
        start.isHidden = false
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
        
        if(buttonTaps[imagesSM.count] == true){
            recallResult += "Some item(s) incorrectly recalled"
        }
        
        resultLabel.text = recallResult + recognizeResult
        Status[TestSimpleMemory] = TestStatus.Done
        
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
