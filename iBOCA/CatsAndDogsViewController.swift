//
//  CatsAndDogsViewController.swift
//  CatsAndDogs
//
//  Created by School on 7/25/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit

import Darwin

class CatsAndDogsViewController: ViewController {
    
    var buttonList = [UIButton]()
    var imageList = [UIImageView]()
    var places:[(Int,Int)] = [(150, 250), (450, 300), (350, 500), (600, 450), (800, 200), (700, 650), (850, 550), (250, 350), (150, 600), (300, 650)]
    //SHORTER LIST FOR TESTING: var places:[(Int,Int)] = [(100, 200), (450, 250), (350, 450), (600, 400)]
    var order = [Int]() //randomized order of buttons
    
    var pressed = [Int]()
    var correctDogs = [Int]()
    var missedDogs = [Int]()
    var incorrectCats = [Int]()
    var missedCats = [Int]()
    var incorrectRandom = [Int]()
    var times = [Double]()
    
    var timePassed = Double()
    
    var startTime = TimeInterval()
    var startTime2 = Foundation.Date()
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var cats = 0 //# cats
    var dogs = 1 //# dogs
    var level = 0 //current level
    var repetition = 0
    
    var ended = false
    
    @IBOutlet weak var backButton: UIButton!
    
//    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var endButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var selectionDoneButton: UIButton!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    //start from 1st button; reset all info
    
    @IBAction func Reset(_ sender: Any) {
        print("in reset")
        
        if(buttonList != nil){
            for k in 0 ..< buttonList.count {
                buttonList[k].removeFromSuperview()
            }
        }
        if(imageList != nil){
            for j in 0 ..< imageList.count {
                imageList[j].removeFromSuperview()
            }
        }
        
        buttonList = [UIButton]()
        imageList = [UIImageView]()
        order = [Int]()
        pressed = [Int]()
        correctDogs = [Int]()
        missedDogs = [Int]()
        incorrectCats = [Int]()
        missedCats = [Int]()
        incorrectRandom = [Int]()
        times = [Double]()
        timePassed = Double()
        startTime = TimeInterval()
        startTime2 = Foundation.Date()
        cats = 0 //# cats
        dogs = 1 //# dogs
        level = 0 //current level
        repetition = 0
        ended = false
//        startButton.isEnabled = false
        endButton.isEnabled = false
        resetButton.isEnabled = false
        selectionDoneButton.isEnabled = false
        backButton.isEnabled = true
        
//        StartTest(resetButton)
        startAlert()
        
        /*
        cats = 0
        dogs = 1
        level = 0
        
        self.resultsLabel.text = ""
        
        randomizeOrder()
        
        for (index, _) in self.order.enumerated() {
            self.buttonList[index].backgroundColor = UIColor.blue
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            
            self.display()
            self.startTime2 = NSDate()
        }
 */
        
    }
    
    func findTime()->Double{
        
        let currTime = NSDate.timeIntervalSinceReferenceDate
        var diff: TimeInterval = currTime - startTime
        print(diff)
        let minutes = UInt8(diff / 60.0)
        diff -= (TimeInterval(minutes)*60.0)
        let seconds = Double(diff)
        return seconds
        
    }
    
    //what happens when a user taps a button (if buttons are enabled at the time)
    func buttonAction(sender:UIButton!)
    {
        
        //print("Button tapped")
        
        timePassed = findTime()
        
        //find which button user has tapped
        for i in 0...buttonList.count-1 {
            if sender == buttonList[i] {
                print("In button \(i)")
                
                //change color to indicate tap
                sender.backgroundColor = UIColor.darkGray
                sender.isEnabled = false
                
                pressed.append(i)
                
                
            }
        }
        
    }
    
    //allow buttons to be pressed
    func enableButtons() {
        
        for (index, _) in order.enumerated() {
            buttonList[index].addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        }
        print("buttons enabled")
    }
    
    //stop buttons from being pressed
    func disableButtons() {
        for (index, _) in order.enumerated() {
            buttonList[index].removeTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        }
        print("buttons disabled")
    }
    
    
    //Rotate (180 degrees) or mirror (on x or y) the point
    var xt:Bool = true
    var yt:Bool = true
    func transform(coord:(Int, Int)) -> (Int, Int) {
        var x = coord.0
        var y = coord.1
        if xt  {
            x  = 950 - x
        }
        if yt {
            y = 850 - y
        }
        
        //return (Int(CGFloat(x)*screenSize!.maxX/1024.0), Int(CGFloat(y)*screenSize!.maxY/768.0))
        return (x, y)
    }
    
    
    func randomizeBoard() {
        xt = arc4random_uniform(2000) < 1000
        yt = arc4random_uniform(2000) < 1000
        places = places.map(transform)
    }
    
    
    //changes 'order' and 'buttonList' arrays, adds buttons; called in next, reset and viewDidLoad
    func randomizeOrder() {
        
        print("randomizing order")
        
        order = [Int]()
        //numplaces = 0
        
        var array = [Int]()
        for i in 0...places.count-1 {
            array.append(i)
        }
        
        
//IDK IF THIS WILL WORK BACKWARDS???
        
        for k in 0...places.count-1 {
            
            let j = places.count-1-k
            let random = Int(arc4random_uniform(UInt32(j)))
            order.append(array[random])
            array.remove(at: random)
        }
        
        
        print("order is \(order)")
        
        
    }
    
    //randomize 1st order; light up 1st button
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Cats And Dogs"
        
//        startButton.isEnabled = true
        endButton.isEnabled = false
        resetButton.isEnabled = false
        selectionDoneButton.isEnabled = false
        backButton.isEnabled = true
        print("here")
        startAlert()
        print("getting here")
        
        /*
        endButton.isEnabled = false
        resetButton.isEnabled = false
        
        randomizeBoard()
        
        randomizeOrder()
        
        for i in 0 ..< order.count {
            let(a,b) = places[order[i]]
            
            let x : CGFloat = CGFloat(a)
            let y : CGFloat = CGFloat(b)
            
            if(i <= dogs - 1) {
                
                let image = UIImage(named: "dog")!
                let imageView = UIImageView(frame:CGRect(x: x, y: y, width: 100.0*(image.size.width)/(image.size.height), height: 100.0))
                imageView.image = image
                self.view.addSubview(imageView)
                imageList.append(imageView)
                
            }
                
            else {
                if(i <= cats + dogs - 1) {
                    
                    let image = UIImage(named: "cat1")!
                    let imageView = UIImageView(frame:CGRect(x: x, y: y, width: 100.0*(image.size.width)/(image.size.height), height: 100.0))
                    imageView.image = image
                    self.view.addSubview(imageView)
                    imageList.append(imageView)
                    
                }
            }
            
            let button = UIButton(type: UIButtonType.system)
            buttonList.append(button)
            button.frame = CGRect(x: x, y: y, width: 100, height: 100)
            button.backgroundColor = UIColor.blue
            self.view.addSubview(button)
            
        }
 */
        
    }
    
    func startAlert(){
        
        print("getting to start alert")
        
        let alert = UIAlertController(title: "Start", message: "Follow instructions to tap cats and dogs behind the boxes.\nTap \"Done Tapping\" for next round.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Start", style: .default, handler: { (action) -> Void in
            self.StartTest()
        }))
  
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
//        self.present(alert, animated: true, completion: nil)
        
    }
    
    func update(timer: Timer) {
    }
    
    func display(){
        print("Displaying...")
        
        selectionDoneButton.isEnabled = false
        endButton.isEnabled = false
        resetButton.isEnabled = false
        
        for index in 0 ..< order.count {
            UIView.animate(withDuration: 0.6, animations:{
                self.buttonList[index].frame = CGRect(x: self.buttonList[index].frame.origin.x - 110, y: self.buttonList[index].frame.origin.y, width: self.buttonList[index].frame.size.width, height: self.buttonList[index].frame.size.height)
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1){
            for index in 0 ..< self.order.count {
                UIView.animate(withDuration: 0.6, animations:{
                    self.buttonList[index].frame = CGRect(x: self.buttonList[index].frame.origin.x + 110, y: self.buttonList[index].frame.origin.y, width: self.buttonList[index].frame.size.width, height:
                        self.buttonList[index].frame.size.height)
                })
            }
            /*
            self.selectionDoneButton.isEnabled = true
            
            self.enableButtons()
            self.startTime = NSDate.timeIntervalSinceReferenceDate
 */
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7){
            self.selectionDoneButton.isEnabled = true
            self.endButton.isEnabled = true
            self.resetButton.isEnabled = true
            self.enableButtons()
            self.startTime = NSDate.timeIntervalSinceReferenceDate
        }
        
    }
    
    func StartTest() {
        endButton.isEnabled = false
        resetButton.isEnabled = false
        selectionDoneButton.isEnabled = false
//        startButton.isEnabled = false
        backButton.isEnabled = false
        
        randomizeBoard()
        
        randomizeOrder()
        
        for i in 0 ..< order.count {
            let(a,b) = places[order[i]]
            
            let x : CGFloat = CGFloat(a)
            let y : CGFloat = CGFloat(b)
            
            if(i <= dogs - 1) {
                
                let image = UIImage(named: "dog")!
                let imageView = UIImageView(frame:CGRect(x: x, y: y, width: 100.0*(image.size.width)/(image.size.height), height: 100.0))
                imageView.image = image
                self.view.addSubview(imageView)
                imageList.append(imageView)
                
            }
                
            else {
                if(i <= cats + dogs - 1) {
                    
                    let image = UIImage(named: "cat1")!
                    let imageView = UIImageView(frame:CGRect(x: x, y: y, width: 100.0*(image.size.width)/(image.size.height), height: 100.0))
                    imageView.image = image
                    self.view.addSubview(imageView)
                    imageList.append(imageView)
                    
                }
            }
            
            let button = UIButton(type: UIButtonType.system)
            buttonList.append(button)
            button.frame = CGRect(x: x, y: y, width: 100, height: 100)
            button.backgroundColor = UIColor.blue
            self.view.addSubview(button)
            
        }
        
        var timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
        startTime = NSDate.timeIntervalSinceReferenceDate
        
        ended = false
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        level = 0
        cats = 0
        dogs = 1
        
        
        alert(info: "Tap all the dogs", display: true, start: true)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
//            self.display()
//            self.startTime2 = NSDate()
//        }
        
        self.resultsLabel.text = ""
    }
    
    
    @IBAction func EndTest(_ sender: Any) {
        self.navigationItem.setHidesBackButton(false, animated:true)
//        startButton.isEnabled = false
        endButton.isEnabled = false
        selectionDoneButton.isEnabled = false
        resetButton.isEnabled = true
        backButton.isEnabled = true
        donetest()
        
    }
    
    func drawstart() {
        
    }
    
    func donetest() {
        ended = true
        
        
        let result = Results()
        result.name = "Cats and Dogs"
        result.startTime = startTime2 as Date
        result.endTime = Foundation.Date()
        
        for k in 0 ..< buttonList.count {
            buttonList[k].removeFromSuperview()
        }
        for j in 0 ..< imageList.count {
            imageList[j].removeFromSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.navigationItem.setHidesBackButton(false, animated:true)
//            self.startButton.isEnabled = false
            self.endButton.isEnabled = false
            self.resetButton.isEnabled = true
            self.backButton.isEnabled = true
            
            for (index, _) in self.order.enumerated() {
                self.buttonList[index].backgroundColor = UIColor.darkGray
                
            }
            
            var resulttxt = ""
            result.numErrors = 0
            
            for k in 0 ..< self.level {
                
                var r = ""
                if k < 15 {
                    r = "\(self.correctDogs[k]) dogs correctly selected out of \(self.missedDogs[k]+self.correctDogs[k]) dogs; \(self.incorrectCats[k]) cats incorrectly selected out of \(self.incorrectCats[k]+self.missedCats[k]) cats; \(self.incorrectRandom[k]) empty places incorrectly selected. Time: \(self.times[k]) seconds\n"
                    result.numErrors += self.missedDogs[k] + self.incorrectCats[k] + self.incorrectRandom[k]
                }
                else {
                    r = "\(self.correctDogs[k]) dogs incorrectly selected out of \(self.missedDogs[k]+self.correctDogs[k]) dogs; \(self.incorrectCats[k]) cats correctly selected out of \(self.incorrectCats[k]+self.missedCats[k]) cats; \(self.incorrectRandom[k]) empty places incorrectly selected. Time: \(self.times[k]) seconds\n"
                    result.numErrors += self.correctDogs[k] + self.missedCats[k] + self.incorrectRandom[k]
                }
                
                resulttxt.append(r)
                result.longDescription.add(r)
            }
            
            print(resulttxt)
            self.resultLabel.text = resulttxt
            
            result.json = ["None":""]
            resultsArray.add(result)
            
            Status[TestCatsAndDogs] = TestStatus.Done
            
        }
    }
    
    
    @IBAction func selectionDone(_ sender: Any) {
        
        disableButtons()
        
        times.append(timePassed)
        timePassed = 0
        
        print("selection done; dogs = \(dogs), cats = \(cats)")
        
        var dogCount = 0
        var catCount = 0
        var otherCount = 0
        for k in 0 ..< pressed.count {
            if(pressed[k] < dogs){
                dogCount += 1
            }
            else {
                if(pressed[k] < dogs + cats){
                    catCount += 1
                }
                else {
                    otherCount += 1
                }
            }
        }
        
        pressed = [Int]()
        
        print("catCount = \(catCount), dogCount = \(dogCount), otherCount = \(otherCount), time = \(timePassed)")
        correctDogs.append(dogCount)
        missedDogs.append(dogs-dogCount)
        incorrectCats.append(catCount)
        missedCats.append(cats-catCount)
        incorrectRandom.append(otherCount)
        
        next()
    }
    
    
    //  level        0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
    let levelcats = [0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 4, 4, 4, 4, 4, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
    let leveldogs = [1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 2, 2, 2, 2, 2, 4, 4, 4, 4, 4]
    
    //user completed sequence; reset repeats, increase numplaces so 1 more button lights up
    func next(){
        
        level += 1
        
        print("next; level = \(level)")
        
        if (level == 25){
            if(repetition<0) {
                level = 0
                repetition += 1
            }
            else {
                donetest()
            }
        }
            
        else {
            cats = levelcats[level]
            dogs = leveldogs[level]
            
            randomizeOrder()
            print("order randomized; cats = \(cats), dogs = \(dogs)")
            
            for k in 0 ..< buttonList.count {
                buttonList[k].removeFromSuperview()
            }
            for k in 0 ..< imageList.count {
                imageList[k].removeFromSuperview()
            }
            buttonList = [UIButton]()
            imageList = [UIImageView]()
            
            for i in 0 ..< order.count {
                let(a,b) = places[order[i]]
                
                let x : CGFloat = CGFloat(a)
                let y : CGFloat = CGFloat(b)
                
                if(i <= dogs - 1) {
                    
                    let image = UIImage(named: "dog")!
                    let imageView = UIImageView(frame:CGRect(x: x, y: y, width: 100.0*(image.size.width)/(image.size.height), height: 100.0))
                    imageView.image = image
                    self.view.addSubview(imageView)
                    imageList.append(imageView)
                    
                    //print("shoulda added dog images")
                    
                }
                    
                else {
                    if(i <= cats + dogs - 1) {
                        
                        let image = UIImage(named: "cat1")!
                        let imageView = UIImageView(frame:CGRect(x: x, y: y, width: 100.0*(image.size.width)/(image.size.height), height: 100.0))
                        imageView.image = image
                        self.view.addSubview(imageView)
                        imageList.append(imageView)
                        
                        //print("shoulda added cat images")
                        
                    }
                }
                
                let button = UIButton(type: UIButtonType.system)
                buttonList.append(button)
                button.frame = CGRect(x: x, y: y, width: 100, height: 100)
                button.backgroundColor = UIColor.blue
                self.view.addSubview(button)
                
                //print("shoulda added buttons")
                
            }
            
            if(level == 0){
                alert(info: "Tap all the dogs.\nPress \"Done Tapping\" to continue.", display: true, start: true)
            }
            if(level == 5){
                alert(info: "Tap all the dogs.\nDo NOT tap the cats.\nPress \"Done Tapping\" to continue.", display: true, start: false)
            }
            if(level == 15){
                alert(info: "Tap all the cats.\nDo NOT tap the dogs.\nPress \"Done Tapping\" to continue.", display: true, start: false)
            }
            
            if(level != 0 && level != 5 && level != 15){
                display()
            }
            
        }
    }
    
    func alert(info:String, display: Bool, start: Bool){
        let alert = UIAlertController(title: "Instructions", message: info, preferredStyle: .alert)
        /*
         //2. Add the text field. You can configure it however you need.
         
         alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
         textField.text = ""
         
         })
         */
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            if(display == true){
                self.display()
            }
            if(start == true){
                self.startTime2 = Foundation.Date()
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
}



