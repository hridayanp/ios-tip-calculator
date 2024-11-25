//
//  ViewController.swift
//  Tipsy
//
//  Created by Hridayan Phukan

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipSelected: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ensure no tip button is selected on load
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        // Set up billTextField to use number pad
        billTextField.keyboardType = .decimalPad
        billTextField.delegate = self
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        // Reset all buttons to deselected
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        // Toggle the selected button
        sender.isSelected = true
        
        // Set the tip percentage based on the button selected
        switch sender {
        case zeroPctButton:
            tipSelected = 0.0
        case tenPctButton:
            tipSelected = 0.1
        case twentyPctButton:
            tipSelected = 0.2
        default:
            tipSelected = 0.0
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        // update the label with the current stepper value
        splitNumberLabel.text = Int(sender.value).description
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        // Get the bill amount entered by the user
        guard let billText = billTextField.text, let bill = Float(billText) else {
            print("Invalid bill amount")
            return
        }
        
        // Get the number of people to split the bill
        guard let splitNumberText = splitNumberLabel.text, let splitNumber = Float(splitNumberText) else {
            print("Invalid number of people to split the bill")
            return
        }
        
        // Calculate the total bill with tip
        let totalBillWithTip = bill + (bill * (tipSelected))
        
        // Calculate the amount per person
        let amountPerPerson = totalBillWithTip / splitNumber
        
        // Print the result in the console
        print("Total Bill (with Tip): \(totalBillWithTip)")
        print("Amount Per Person: \(amountPerPerson)")
    }
    
    // UITextFieldDelegate method to restrict input to numbers and a single decimal point
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Allow backspace
        if string.isEmpty {
            return true
        }
        
        // Allow only numbers and one decimal point
        if let currentText = textField.text, (currentText.contains(".") && string == ".") {
            return false
        }
        
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
}

