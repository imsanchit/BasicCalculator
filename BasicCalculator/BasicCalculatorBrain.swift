//
//  BasicCalculatorBrain.swift
//  BasicCalculator
//
//  Created by Sanchit Mittal on 26/07/17.
//  Copyright © 2017 Sanchit Mittal. All rights reserved.
//

import Foundation

struct BasicCalculatorBrain {
    private var accumulator: Double?
    private var operation: String?
    private var storedOperations = [Double]()
    
    mutating func undo(){
        storedOperations.removeLast()
    }
    var memory: Double?
    func MemoryValue() -> (Double) {
        return memory ?? 0.0
    }
    
    mutating func storeMemory(value: Double?){
        memory = value
    }
    
    mutating func performOperation(_ operand: String , _ symbol: String) {
        
        switch symbol {
        case "+":
            if let acc = accumulator {
                accumulator = acc + Double(operand)!
            }
            accumulator = Double(operand)
            operation = symbol
            storedOperations.append(accumulator!)
        case "-":
            if let acc = accumulator {
                accumulator = acc - Double(operand)!
            }
            accumulator = Double(operand)
            operation = symbol
            storedOperations.append(accumulator!)
        case "/":
            if let acc = accumulator {
                accumulator = acc / Double(operand)!
            }
            accumulator = Double(operand)
            operation = symbol
            storedOperations.append(accumulator!)
        case "*":
            if let acc = accumulator {
                accumulator = acc * Double(operand)!
            }
            accumulator = Double(operand)
            operation = symbol
            storedOperations.append(accumulator!)
            
        case "√":
            if let acc = accumulator {
                accumulator = acc / Double(operand)!
            }
            accumulator = Double(operand)
            operation = symbol
            storedOperations.append(accumulator!)
        case "^2":
            if let acc = accumulator {
                accumulator = acc / Double(operand)!
            }
            accumulator = Double(operand)
            operation = symbol
            storedOperations.append(accumulator!)
        case "sin":
            if let acc = accumulator {
                accumulator = acc / Double(operand)!
            }
            accumulator = Double(operand)
            operation = symbol
            storedOperations.append(accumulator!)
        case "=":
            if( accumulator == nil ) {
                accumulator = Double(operand)
                storedOperations.append(accumulator!)
            }
            else{
                if(operation == "+") {
                    accumulator = accumulator! + Double(operand)!
                    print(accumulator!)
                }   else if(operation == "-") {
                    accumulator = accumulator! - Double(operand)!
                    print(accumulator!)
                }  else if(operation == "*") {
                    accumulator = accumulator! * Double(operand)!
                    print(accumulator!)
                }  else if(operation == "/") {
                    accumulator = accumulator! / Double(operand)!
                    print(accumulator!)
                }
                else{
                    accumulator = Double(operand)
                }
                accumulator = Double(round(10000000000000*accumulator!)/10000000000000)
                storedOperations.append(accumulator!)
            }
        default:
            break
        }
    }
    var result: Double? {
        get{
            return accumulator
        }
        set{
            accumulator = nil
        }
    }
}
