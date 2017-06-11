//
//  CalculatorBrain.swift
//  cal
//
//  Created by pokemon on 5/29/17.
//  Copyright © 2017 pokemon. All rights reserved.
//


import Foundation

func changesign(operand: Double) -> Double{
    return -operand
}
struct CalculatorBrain{
    private var accumulator : Double?
    private var operations : Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "±" : Operation.unaryOperation(changesign),
        "X": Operation.binaryoperation({$0 * $1}),
        "/": Operation.binaryoperation({$0 / $1}),
        "+": Operation.binaryoperation({$0 + $1}),
        "-": Operation.binaryoperation({$0 - $1})
    ]
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryoperation((Double, Double) -> Double)
        case equals
    }
    mutating func performoperation(_ Symbol : String){
        if let operation = operations[Symbol]{
            switch operation{
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if (accumulator != nil){
                    accumulator = function(accumulator!)
                }
            case .binaryoperation (let function):
                if (accumulator != nil){
                    pbo = PendingBinaryOperation(function : function, operand: accumulator!)
                    }
            case .equals:
                PerformPendingBinaryOperation()
            default:
                print("lol")
            }
        }
    }
    
    
    private mutating var PerformPendingBinaryOperation(){
        accumulator = pbo?.perform(with: accumulator!)
    }
    mutating func setoperand(_ operand: Double){
        accumulator = operand
    }
    private var pbo : PendingBinaryOperation?
    private struct PendingBinaryOperation{
        let function: (Double, Double)-> Double
        let operand: (Double)
        
        func perform(with secondoperand: Double)-> Double{
            return function(operand * secondoperand)
        }
        
    }
    var result : Double? {
        get{
            return accumulator
        }
    }
    
    
}
