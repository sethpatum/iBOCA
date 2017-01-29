//
//  NamingPicturesViewController.swift
//  Integrated test v1
//
//  Created by Seth Amarasinghe on 7/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//
import UIKit

class PicturesViewController: ViewController {
    
    var imageName = "House"
    var count = 0
    var corr = 0
    @IBOutlet weak var placeLabel: UILabel!
    
    var order = [Bool]()
    var startTime2 = NSDate()
    
    @IBOutlet weak var correctButton: UIButton!
    
    @IBOutlet weak var incorrectButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    var totalCount = Int()
    
    var wrongList = [String]()
    
/*
    @IBAction func HelpButton(sender: AnyObject) {
        if(selectedTest == "Naming Pictures") {
            let vc = storyboard!.instantiateViewController(withIdentifier: "Naming Pictures Help") as UIViewController
            navigationController?.pushViewController(vc, animated:true)
        } else {
            let vc = storyboard!.instantiateViewController(withIdentifier: "Famous Faces Help") as UIViewController
            navigationController?.pushViewController(vc, animated:true)
        }
    }
 */
    
    
    @IBAction func reset(sender: AnyObject) {
        
        
        
        resetButton.isEnabled = false
        backButton.isEnabled = false
        self.navigationItem.setHidesBackButton(false, animated:true)
        
        done()
        
        order = [Bool]()
        wrongList = [String]()
        count = 0
        corr = 0
        imageName = getImageName()
        
        let imageView4 = UIImageView(frame:CGRect(x: 107.0, y: 171.0, width: 800.0, height: 600.0))
/*
        if(selectedTest == "Famous Faces") {
            imageView4 = UIImageView(frame:CGRect(x: 207.0, y: 171.0, width: 600.0, height: 600.0))
        }
*/
        let image4 = UIImage(named: imageName)
        imageView4.image = image4
        self.view.addSubview(imageView4)
        correctButton.isEnabled = true
        incorrectButton.isEnabled = true
        
//        if selectedTest == "Naming Pictures" {
            placeLabel.text = "\(count+1)/\(namingImages.count)"
//        }
//        else {
//            placeLabel.text = "\(count+1)/\(namingImages2.count)"
//        }
        
    }
    
    @IBAction func correct(sender: AnyObject) {
        
        
        resultsLabel.text = ""
        
        if(count == 0) {
            startTime2 = NSDate()
            self.navigationItem.setHidesBackButton(true, animated:true)
            backButton.isEnabled = true
            resetButton.isEnabled = true
        }
        
        count += 1
        corr += 1
        
        if(count==totalCount){
            done()
        }
            
        else{
            
            imageName = getImageName()
            
            let imageView1 = UIImageView(frame:CGRect(x: 107.0, y: 171.0, width: 800.0, height: 600.0))
            
/*
            if(selectedTest == "Famous Faces") {
                imageView1 = UIImageView(frame:CGRect(x: 207.0, y: 171.0, width: 600.0, height: 600.0))
            }
*/
            
            let image1 = UIImage(named: imageName)
            imageView1.image = image1
            self.view.addSubview(imageView1)
            
            order.append(true)
            
//            if selectedTest == "Naming Pictures" {
                if count != namingImages.count {
                    placeLabel.text = "\(count+1)/\(namingImages.count)"
                }
//            }
/*
            else {
                if count != namingImages2.count {
                    placeLabel.text = "\(count+1)/\(namingImages2.count)"
                }
            }
 */
            
        }
        
    }
    
    @IBAction func incorrect(sender: AnyObject) {
        
        resultsLabel.text = ""
        
        if(count == 0) {
            startTime2 = NSDate()
            self.navigationItem.setHidesBackButton(true, animated:true)
            backButton.isEnabled = true
            resetButton.isEnabled = true
        }
        
        count += 1
        wrongList.append(imageName)
        
        if(count==totalCount){
            done()
        }
            
        else{
            imageName = getImageName()
            let imageView2 = UIImageView(frame:CGRect(x: 107.0, y: 171.0, width: 800.0, height: 600.0))
/*
            if(selectedTest == "Famous Faces") {
                imageView2 = UIImageView(frame:CGRect(x: 207.0, y: 171.0, width: 600.0, height: 600.0))
            }
*/
            let image2 = UIImage(named: imageName)
            imageView2.image = image2
            self.view.addSubview(imageView2)
            
            order.append(false)
            
//            if selectedTest == "Naming Pictures" {
                if count != namingImages.count-1 {
                    placeLabel.text = "\(count+1)/\(namingImages.count)"
                }
//            }
/*
            else {
                if count != namingImages2.count-1 {
                    placeLabel.text = "\(count+1)/\(namingImages2.count)"
                }
            }
 */
            
        }
        
    }
    
    @IBAction func back(sender: AnyObject) {
        
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
        
        let imageView3 = UIImageView(frame:CGRect(x: 107.0, y: 171.0, width: 800.0, height: 600.0))
/*
        if(selectedTest == "Famous Faces") {
            imageView3 = UIImageView(frame:CGRect(x: 207.0, y: 171.0, width: 600.0, height: 600.0))
        }
*/
        let image3 = UIImage(named: imageName)
        imageView3.image = image3
        self.view.addSubview(imageView3)
        
//        if selectedTest == "Naming Pictures" {
            placeLabel.text = "\(count+1)/\(namingImages.count)"
//        }
//        else {
//            placeLabel.text = "\(count+1)/\(namingImages2.count)"
//        }
        
    }
    
    func done() {
        
        print("getting here")
        
        backButton.isEnabled = false
        correctButton.isEnabled = false
        incorrectButton.isEnabled = false
        self.navigationItem.setHidesBackButton(false, animated:true)
        
        placeLabel.text = ""
        
        let result = Results()
        result.name = self.title
        result.startTime = startTime2 as Date
        result.endTime = NSDate() as Date
        result.longDescription.add("\(corr) correct out of \(count)")
        if wrongList.count > 0  {
            result.longDescription.add("The incorrect pictures were the \(wrongList)")
        }
        resultsArray.add(result)
        
//        if resultsDisplayOn == true {
            var str:String = "\(corr) correct out of \(count)"
            if wrongList.count > 0 {
                str += "\nThe incorrect pictures were the \(wrongList)"
            }
            self.resultsLabel.text = str
//        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedTest, terminator: "")
//        if(selectedTest == "Naming Pictures") {
            self.title = "Naming Pictures"
            totalCount = namingImages.count
//        } else {
//            self.title = "Famous People"
//            totalCount = namingImages2.count
//        }
        
        count = 0
        corr = 0
        imageName = getImageName()
        
        let imageView = UIImageView(frame:CGRect(x: 107.0, y: 171.0, width: 800.0, height: 600.0))
/*
        if(selectedTest == "Famous Faces") {
            imageView = UIImageView(frame:CGRect(x: 207.0, y: 171.0, width: 600.0, height: 600.0))
        }
*/
        let image = UIImage(named: imageName)
        imageView.image = image
        self.view.addSubview(imageView)
        
        backButton.isEnabled = false
        resetButton.isEnabled = false
        
//        if selectedTest == "Naming Pictures" {
            placeLabel.text = "\(count+1)/\(namingImages.count)"
//        }
//        else {
//            placeLabel.text = "\(count+1)/\(namingImages2.count)"
//        }
    }
    
/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
    }
 */
    let namingImages:[String] = ["Ring", "Chimney", "Clover", "Ladle", "Piano", "Eyebrow", "Shovel", "Lighthouse", "Goggles", "Horseshoe", "Corkscrew", "Anvil", "Yarn", "Llama", "Skeleton"]
    let namingImages2:[String] = ["A. Schwarzenegger", "B. Clinton", "B. Murray", "B. Obama", "E. Presley", "G. Bush", "G. Clooney", "H. Clinton", "J. Leno", "J. Travolta", "M. Monroe", "M. Obama", "MLK", "O. Winfrey", "R. Williams", "R. Williams"]
    
    func getImageName()->String{
        
//        if(selectedTest == "Naming Pictures") {
            print(count)
            
            return namingImages[count]
//        } else {
//            return namingImages2[count]
//        }
        
    }
    
    
}

