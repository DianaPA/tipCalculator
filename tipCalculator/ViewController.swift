//
//  ViewController.swift
//  tipCalculator
//  
//  Diana


import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var totalBackGroundView: UIView!
    
    var tipPercentages:[Int] = [15, 30, 20]
    
    let SETTINGSKEY = "SETTINGSARRAYKEY"
    let BILLAMOUNTKEY = "BILLAMOUNT"
    let LASTSAVEDKEY = "LASTSAVED"
    let LAUNCHEDBEFOREKEY = "LAUNCHEDBEFORE"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
      
        let launchedBefore = defaults.bool(forKey: LAUNCHEDBEFOREKEY)
        
        if launchedBefore  {
            let retrievedArray = (defaults.object(forKey:SETTINGSKEY) as? [Int])!
            
            if retrievedArray.count == 3 {
                tipPercentages = retrievedArray
            }

            let lastSaveTime = (defaults.object(forKey: LASTSAVEDKEY)) as! Date
            
            let tenMinLater : Date = Date.init(timeInterval: 600, since: lastSaveTime)
            
            if Date.init().compare(tenMinLater) == .orderedSame ||
                Date.init().compare(tenMinLater) == .orderedAscending {
                self.billField.text = defaults.string(forKey: BILLAMOUNTKEY)!
            }


        }
        else {
            defaults.set(true, forKey: LAUNCHEDBEFOREKEY)
            
        }
        
        tipControl.setTitle(String(format: "%d%%", tipPercentages[0]), forSegmentAt: 0)
        tipControl.setTitle(String(format: "%d%%", tipPercentages[1]), forSegmentAt: 1)
        tipControl.setTitle(String(format: "%d%%", tipPercentages[2]), forSegmentAt: 2)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if billField.text != "" && billField.text != "0" {
        
            let defaults = UserDefaults.standard
        
            defaults.set(billField.text, forKey: BILLAMOUNTKEY)
            defaults.set(Date.init(), forKey: LASTSAVEDKEY)
            defaults.synchronize()
        }
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
        self.totalBackGroundView.backgroundColor = UIColor.white
    }
 
    @IBAction func calculateTip(_ sender: AnyObject) {
        let percent = Double(tipPercentages[tipControl.selectedSegmentIndex])/100.0
        
        
        let bill = Double(billField.text!) ?? 0
        let tip = Double(bill * percent)
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        UIView.animate(withDuration: 2.0, delay: 0.0, options:[.transitionCurlDown, .curveEaseInOut], animations: {
            self.totalBackGroundView.backgroundColor = UIColor(red: 0, green: 175/255, blue: 175/255, alpha: 0.75)
            }, completion:nil)
        
    }  
}

