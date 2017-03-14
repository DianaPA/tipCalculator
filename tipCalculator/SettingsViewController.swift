//
//  SettingsViewController.swift
//  tipCalculator
//
//  Diana
//  

import UIKit

class SettingsViewController: UITableViewController, UITextFieldDelegate {

    // differiate textFields
    //order of storage: minValue, maxValue, default
    enum TextFieldTag : Int {
        
        case MinTag = 0
        case MaxTag
        case DefaultTag
    }
    
    @IBOutlet weak var minimumPercentageField: UITextField!
    @IBOutlet weak var maximumPercentageField: UITextField!
    @IBOutlet weak var defaultPercentageField: UITextField!
    
   
    var currentSettings: [Int] = [15, 30, 20]
    var retrievedArray: [Int] = [15, 30, 20]
    
    let defaultSettings = [15, 30, 20]
    let SETTINGSKEY = "SETTINGSARRAYKEY"
    let LAUNCHEDBEFOREKEY = "LAUNCHEDBEFORE"
    
    override func viewDidLoad() {
        super.viewDidLoad()
     }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  
        let defaults = UserDefaults.standard
        let launchedBefore = defaults.bool(forKey: LAUNCHEDBEFOREKEY)
        
        if launchedBefore  {
             retrievedArray = (defaults.object(forKey:SETTINGSKEY) as? [Int])!
            
            if retrievedArray.count == 3 {
                currentSettings = retrievedArray
            }
        }
        else {
            defaults.set(true, forKey: LAUNCHEDBEFOREKEY)
            
        }
        
        defaultPercentageField.text = String(format: "%d%%", currentSettings[defaultPercentageField.tag])
        minimumPercentageField.text = String(format: "%d%%", currentSettings[minimumPercentageField.tag])
        maximumPercentageField.text = String(format: "%d%%", currentSettings[maximumPercentageField.tag])
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let defaults = UserDefaults.standard
        
        if currentSettings[defaultPercentageField.tag] >= currentSettings[minimumPercentageField.tag] && currentSettings[defaultPercentageField.tag] <= currentSettings[maximumPercentageField.tag] {
            
//            store new settings, currentSettings
            
            defaults.set(currentSettings, forKey:SETTINGSKEY)
            
        } else {
//       store previous settings
            defaults.set(retrievedArray, forKey:SETTINGSKEY)
        }
        defaults.synchronize()
    }
 
 //     UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
 
//   user enters return key
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
  
        var update:Int
        if (textField.text?.contains("%"))! {
            update = Int((textField.text?.replacingOccurrences(of: "%", with: ""))!)!
        } else {
        
            update = Int(textField.text!)!
        }
    
        currentSettings[textField.tag] = update
        textField.text = String(format: "%d%%", update)
 
        return true;
    }
}
