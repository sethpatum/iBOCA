//
//  3DFigureCopy.swift
//  iBOCA
//
//  Created by Seth Amarasinghe on 8/29/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit

class ThreeDFigureCopy: UIViewController {

    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var CorrectButton: UIButton!
    @IBOutlet weak var IncorrectButton: UIButton!
    
    var imagelist = ["Backpack", "Bike", "Car"]
    var curr = 0
    var correctList = [String]()
    var incorrectList = [String]()
    
    var drawing : ThreeDFigureDraw!
    var drawingImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StartButton.enabled = true
        CorrectButton.enabled = false
        IncorrectButton.enabled = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawImage() {
        if curr < imagelist.count {
            var imageView = UIImageView(frame:CGRectMake(100, 100, 600, 400))
            let image = UIImage(named: imagelist[curr])
            imageView.image = image
            imageView.layer.borderWidth = 2
            self.view.addSubview(imageView)
            
            let result = drawCustomImage(CGSize(width: 600, height: 400))
            
        } else {
            StartButton.enabled = true
            CorrectButton.enabled = false
            IncorrectButton.enabled = false
        }
    }
    
    @IBAction func StartAction(sender: UIButton) {
        curr = 0
        StartButton.enabled = false
        CorrectButton.enabled = true
        IncorrectButton.enabled = true
        
        if  drawing != nil {
            drawing.removeFromSuperview()
        }
        
        if drawingImageView != nil {
            drawingImageView.removeFromSuperview()
            drawingImageView.image = nil
        }
       

        let drawingFrame = CGRect(x: 100, y: 600, width: 600, height: 400)
        drawing = ThreeDFigureDraw(frame: drawingFrame)
        drawing.layer.borderWidth = 2
        self.view.addSubview(drawing)
        
        drawImage()
    }
    
    
    @IBAction func CorrectAction(sender: UIButton) {
        correctList.append(imagelist[curr])
        curr  = curr + 1
        drawImage()
    }
    
    
    @IBAction func IncorrectAction(sender: UIButton) {
        incorrectList.append(imagelist[curr])
        curr  = curr + 1
        drawImage()
    }
    

    
    func drawCustomImage(size: CGSize) -> UIImage {
        
        // Setup our context
        //let bounds = CGRect(origin: CGPoint.zero, size: size)
        let opaque = false
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        //let context = UIGraphicsGetCurrentContext()
        
        // Setup complete, do drawing here
        drawing.drawandclearResults()  //background bubbles
        
        
        
        // Drawing complete, retrieve the finished image and cleanup
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
