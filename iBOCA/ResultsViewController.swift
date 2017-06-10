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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return resultsArray.numResults()+2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0 {
            
        } else if section <= resultsArray.numResults() {
            let res:Results = resultsArray.get(section-1)
            if(res.collapsed == false)
            {
                let res:Results = resultsArray.get(section-1)
                return res.numRows()
            }
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ABC"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
        } else if indexPath.section <= resultsArray.numResults() {
            let res:Results = resultsArray.get(indexPath.section-1)
            if(res.collapsed == false){
                return CGFloat(res.heightForRow(indexPath.row))
            }
        }
        
        return 2;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
            return headerView
        } else if section <= resultsArray.numResults() {
            let res:Results = resultsArray.get(section-1)
            
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
            headerView.backgroundColor = UIColor.gray
            headerView.tag = section
            
            let headerString = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.size.width-10, height: 30)) as UILabel
            headerString.text = String(section) + ".  " + res.header()
            headerView.addSubview(headerString)
            
            let headerTapped = UITapGestureRecognizer (target: self, action:#selector(ResultsViewController.sectionHeaderTapped(_:)))
            headerView.addGestureRecognizer(headerTapped)
            
            return headerView
        } else {
            let scaleViewFrame = CGRect(x: 0.0, y: 85.0, width: view.bounds.width, height: 50)
            let scaleView = ScaleView(frame: scaleViewFrame)
            return scaleView
        }
    }
    
    func sectionHeaderTapped(_ recognizer: UITapGestureRecognizer) {
        let loc = recognizer.location(in: view)
        let subview = view?.hitTest(loc, with: nil)
        let tag = subview!.tag
        let indexPath : NSIndexPath = NSIndexPath(row: 0, section:tag)
        let res:Results = resultsArray.get(indexPath.section-1)
        if (indexPath.row == 0) {
            res.collapsed = !res.collapsed
            
            //reload specific section animated
            let range = NSMakeRange(indexPath.section, 1)
            let sectionToReload = IndexSet(integersIn:range.toRange()!)
            self.tableView.reloadSections(sectionToReload as IndexSet, with:UITableViewRowAnimation.fade)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        let CellIdentifier = "Cell"
        var cell :UITableViewCell
        cell = self.tableView.dequeueReusableCell(withIdentifier: CellIdentifier)! as UITableViewCell
        
        if indexPath.section == 0 {
            
        } else if indexPath.section <= resultsArray.numResults() {
            let res:Results = resultsArray.get(indexPath.section - 1)
            
            if (res.collapsed) {
                cell.textLabel?.text = "click to enlarge"
            }
            else{
                res.setRow(indexPath.row, cell:cell)
            }
        }
        
        return cell
    }

}
