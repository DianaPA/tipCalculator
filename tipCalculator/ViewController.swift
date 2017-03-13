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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
      
        let firstLaunch = defaults.bool(forKey: "FirstLaunch")
        
        // not first launch
        if firstLaunch  {
            let retrievedArray = (defaults.object(forKey:SETTINGSKEY) as? [Int])!
            
            if retrievedArray.count == 3 {
                tipPercentages = retrievedArray
            }
        }
        else {
//            First launch, setting NSUserDefault
            defaults.set(true, forKey: "FirstLaunch")
            
        }
        print("viewWillAppear, tipPercentages = \(tipPercentages)")
        tipControl.setTitle(String(format: "%d%%", tipPercentages[0]), forSegmentAt: 0)
        tipControl.setTitle(String(format: "%d%%", tipPercentages[1]), forSegmentAt: 1)
        tipControl.setTitle(String(format: "%d%%", tipPercentages[2]), forSegmentAt: 2)
        
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

