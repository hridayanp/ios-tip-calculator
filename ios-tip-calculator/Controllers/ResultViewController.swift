//
//  ResultViewController.swift
//  ios-tip-calculator
//
//  Created by Hridayan Phukan on 25/11/24.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var splitLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    
    var result: Float = 0.0
    var tip = 10
    var split = "2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalLabel.text = String(result)
        splitLabel.text = "Split between \(split) people, with \(tip)% tip."
        
    }
    
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
