//
//  ViewController.swift
//  BasicCalculator
//
//  Created by Sanchit Mittal on 26/07/17.
//  Copyright © 2017 Sanchit Mittal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isUserTyping: Bool = false
    var basicCalculatorBrain = BasicCalculatorBrain()
    var firstDecimal: Bool = true
    @IBOutlet weak var displayScreen: UITextView!
    
    @IBAction func performOperations(_ sender: UIButton) {
        
        switch sender.currentTitle! {
            case "+", "-", "*", "/":
                guard let operand = extractOperandFrom(text: displayScreen.text) else { return }
                basicCalculatorBrain.performOperation(operand, sender.currentTitle!)
                displayScreen.text = displayScreen.text! + sender.currentTitle!
                isUserTyping = false
                firstDecimal = true
            case "AC":
                isUserTyping = false
                firstDecimal = true
                displayScreen.text = ""
            
            case "√":
//                guard let operand = extractOperandFrom(text: displayScreen.text) else { return }
//                basicCalculatorBrain.performOperation(operand, sender.currentTitle!)
                let operand = displayScreen.text!
                basicCalculatorBrain.performOperation(operand, sender.currentTitle!)
                displayScreen.text = String(sqrt(Double(operand)!))
                
                isUserTyping = false
                firstDecimal = false
/*        case "<-":
            if var text = displayScreen.text {
                if(text != "") {
                    let index = text.index(before: text.endIndex)
                    if(text[index]==".") {
                        firstDecimal = true
                    }
                    text = String(text.characters.dropLast())
                    displayScreen.text = text
                    if(text.characters.count==0) {
                        isUserTyping = false
                    }
                }
            }
  */        case "=":
                guard let operand = extractOperandFrom(text: displayScreen.text) else { return }
                basicCalculatorBrain.performOperation(operand, sender.currentTitle!)
            
                if(basicCalculatorBrain.result != nil) {
                    displayScreen.text = String(basicCalculatorBrain.result!)
                    firstDecimal=false
                }
            default:
                break
        }
    }

    func extractOperandFrom(text: String?) -> String? {
        guard let text = text else { return nil }
        
        let endChar = text.characters.last!
        
        guard endChar != "+"  &&  endChar != "-"  &&  endChar != "/"  &&  endChar != "*"  &&  endChar != "=" else {
            return nil
        }
        
        return text
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        if(sender.currentTitle! == "π") {
            displayScreen.text = String(Double.pi)
        }
        else if(sender.currentTitle! == ".") {
            if(firstDecimal) {
                if(!isUserTyping) {
                    displayScreen.text = sender.currentTitle!
                    isUserTyping = true
                    firstDecimal = false
                    }
                else {
                displayScreen.text = displayScreen.text! + sender.currentTitle!
                firstDecimal = false
                }
            }
        }
        else if(!isUserTyping) {
            displayScreen.text = sender.currentTitle!
            isUserTyping = true
        }
        else {
                displayScreen.text = displayScreen.text! + sender.currentTitle!
        }
    }
}
