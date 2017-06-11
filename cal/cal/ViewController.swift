//
//  ViewController.swift
//  cal
//
//  Created by pokemon on 5/26/17.
//  Copyright © 2017 pokemon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userisinthemiddleoftyping : Bool = false
    
    @IBAction func appendDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        if userisinthemiddleoftyping{
            let displayvalue = display!.text!
            display!.text = displayvalue + digit
        }
        else{
            display!.text = digit
            userisinthemiddleoftyping = true
        }
    }
    
    
    private var brain = CalculatorBrain()
    var displayValue : Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    @IBAction func operand(_ sender: UIButton) {
        if userisinthemiddleoftyping{
            brain.setoperand(displayValue)
            userisinthemiddleoftyping = false
        }
        if let mathsymbol = sender.currentTitle{
            brain.performoperation(mathsymbol)
        }
        if let result = brain.result{
            displayValue = result
        }
           }
    
    
    
    
    
    
    
}
