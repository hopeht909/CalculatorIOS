//
//  ViewController.swift
//  CalculatorIOS
//
//  Created by admin on 09/12/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calculatorWorkings: UILabel!
    @IBOutlet weak var calculatorResults: UILabel!
    
    var workings:String = ""
    
    func clearAll(){
        workings = ""
        calculatorWorkings.text = ""
        calculatorResults.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
        
    }
    func addToWorkings(value: String){
            workings = workings + value
            calculatorWorkings.text = workings
        }
    
    @IBAction func numbersTap(_ sender: UIButton) {
        addToWorkings(value: "\(sender.tag)")
    }
    
    @IBAction func divideTap(_ sender: UIButton) {
        addToWorkings(value: "/")
    }
    
    @IBAction func percentTap(_ sender: UIButton) {
        addToWorkings(value: "%")
    }
    
    @IBAction func timesTap(_ sender: UIButton) {
        addToWorkings(value: "*")
    }
    
    @IBAction func minusTap(_ sender: UIButton) {
        addToWorkings(value: "-")
    }
    
    @IBAction func plusTap(_ sender: UIButton) {
        addToWorkings(value: "+")
    }
    
    @IBAction func decimalTap(_ sender: UIButton) {
        addToWorkings(value: ".")
    }
    
    @IBAction func allClearTap(_ sender: UIButton) {
        clearAll()
    }
    
    @IBAction func equalsTap(_ sender: UIButton) {
        if(validInput())
                {
                    let checkedWorkingsForPercent = workings.replacingOccurrences(of: "%", with: "*0.01")
                    let expression = NSExpression(format: checkedWorkingsForPercent)
                    let result = expression.expressionValue(with: nil, context: nil) as! Double
                    let resultString = formatResult(result: result)
                    calculatorResults.text = resultString
                }
                else
                {
                    let alert = UIAlertController(
                        title: "Invalid Input",
                        message: "Calculator unable to do math based on input",
                        preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
    }
    func validInput() ->Bool
        {
            var count = 0
            var funcCharIndexes = [Int]()
            
            for char in workings
            {
                if(specialCharacter(char: char))
                {
                    funcCharIndexes.append(count)
                }
                count += 1
            }
            
            var previous: Int = -1
            
            for index in funcCharIndexes
            {
                if(index == 0)
                {
                    return false
                }
                
                if(index == workings.count - 1)
                {
                    return false
                }
                
                if (previous != -1)
                {
                    if(index - previous == 1)
                    {
                        return false
                    }
                }
                previous = index
            }
            
            return true
        }
    func specialCharacter (char: Character) -> Bool
        {
            if(char == "*")
            {
                return true
            }
            if(char == "/")
            {
                return true
            }
            if(char == "+")
            {
                return true
            }
            return false
        }
    
    func formatResult(result: Double) -> String
    {
        if(result.truncatingRemainder(dividingBy: 1) == 0)
        {
            return String(format: "%.0f", result)
        }
        else
        {
            return String(format: "%.2f", result)
        }
    }
    
}

