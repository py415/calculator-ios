//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var displayLabel: UILabel!
    
    // MARK: - Properties
    private var calculator = CalculatorLogic()
    private var isFinishedTypingNumber: Bool = true
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to a Double.")
            }
            
            return number
        }
        
        set {
            let isInt = floor(newValue) == newValue
            
            if isInt {
                // Result is an integer
                displayLabel.text = String(format: "%.0f", newValue)
            } else {
                displayLabel.text = String(format: "%.2f", newValue)
            }
        }
    }

    // MARK: - IBAction Section
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }

    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        guard let currentDisplayString = displayLabel.text else { fatalError("Error. Unknown display value.") }
        if currentDisplayString.contains(".") { return }
        
        //What should happen when a number is entered into the keypad
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                if numValue == "." {
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return
                    }
                }
                
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    
    }

}
