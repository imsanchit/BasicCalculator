//
//  ViewController.swift
//  BasicCalculator
//
//  Created by Sanchit Mittal on 26/07/17.
//  Copyright © 2017 Sanchit Mittal. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController , UISplitViewControllerDelegate {
    
    
    fileprivate var collapseDetailViewController = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return collapseDetailViewController
    }

    
    @IBAction func evaluate(_ sender: UIButton) {
        print(equationOperator)
        print(equationOperand)
        var firstOperation = true
        var ans: Double = 0.0
        var indexOperand = 0
        for index in 0..<equationOperator.count {
            if(equationOperator[index] == "+"){
                if(firstOperation){
                    firstOperation = false
                    ans = equationOperand[0]+equationOperand[1]
                    indexOperand=2
                }
                else{
                    ans = ans + equationOperand[indexOperand]
                    indexOperand = indexOperand + 1
                }
            }
            else if(equationOperator[index] == "-"){
                if(firstOperation){
                    firstOperation = false
                    ans = equationOperand[0]-equationOperand[1]
                    indexOperand=2
                }
                else{
                    ans = ans - equationOperand[indexOperand]
                    indexOperand = indexOperand + 1
                }
            }
            else if(equationOperator[index] == "*"){
                if(firstOperation){
                    firstOperation = false
                    ans = equationOperand[0]*equationOperand[1]
                    indexOperand=2
                }
                else{
                    ans = ans * equationOperand[indexOperand]
                    indexOperand = indexOperand + 1
                }
            }
            else if(equationOperator[index] == "/"){
                if(firstOperation){
                    firstOperation = false
                    ans = equationOperand[0]/equationOperand[1]
                    indexOperand=2
                }
                else{
                    ans = ans / equationOperand[indexOperand]
                    indexOperand = indexOperand + 1
                }
            }
            else if(equationOperator[index] == "sin"){
                if(firstOperation){
                    firstOperation = false
                    ans = sin(equationOperand[0])
                    indexOperand=2
                }
                else{
                    ans = sin(ans)
                    indexOperand = indexOperand + 1
                }
            }
            else if(equationOperator[index] == "^2"){
                if(firstOperation){
                    firstOperation = false
                    ans = pow((equationOperand[0]),2)
                    indexOperand=2
                }
                else{
                    ans = pow((ans),2)
                    indexOperand = indexOperand + 1
                }
            }
            else if(equationOperator[index] == "√"){
                if(firstOperation){
                    firstOperation = false
                    ans = sqrt(equationOperand[0])
                    indexOperand=2
                }
                else{
                    ans = sqrt(ans)
                    indexOperand = indexOperand + 1

                }
            }
        }
        print("ans \(ans)")
        operationsDisplay.text = ""
        displayScreen.text = String(ans)
    }
    
    
    @IBAction func setOperand(_ sender: UIButton) {
        value = Double(displayScreen.text!)!
        
    }
    var isUserTyping: Bool = false
    var basicCalculatorBrain = BasicCalculatorBrain()
    var firstDecimal: Bool = true
    @IBOutlet weak var displayScreen: UITextView!
    
    var equationOperand = [Double]()
    var equationOperator = [String]()
    
    var isResultPending: Bool = false
    var desc = ""
    var isEquation = false
    var value: Double = 0.0
    
    @IBOutlet weak var operationsDisplay: UITextView!
    
    @IBAction func equationStarts(_ sender: UIButton) {
        if(isEquation) {
            isEquation = false
            if (displayScreen.text) != nil {
                guard let operand = extractOperandFrom(text: displayScreen.text) else { return }
                if(operand == "x") {
                    equationOperand.append(value)
                }
                else {
                    equationOperand.append(Double(operand)!)
                }
            }
            isUserTyping = false
            basicCalculatorBrain.result = 0

        }
        else {
            isEquation = true
            isUserTyping = false
            firstDecimal = true
            displayScreen.text = ""
            operationsDisplay.text = ""
            basicCalculatorBrain.result = 0
            desc = ""
        }
    }
    @IBAction func performOperations(_ sender: UIButton) {
        
        print(sender.currentTitle!)
        
        switch sender.currentTitle! {
        case "+", "-", "*", "/":
            guard let operand = extractOperandFrom(text: displayScreen.text) else { return }
            if(isEquation){
                if(operand == "x") {
                    equationOperand.append(value)
                }
                else {
                    equationOperand.append(Double(operand)!)
                }
                equationOperator.append(sender.currentTitle!)
            }
            else {
                basicCalculatorBrain.performOperation(operand, sender.currentTitle!)
            }
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
            equationOperand.removeAll()
            equationOperator.removeAll()
            isEquation = !isEquation
        case "√":
            guard let operand = extractOperandFrom(text: displayScreen.text) else { return }
            if(isEquation){
                if(operand == "x") {
                    equationOperand.append(value)
                }
                else {
                    equationOperand.append(Double(operand)!)
                }
                equationOperator.append(sender.currentTitle!)
            }
            else{
                basicCalculatorBrain.performOperation(operand, sender.currentTitle!)
            displayScreen.text = String(sqrt(Double(operand)!))
            }
            desc = "√("+desc+")"
            operationsDisplay.text = desc
            isUserTyping = false
            firstDecimal = false
            
            isResultPending = false
            basicCalculatorBrain.result = 0
            
        case "^2":
            guard let operand = extractOperandFrom(text: displayScreen.text) else { return }
            if(isEquation){
                if(operand == "x") {
                    equationOperand.append(value)
                }
                else {
                    equationOperand.append(Double(operand)!)
                }
                equationOperator.append(sender.currentTitle!)
            }
            else{
                basicCalculatorBrain.performOperation(operand, sender.currentTitle!)
                displayScreen.text = String(pow(Double(operand)!,2))
            }
            desc = "("+desc+")^2"
            operationsDisplay.text = desc
            isUserTyping = false
            firstDecimal = false
            
            isResultPending = false
            basicCalculatorBrain.result = 0
        case "sin":
            guard let operand = extractOperandFrom(text: displayScreen.text) else { return }
            if(isEquation){
                if(operand == "x") {
                    equationOperand.append(value)
                }
                else {
                    equationOperand.append(Double(operand)!)
                }
                equationOperator.append(sender.currentTitle!)
            }
            else{
                basicCalculatorBrain.performOperation(operand, sender.currentTitle!)
                displayScreen.text = String(sin(Double(operand)!))
            }
            desc = "sin("+desc+")"
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
                    operationsDisplay.text = desc
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
        //if(!isEquation){
          //  if(!isResultPending){
            //    isResultPending = true
             //  desc = ""
            //}
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
            
            if(sender.currentTitle! == "π") {
                desc = desc + String(Double.pi)
            }
            else {
                desc = desc + sender.currentTitle!
            }
        //}
    }
//    ["*", "+"]  x*5+6
//    [0.0, 3.0, 6.0]
//    ["+"]
//    [0.0, 3.0]

//    ["sin"] sin(x)
//    [0.0]
//    ["+", "sin"] sin(x+3)
//    [0.0, 3.0]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        collapseDetailViewController = false
        var destinationViewContoller = segue.destination
        if let navigationController = destinationViewContoller as? UINavigationController{
            destinationViewContoller = navigationController.visibleViewController ?? destinationViewContoller
        }
        destinationViewContoller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        destinationViewContoller.navigationItem.leftItemsSupplementBackButton = true
        
        
        if let graphViewController = destinationViewContoller as? GraphViewController {
            print(equationOperator)
            print(equationOperand)
            if(equationOperand.count > 0 && equationOperator.count > 0) {
                if equationOperator[0] == "+"  ||  equationOperator[0] == "-" {
                    if equationOperand.count > 1 {
                        if equationOperator.count > 1 {
                            if equationOperator[1] == "sin" {
                                if(equationOperand[0]==0){
                                    graphViewController.drawSine(1,CGFloat(equationOperand[1]))
                                }
                                else {
                                    graphViewController.drawSine(CGFloat(equationOperand[0]),CGFloat(equationOperand[1]))
                                }
                            }
                        }
                        else {
                            graphViewController.drawEquation(1,CGFloat(equationOperand[1]))
                        }
                    }
                }
                else if equationOperator[0] == "*"  ||  equationOperator[0] == "/" {
                    if equationOperand.count > 1 {
                        if equationOperator[1] == "+" {
                            graphViewController.drawEquation(CGFloat(equationOperand[0]),CGFloat(equationOperand[1]))
                        }
                        else if equationOperator[1] == "-" {
                            graphViewController.drawEquation(CGFloat(equationOperand[0]),-(CGFloat)(equationOperand[1]))
                        }
                    }
                }
                else if equationOperator[0] == "sin" {
                    if equationOperand.count > 1 {
                        graphViewController.drawSine(1,CGFloat(equationOperand[1]))
                    }
                }
                graphViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
            }
        }
    }
}
