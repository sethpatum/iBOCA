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
    @IBOutlet weak var BackButton: UIButton!
    
    var imagelist = ["Circle2", "rhombus", "SquareTriangle", "rectprism"]
    var curr = 0
    var resultImages : [UIImage] = []
    var resultCondition : [Bool] = []
    var resultTime : [Double] = []
    var startTime  = Foundation.Date()
    var startTime2 = Foundation.Date()
    
    var drawing : ThreeDFigureDraw!
    var drawingImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StartButton.isEnabled = true
        BackButton.isHidden = false
        CorrectButton.isEnabled = false
        IncorrectButton.isEnabled = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawImage() {
        //BUGBUG: This should not happen after the last result when the results are generated. However, for some reason, then the last drawn image is missing in the results! this will fix it.
        let img = drawCustomImage(CGSize(width: 500, height: 300))
        resultImages.append(img)

        if curr < imagelist.count {
            let imageView = UIImageView(frame:CGRect(x: 8, y: 250, width: 500, height: 300))
            let image = UIImage(named: imagelist[curr])
            imageView.image = image
            imageView.layer.borderWidth = 2
            self.view.addSubview(imageView)
        } else {
            StartButton.isEnabled = true
            BackButton.isHidden = false
            CorrectButton.isEnabled = false
            IncorrectButton.isEnabled = false
            
            let result = Results()
            result.name = "3D Figure Copy"
            result.startTime = startTime2
            result.endTime = Foundation.Date()
            result.longDescription.add("Tests: \(imagelist)")
            result.longDescription.add("Test Outcomes: \(resultCondition)")
            result.longDescription.add("Test Times: \(resultTime)")
            for shot in resultImages {
                result.screenshot.append(shot)
            }
            
            for (index, element) in resultCondition.enumerated() {
                result.json[imagelist[index]] = ["correct":element, "drawing time (msec)":Int(1000*resultTime[index])]
            }
            
            resultsArray.add(result)
            Status[Test3DFigureCopy] = TestStatus.Done
            resultCondition.removeAll()
            resultImages.removeAll()
            resultTime.removeAll()
        }
    }
    
    @IBAction func StartAction(_ sender: UIButton) {
        curr = 0
        StartButton.isEnabled = false
        BackButton.isHidden = true
        CorrectButton.isEnabled = true
        IncorrectButton.isEnabled = true
        
        if  drawing != nil {
            drawing.removeFromSuperview()
        }
        
        if drawingImageView != nil {
            drawingImageView.removeFromSuperview()
            drawingImageView.image = nil
        }
       

        let drawingFrame = CGRect(x: 516, y: 250, width: 500, height: 300)
        drawing = ThreeDFigureDraw(frame: drawingFrame)
        drawing.layer.borderWidth = 2
        self.view.addSubview(drawing)
        
        startTime = Foundation.Date()
        drawImage()
    }
    
    
    @IBAction func CorrectAction(_ sender: UIButton) {
        resultCondition.append(true)
        resultTime.append(Foundation.Date().timeIntervalSince(startTime))
        startTime = Foundation.Date()
        curr  = curr + 1
        drawImage()
    }
    
    
    @IBAction func IncorrectAction(_ sender: UIButton) {
        resultCondition.append(false)
        resultTime.append(Foundation.Date().timeIntervalSince(startTime))
        startTime = Foundation.Date()
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
