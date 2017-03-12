//
//  NamingPicturesViewController.swift
//  Integrated test v1
//
//  Created by Seth Amarasinghe on 7/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//
import UIKit

class PicturesViewController: ViewController {
    
    let namingImages:[String] = ["ring", "chimney", "clover", "ladle", "piano", "eyebrow", "shovel", "lighthouse", "goggles", "horseshoe", "corkscrew", "anvil", "yarn", "llama", "skeleton"]

    
    var imageName = "House"
    var count = 0
    var corr = 0
    
    @IBOutlet weak var placeLabel: UILabel!
    
    var order = [Bool]()
    var startTime2 = NSDate()
    var startTime = Foundation.Date()
    
    @IBOutlet weak var correctButton: UIButton!
    
    @IBOutlet weak var incorrectButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton! //"Undo" button
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var homeButton: UIButton! //"Back" button
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    
    var imageView = UIImageView()
    
    
    var totalCount = Int()
    
    var wrongList = [String]()
    
    
    var resultImage : [String] = []
    var resultStatus : [String] = []
    var resultTime : [Date] = []
    
    
    
    @IBAction func reset(_ sender: Any) {
        
        resetButton.isEnabled = false
        backButton.isEnabled = false
        self.navigationItem.setHidesBackButton(false, animated:true)
        
        done()
        
        order = [Bool]()
        wrongList = [String]()
        count = 0
        corr = 0
        imageName = getImageName()
        resultStatus.removeAll()
        resultTime.removeAll()
        resultImage.removeAll()
        
        let image4 = UIImage(named: imageName)
        fixDimensions(image: image4!)
        imageView.image = image4
        
        correctButton.isEnabled = true
        incorrectButton.isEnabled = true
        
        placeLabel.text = "\(count+1)/\(namingImages.count)"
        
    }
    
    @IBAction func correct(_ sender: Any) {
        
        homeButton.isEnabled = false
        correctButton.isEnabled = true
        incorrectButton.isEnabled = true
        resetButton.isEnabled = true
        backButton.isEnabled = true
        
        
        resultsLabel.text = ""
        
        if(count == 0) {
            startTime2 = NSDate()
            self.navigationItem.setHidesBackButton(true, animated:true)
            backButton.isEnabled = true
            resetButton.isEnabled = true
        }
        
        count += 1
        corr += 1
        
        resultImage.append(imageName)
        resultStatus.append("Correct")
        let currTime = Foundation.Date()
        resultTime.append(currTime)
        
        if(count==totalCount){
            done()
        }
            
        else{
            
            imageName = getImageName()
            
            let image1 = UIImage(named: imageName)
            
            fixDimensions(image: image1!)
            
            imageView.image = image1
            
            order.append(true)
            

            if count != namingImages.count {
                placeLabel.text = "\(count+1)/\(namingImages.count)"
            }
        }
        
    }
    
    
    @IBAction func incorrect(_ sender: Any) {
        
        homeButton.isEnabled = false
        correctButton.isEnabled = true
        incorrectButton.isEnabled = true
        resetButton.isEnabled = true
        backButton.isEnabled = true
        
        resultsLabel.text = ""
        
        if(count == 0) {
            startTime2 = NSDate()
            self.navigationItem.setHidesBackButton(true, animated:true)
            backButton.isEnabled = true
            resetButton.isEnabled = true
        }
        
        count += 1
        wrongList.append(imageName)
        
        resultImage.append(imageName)
        resultStatus.append("Incorrect")
        let currTime = Foundation.Date()
        resultTime.append(currTime)

        
        if(count==totalCount){
            done()
        }
            
        else{
            imageName = getImageName()
            
            let image2 = UIImage(named: imageName)
            fixDimensions(image: image2!)
            imageView.image = image2
            
            order.append(false)
            
            if count != namingImages.count-1 {
                placeLabel.text = "\(count+1)/\(namingImages.count)"
            }
            
        }
        
    }
    
    @IBAction func back(_ sender: Any) {
        
        homeButton.isEnabled = false
        correctButton.isEnabled = true
        incorrectButton.isEnabled = true
        resetButton.isEnabled = true
        backButton.isEnabled = true
        
        count -= 1
        if count == 0 {
            resetButton.isEnabled = false
            backButton.isEnabled = false
            self.navigationItem.setHidesBackButton(false, animated:true)
        }
        if order.count > 0 {
            if order[order.count-1] == true {
                corr -= 1
            }
            else {
                wrongList.remove(at: wrongList.count-1)
            }
            
            order.remove(at: order.count-1)
        }
        
        imageName = getImageName()
        
        let image3 = UIImage(named: imageName)
        fixDimensions(image: image3!)
        imageView.image = image3
        
        placeLabel.text = "\(count+1)/\(namingImages.count)"
        
    }
    
    func done() {
        
        print("getting here")
        
        backButton.isEnabled = false
        correctButton.isEnabled = false
        incorrectButton.isEnabled = false
        resetButton.isEnabled = false
        homeButton.isEnabled = true
        
        imageView.removeFromSuperview()
        
        placeLabel.text = ""
        
        let result = Results()
        result.name = self.title
        result.startTime = startTime2 as Date
        result.endTime = NSDate() as Date
        result.longDescription.add("\(corr) correct out of \(count)")
        if wrongList.count > 0  {
            result.longDescription.add("The incorrect pictures were the \(wrongList)")
        }
        
        var js : [String:Any] = [:]
        for (index, element) in resultStatus.enumerated() {
            let val = ["image":resultImage[index], "status":element, "time (msec)":Int(1000*resultTime[index].timeIntervalSince(startTime))] as [String : Any]
            js[String(index)] = val
        }
        result.json["Results"] = js

        
        resultsArray.add(result)
        Status[TestNampingPictures] = TestStatus.Done
        
        var str:String = "\(corr) correct out of \(count)"
        if wrongList.count > 0 {
            str += "\nThe incorrect pictures were the \(wrongList)"
        }
        self.resultsLabel.text = str
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedTest, terminator: "")
        self.title = "Naming Pictures"
        totalCount = namingImages.count
        
        count = 0
        corr = 0
        imageName = getImageName()
        
        let image = UIImage(named: imageName)
        
        imageView = UIImageView()
        
        fixDimensions(image: image!)
        
        imageView.image = image
        self.view.addSubview(imageView)
        
        correctButton.isEnabled = true
        incorrectButton.isEnabled = true
        backButton.isEnabled = false
        resetButton.isEnabled = false
        homeButton.isEnabled = true
        
    }
    
    func getImageName()->String{
        
        print(count)
            
        return namingImages[count]
        
    }
    
    func fixDimensions(image:UIImage){
        
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
        
        imageView.frame = CGRect(x: (512.0-(x/2)), y: (471.0-(y/2)), width: x, height: y)
        
    }
    
    
}

