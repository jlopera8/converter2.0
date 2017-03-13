//  ViewController.swift
//  converter2.0
//
//  Created by Stiven Lopera Jaramillo on 3/11/17.
//  Copyright © 2017 Stiven Lopera Jaramillo. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var distanceTextField: UITextField!
    
    @IBOutlet var inUnitSegmentedControl: UISegmentedControl!
    
    @IBOutlet var outUnitSegmentedControl: UISegmentedControl!
    
    @IBOutlet var resultLabel: UILabel!
    
    let mileToKmUnit : Double = 1.609
    
    let mileToYardUnit : Double = 1760
    
    let kmToYardUnit : Double = 1093.61
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func convertButton(_ sender: UIButton) {
        
        let inSelectedIndex = inUnitSegmentedControl.selectedSegmentIndex
        let outSelectedIndex = outUnitSegmentedControl.selectedSegmentIndex
        var distanceTextFieldValue : Double
        var convertedValue : Double
        
        if validateString(string: distanceTextField) {
            
            distanceTextFieldValue = Double(distanceTextField.text!)!
            convertedValue = convert(value: distanceTextFieldValue,
                                     inUnit: inSelectedIndex,
                                     outUnit: outSelectedIndex)
            reloadView(distanceTextFieldValue: distanceTextFieldValue,
                       convertedValue: convertedValue,
                       inUnit: inSelectedIndex,
                       outUnit: outSelectedIndex)

        } else {
            
            alert(message: "Digit a valid number", title: "Converter error")
        }
        
    }
    
    // inUnit: 0 -> miles, 1 -> kilometers, 2 -> yards
    // outUnit: 0 -> miles, 1 -> kilometers, 2 -> yards
    func convert (value : Double,
                  inUnit : Int,
                  outUnit : Int) -> Double {
        
        var result : Double = 0.0
        
        if inUnit == 0  && outUnit == 1 { // Miles to kilometers
            
            result = value * mileToKmUnit
        
        }else if inUnit == 1 && outUnit == 0 { // kilometers to miles
            
            result = value / mileToKmUnit
        
        }else if inUnit == 0 && outUnit == 2 { // Miles to yards
            
            result = value  * mileToYardUnit
        
        }else if inUnit == 1 && outUnit == 2 { // Kilometers to yards
            
            result = value * kmToYardUnit
            
        }else if inUnit == 2 && outUnit == 0 { // Yards to miles
        
            result = value / mileToYardUnit
            
        }else if inUnit == 2 && outUnit == 1 { // Yards to kilometers
            
            result = value / kmToYardUnit
            
        }else { // Equal units - no convertion
            
            result = value
        }
        
        return result
    }
    
    func validateString (string: UITextField!) -> Bool{
        if (Double(string.text!) != nil) {
            return true
        } else {
            return false
        }
    }
    
    func reloadView (distanceTextFieldValue : Double,
                     convertedValue : Double,
                     inUnit : Int,
                     outUnit : Int) {
        
        let initValue = String(format: "%.4f", distanceTextFieldValue)
        let endValue = String(format: "%.4f", convertedValue)
        
        if inUnit == 0  && outUnit == 1 { // Miles to kilometers
           
            resultLabel.text = "\(initValue) miles = \(endValue) km"
            
        }else if inUnit == 1 && outUnit == 0 { // kilometers to miles
            
            resultLabel.text = "\(initValue) km = \(endValue) miles"

        }else if inUnit == 0 && outUnit == 2 { // Miles to yards
            
            resultLabel.text = "\(initValue) miles = \(endValue) yards"
            
        }else if inUnit == 1 && outUnit == 2 { // Kilometers to yards
            
            resultLabel.text = "\(initValue) km = \(endValue) yards"
            
        }else if inUnit == 2 && outUnit == 0 { // Yards to miles
            
            resultLabel.text = "\(initValue) yards = \(endValue) miles"
            
        }else if inUnit == 2 && outUnit == 1 { // Yards to kilometers
            
            resultLabel.text = "\(initValue) yards = \(endValue) km"

        }else { // Equal units - no convertion

            alert(message: "No convertion", title: "Convertion process")
            
        }

    }
    
    func alert (message : String, title : String){
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "OK",
                                    style: .default,
                                    handler: nil)
        
        alertController.addAction(okAlert)
        
        present(alertController, animated: true, completion: nil)
    }

}
