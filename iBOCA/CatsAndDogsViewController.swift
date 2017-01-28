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
    var startTime2 = NSDate()
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var cats = 0 //# cats
    var dogs = 1 //# dogs
    var level = 0 //current level
    var repetition = 0
    
    var ended = false
    
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var endButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var helpButton: UIButton!
    
    @IBOutlet weak var selectionDoneButton: UIButton!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    //start from 1st button; reset all info
    
    @IBAction func Reset(_ sender: Any) {
        print("in reset")
        
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
        
    }
    
    
    func update(timer: Timer) {
    }
    
    func display(){
        print("Displaying...")
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
            self.enableButtons()
            self.startTime = NSDate.timeIntervalSinceReferenceDate
        }
    }
    
    @IBAction func StartTest(_ sender: Any) {
        
        var timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
        self.startTime = NSDate.timeIntervalSinceReferenceDate
        
        self.ended = false
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        self.helpButton.isEnabled = false
        self.startButton.isEnabled = false
        self.endButton.isEnabled = true
        self.resetButton.isEnabled = true
        
        self.level = 0
        self.cats = 0
        self.dogs = 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.display()
            self.startTime2 = NSDate()
        }
        
        self.resultsLabel.text = ""
    }
    
    
    @IBAction func EndTest(_ sender: Any) {
        self.navigationItem.setHidesBackButton(false, animated:true)
        helpButton.isEnabled = true
        startButton.isEnabled = true
        endButton.isEnabled = false
        resetButton.isEnabled = false
        donetest()
        
    }
    
    func drawstart() {
        
    }
    
    func donetest() {
        
        ended = true
        
        for k in 0 ..< buttonList.count {
            buttonList[k].removeFromSuperview()
        }
        for j in 0 ..< imageList.count {
            imageList[j].removeFromSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.navigationItem.setHidesBackButton(false, animated:true)
            self.helpButton.isEnabled = true
            self.startButton.isEnabled = true
            self.endButton.isEnabled = false
            self.resetButton.isEnabled = false
            
            for (index, _) in self.order.enumerated() {
                self.buttonList[index].backgroundColor = UIColor.darkGray
                
            }
            
            var result = ""
            
            for k in 0 ..< 25 {
                result += "\(self.correctDogs[k]) dogs correctly selected out of \(self.missedDogs[k]+self.correctDogs[k]) dogs; \(self.incorrectCats[k]) cats incorrectly selected out of \(self.incorrectCats[k]+self.missedCats[k]) cats; \(self.incorrectRandom[k]) empty places incorrectly selected. Time: \(self.times[k]) seconds\n"
            }
            
            self.resultLabel.text = result
            
            
            
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
            
            if(level == 0){
                alert(info: "Tap all the dogs")
                cats = 0
                dogs = 1
            }
            if(level == 1){
                cats = 0
                dogs = 2
            }
            if(level == 2){
                cats = 0
                dogs = 3
            }
            if(level == 3){
                cats = 0
                dogs = 4
            }
            if(level == 4){
                cats = 0
                dogs = 5
            }
            
            if(level == 5){
                alert(info: "Tap all the dogs.\nDo NOT tap the cats")
                cats = 2
                dogs = 1
            }
            if(level == 6){
                cats = 2
                dogs = 2
            }
            if(level == 7){
                cats = 2
                dogs = 3
            }
            if(level == 8){
                cats = 2
                dogs = 4
            }
            if(level == 9){
                cats = 2
                dogs = 5
            }
            
            if(level == 10){
                cats = 4
                dogs = 1
            }
            if(level == 11){
                cats = 4
                dogs = 2
            }
            if(level == 12){
                cats = 4
                dogs = 3
            }
            if(level == 13){
                cats = 4
                dogs = 4
            }
            if(level == 14){
                cats = 4
                dogs = 5
            }
            
            if(level == 15){
                alert(info: "Tap all the cats.\nDo NOT tap the dogs")
                dogs = 2
                cats = 1
            }
            if(level == 16){
                dogs = 2
                cats = 2
            }
            if(level == 17){
                dogs = 2
                cats = 3
            }
            if(level == 18){
                dogs = 2
                cats = 4
            }
            if(level == 19){
                dogs = 2
                cats = 5
            }
            
            if(level == 20){
                dogs = 4
                cats = 1
            }
            if(level == 21){
                dogs = 4
                cats = 2
            }
            if(level == 22){
                dogs = 4
                cats = 3
            }
            if(level == 23){
                dogs = 4
                cats = 4
            }
            if(level == 24){
                dogs = 4
                cats = 5
            }
            
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
            
            display()
            
        }
    }
    
    func alert(info:String){
        let alert = UIAlertController(title: "Instructions", message: info, preferredStyle: .alert)
        /*
         //2. Add the text field. You can configure it however you need.
         
         alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
         textField.text = ""
         
         })
         */
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    /*
    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
        
    //delay function
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
        
    }
 
    func getColor(i: Double, alpha: Double = 1.0) ->CGColor {
        if (i < 5.0) {
            let h = CGFloat(0.3 - i / 15.0)
            return UIColor(hue: h, saturation: 1.0, brightness: 1.0, alpha: CGFloat(alpha)).cgColor
        } else if (i < 60) {
            let b = CGFloat((60.0 - i)/55.0)
            return UIColor(hue: 0.0, saturation: 1.0, brightness: b, alpha: CGFloat(alpha)).cgColor
        } else {
            return UIColor(hue: 0.0, saturation: 1.0, brightness: 0.0, alpha: CGFloat(alpha)).cgColor
        }
    }
    */
}


