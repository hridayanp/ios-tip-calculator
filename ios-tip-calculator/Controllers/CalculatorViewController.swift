//
//  ViewController.swift
//  Tipsy
//
//  Created by Hridayan Phukan

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipSelected: Float = 0.0
    var finalResult: Float = 0.0
    var split: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ensure no tip button is selected on load
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        // Set up billTextField to use number pad
        billTextField.keyboardType = .decimalPad
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
        // Ensure a valid bill amount is entered
        guard let billText = billTextField.text, !billText.isEmpty, let bill = Float(billText) else {
            print("Invalid or missing bill amount")
            return
        }
        
        // Ensure a valid split number is set
        guard let splitNumberText = splitNumberLabel.text, !splitNumberText.isEmpty, let splitNumber = Float(splitNumberText), splitNumber > 0 else {
            print("Invalid or missing number of people to split the bill")
            return
        }
        
        // Ensure a tip has been selected
        guard tipSelected > 0 || tipSelected == 0 else {
            print("Tip not selected")
            return
        }
        
        // Calculate the total bill with tip
        let totalBillWithTip = bill + (bill * tipSelected)
        
        
        // Calculate the amount per person
        let amountPerPerson = totalBillWithTip / splitNumber
        
        // Print the result in the console for debugging
        print("Total Bill (with Tip): \(totalBillWithTip)")
        print("Amount Per Person: \(amountPerPerson)")
        
        finalResult = totalBillWithTip
        
        split = splitNumberText
        
        // Proceed to the next screen if all conditions are met
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    //This method gets triggered just before the segue starts.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //If the currently triggered segue is the "goToResults" segue.
        if segue.identifier == "goToResult" {
            
            //Get hold of the instance of the destination VC and type cast it to a ResultViewController.
            let destinationVC = segue.destination as! ResultViewController
            
            destinationVC.result = finalResult
            destinationVC.tip = Int(tipSelected * 100)
            destinationVC.split = split
        }
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

