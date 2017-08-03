//
//  GeriatricDepressionScale.swift
//  iBOCA
//
//  Created by saman on 6/28/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

// List of questions
let questions = ["Are you basically satisfied with your life?",
                 "Have you dropped many of your activities and interests?",
                 "Do you feel that your life is empty?",
                 "Do you often get bored?",
                 "Are you hopeful about the future?",
                 "Are you bothered by thoughts you can t get out of your head?",
                 "Are you in good spirits most of the time?",
                 "Are you afraid that something bad is going to happen to you?",
                 "Do you feel happy most of the time?",
                 "Do you often feel helpless?",
                 "Do you often get restless and fidgety?",
                 "Do you prefer to stay at home, rather than going out and doing new things?",
                 "Do you frequently worry about the future?",
                 "Do you feel you have more problems with memory than most?",
                 "Do you think it is wonderful to be alive now?",
                 "Do you often feel downhearted and blue?",
                 "Do you feel pretty worthless the way you are now?",
                 "Do you worry a lot about the past?",
                 "Do you find life very exciting?",
                 "Is it hard for you to get started on new projects?",
                 "Do you feel full of energy?",
                 "Do you feel that your situation is hopeless?",
                 "Do you think that most people are better off than you are?",
                 "Do you frequently get upset over little things?",
                 "Do you frequently feel like crying?",
                 "Do you have trouble concentrating?",
                 "Do you enjoy getting up in the morning?",
                 "Do you prefer to avoid social gatherings?",
                 "Is it easy for you to make decisions?",
                 "Is your mind as clear as it used to be?"]

// True if yes is to be scored and false if No is to be scored
let answers = [false, true,  true,  true,  false,
               true,  false, true,  false, true,
               true,  true,  true,  true,  false,
               true,  true,  true,  false, true,
               false, true,  true,  true,  true,
               true,  false, true,  false, false]




class GeriatricDepressionScale:  ViewController {
    var justView: UIView!
    var scrollView: UIScrollView!
    
    var yesButtonList : [UIButton] = []
    var noButtonList : [UIButton] = []
    var buttonState : [Int] = [] // -1 mean no answer selected, 0 means No is slected, 1 means YES is selected

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //declare pickerviews
        
        yesButtonList  = []
        noButtonList  = []
        buttonState = []
      
        let h = 100*questions.count + 100
        
        justView = UIView(frame: CGRect(x:0, y:0, width:1024, height: h))
        scrollView = UIScrollView(frame: CGRect(x:0, y:100, width:view.bounds.width, height: view.bounds.height-100))
        scrollView.backgroundColor = UIColor.white
        scrollView.contentSize = justView.bounds.size
        scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        
        scrollView.addSubview(justView)
        view.addSubview(scrollView)
        
        for (i, val) in questions.enumerated() {
            let label = UILabel(frame: CGRect(x: 20, y: 100*i + 50, width: 750, height: 24))
            label.font = label.font.withSize(20)
            label.text = String(format:"%2d) ", i+1) + val
            justView.addSubview(label)
            
            let ybtn = UIButton(type: .custom) as UIButton
            let nbtn = UIButton(type: .custom) as UIButton
        
            ybtn.backgroundColor = .gray
            nbtn.backgroundColor = .gray
            
            ybtn.frame = CGRect(x: 770, y: 100*i + 40, width: 80, height: 40)
            nbtn.frame = CGRect(x: 900, y: 100*i + 40, width: 80, height: 40)
            
            ybtn.setTitle("Yes", for: .normal)
            nbtn.setTitle("No", for: .normal)
        
            ybtn.addTarget(self, action: #selector(GeriatricDepressionScale.clickYes), for: .touchUpInside)
            nbtn.addTarget(self, action: #selector(GeriatricDepressionScale.clickNo), for: .touchUpInside)
            
            ybtn.isEnabled = true
            nbtn.isEnabled = true
            
            justView.addSubview(ybtn)
            justView.addSubview(nbtn)
        
            yesButtonList.append(ybtn)
            noButtonList.append(nbtn)
            buttonState.append(-1)
        }
        
        startTime = Foundation.Date()
    }
    
    func findButton(button:UIButton!, list:[UIButton]) -> Int {
        for (i, b) in list.enumerated() {
            if b == button {
                return i
            }
        }
        return -1
    }
    
    func clickYes(b: UIButton!) {
        let i = findButton(button: b, list: yesButtonList)
        b.backgroundColor = .blue
        noButtonList[i].backgroundColor = .gray
        buttonState[i] = 1
       
    }
    
    func clickNo(b:UIButton!) {
        let i = findButton(button: b, list: noButtonList)
        b.backgroundColor = .blue
        yesButtonList[i].backgroundColor = .gray
        buttonState[i] = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var val = 0
        var noans = 0
        for (i, ans) in answers.enumerated() {
            if buttonState[i] == 1 && ans {
                val += 1
            }
            if buttonState[i] == 0 && !ans {
                val += 1
            }
            if buttonState[i] == -1 {
                noans += 1
            }
        }
        
        let result = Results()
        result.name = "GDT Results"
        result.startTime = startTime
        result.endTime = Foundation.Date()
        result.json["GDT Score"] = val
        result.json["Unanswered"] = noans
        
        var rest2 : [String:Any] = [:]
        for (i, q) in questions.enumerated() {
            rest2[String(i)] = ["Question":q, "yes?":answers[i], "got":buttonState[i]]
        }
        result.json["Results"] = rest2
        
        result.shortDescription = "GDT=\(val) with \(noans) unanswered"
        
        resultsArray.add(result)
        Status[TestGDTResults] = TestStatus.Done
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
