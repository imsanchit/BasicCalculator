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
    
    var isResultPending: Bool = false
    var desc = ""
    
    @IBOutlet weak var operationsDisplay: UITextView!
    
    @IBAction func performOperations(_ sender: UIButton) {
    
        print(sender.currentTitle!)
        
        switch sender.currentTitle! {
            case "+", "-", "*", "/":
                guard let operand = extractOperandFrom(text: displayScreen.text) else { return }
                basicCalculatorBrain.performOperation(operand, sender.currentTitle!)
                desc = desc + sender.currentTitle!
                operationsDisplay.text = desc
                displayScreen.text = ""
                isResultPending = true
                isUserTyping = false
                firstDecimal = true
            case "AC":
                isUserTyping = false
                firstDecimal = true
                displayScreen.text = ""
                operationsDisplay.text = ""
                basicCalculatorBrain.result = 0
                desc = ""
        case "√":
            guard let operand = extractOperandFrom(text: displayScreen.text) else { return }
            basicCalculatorBrain.performOperation(operand, sender.currentTitle!)
            displayScreen.text = String(sqrt(Double(operand)!))
            desc = "√("+desc+")"
            operationsDisplay.text = desc
            isUserTyping = false
            firstDecimal = false
            
            isResultPending = false
            basicCalculatorBrain.result = 0
        case "^2":
            guard let operand = extractOperandFrom(text: displayScreen.text) else { return }
            basicCalculatorBrain.performOperation(operand, sender.currentTitle!)
            displayScreen.text = String(pow(Double(operand)!,2))
            desc = "("+desc+")^2"
            operationsDisplay.text = desc
            isUserTyping = false
            firstDecimal = false
            
            isResultPending = false
            basicCalculatorBrain.result = 0
        case "cos":
            guard let operand = extractOperandFrom(text: displayScreen.text) else { return }
            basicCalculatorBrain.performOperation(operand, sender.currentTitle!)
            displayScreen.text = String(cos(Double(operand)!))
            desc = "cos("+desc+")"
            operationsDisplay.text = desc
            isUserTyping = false
            firstDecimal = false
            
            isResultPending = false
            basicCalculatorBrain.result = 0
        case "<-":
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
          case "=":
                guard let operand = extractOperandFrom(text: displayScreen.text) else { return }
                print(isResultPending)
                if(!isResultPending){
                    displayScreen.text = operand
                }
                else{
                    basicCalculatorBrain.performOperation(operand, sender.currentTitle!)
                    if(basicCalculatorBrain.result != nil) {
                        displayScreen.text = String(basicCalculatorBrain.result!)
                        operationsDisplay.text = desc + "+"
                        firstDecimal=false
                    }
                }
                isResultPending = false
                isUserTyping = false
                basicCalculatorBrain.result = 0
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
        if(sender.currentTitle! == "~M"){
            if let text = displayScreen.text {
                basicCalculatorBrain.storeMemory(value: Double(text)!)
            }
        }
        if(!isResultPending){
            isResultPending = true
            desc = ""
        }
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
            if(sender.currentTitle! == "M"){
                    displayScreen.text = String(basicCalculatorBrain.MemoryValue())
                firstDecimal = false
            }
            else if(sender.currentTitle! == "~M"){
            }
            else {
                displayScreen.text = sender.currentTitle!
            }
            isUserTyping = true
        }
        else {
            if(sender.currentTitle! == "M"){
                displayScreen.text = String(basicCalculatorBrain.MemoryValue())
                firstDecimal = false
            }
            else if(sender.currentTitle! == "~M"){
            }
            else {
                displayScreen.text = displayScreen.text! + sender.currentTitle!
            }
        }
        
        if(sender.currentTitle! == "π") {
            desc = desc + String(Double.pi)
        }
        else if(sender.currentTitle! == "M") {
            desc = desc + String(basicCalculatorBrain.MemoryValue())
            firstDecimal = false
        }
        else if(sender.currentTitle! == "~M") {
            
        }
        else {
            desc = desc + sender.currentTitle!
        }
        
    }
}
