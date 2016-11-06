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

        StartButton.isEnabled = true
        CorrectButton.isEnabled = false
        IncorrectButton.isEnabled = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawImage() {
        if curr < imagelist.count {
            let imageView = UIImageView(frame:CGRect(x: 100, y: 100, width: 600, height: 400))
            let image = UIImage(named: imagelist[curr])
            imageView.image = image
            imageView.layer.borderWidth = 2
            self.view.addSubview(imageView)
            
            let result = drawCustomImage(CGSize(width: 600, height: 400))
            
        } else {
            StartButton.isEnabled = true
            CorrectButton.isEnabled = false
            IncorrectButton.isEnabled = false
        }
    }
    
    @IBAction func StartAction(_ sender: UIButton) {
        curr = 0
        StartButton.isEnabled = false
        CorrectButton.isEnabled = true
        IncorrectButton.isEnabled = true
        
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
    
    
    @IBAction func CorrectAction(_ sender: UIButton) {
        correctList.append(imagelist[curr])
        curr  = curr + 1
        drawImage()
    }
    
    
    @IBAction func IncorrectAction(_ sender: UIButton) {
        incorrectList.append(imagelist[curr])
        curr  = curr + 1
        drawImage()
    }
    

    
    func drawCustomImage(_ size: CGSize) -> UIImage {
        
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
        
        return image!
    }
    
}
