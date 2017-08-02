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
    

    
    mutating func performOperation(_ operand: String , _ symbol: String) {
    
    switch symbol {
        case "+":
            if let acc = accumulator {
                accumulator = acc + Double(operand)!
            }
            accumulator = Double(operand)
            operation = symbol
        case "-":
            if let acc = accumulator {
                accumulator = acc - Double(operand)!
            }
            accumulator = Double(operand)
            operation = symbol
        case "/":
            if let acc = accumulator {
                accumulator = acc / Double(operand)!
            }
            accumulator = Double(operand)
            operation = symbol
        case "*":
            if let acc = accumulator {
                accumulator = acc * Double(operand)!
            }
            accumulator = Double(operand)
            operation = symbol
        
        case "√":
            if let acc = accumulator {
                accumulator = acc / Double(operand)!
            }
            accumulator = Double(operand)
            operation = symbol
        case "=":
            if( accumulator == nil ) {
                accumulator = Double(operand)
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
