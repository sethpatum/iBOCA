//
//  ResultsViewController.swift
//  Integrated test v1
//
//  Created by saman on 8/12/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let scaleViewFrame = CGRect(x: 0.0, y: 85.0, width: view.bounds.width, height: 50)
        let scaleView = ScaleView(frame: scaleViewFrame)
        view.addSubview(scaleView)
        scaleView.reset()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return resultsArray.numResults()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let res:Results = resultsArray.get(index: section)
        if(res.collapsed == false)
        {
            let res:Results = resultsArray.get(index: section)
            return res.numRows()
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ABC"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
         let res:Results = resultsArray.get(index: indexPath.section)
        if(res.collapsed == false){
            return CGFloat(res.heightForRow(i: indexPath.row))
        }
        
        return 2;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let res:Results = resultsArray.get(index: section)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        headerView.backgroundColor = UIColor.gray
        headerView.tag = section
        
        let headerString = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.size.width-10, height: 30)) as UILabel
        headerString.text = String(section+1) + ".  " + res.header()
        headerView .addSubview(headerString)
        
        let headerTapped = UITapGestureRecognizer (target: self, action:"sectionHeaderTapped:")
        headerView .addGestureRecognizer(headerTapped)
        
        return headerView
    }
    
    func sectionHeaderTapped(recognizer: UITapGestureRecognizer) {
        let indexPath : NSIndexPath = NSIndexPath(row: 0, section: 0)
        //let indexPath : NSIndexPath = NSIndexPath(row: 0, section:(recognizer.view?.as, Int!),!)
        
        let res:Results = resultsArray.get(index: indexPath.section)
        if (indexPath.row == 0) {
            
            res.collapsed = !res.collapsed
           
            //reload specific section animated
            let range = NSMakeRange(indexPath.section, 1)
            let sectionToReload = NSIndexSet(indexesIn: range)
            self.tableView .reloadSections(sectionToReload as IndexSet, with:UITableViewRowAnimation.fade)
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let res:Results = resultsArray.get(index: indexPath.section)
        
        let CellIdentifier = "Cell"
        var cell :UITableViewCell
        cell = self.tableView.dequeueReusableCell(withIdentifier: CellIdentifier)! as UITableViewCell
        
        if (res.collapsed) {
            cell.textLabel?.text = "click to enlarge"
        }
        else{
            res.setRow(i: indexPath.row, cell:cell)
        }
        
        return cell
    }
    
    

   

}
