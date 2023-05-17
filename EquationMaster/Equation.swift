//
//  Equation.swift
//  EquationMaster
//
//  Created by Štěpán Pazderka on 12.05.2023.
//

import Foundation

struct Equation: Equatable {
    var label: String
    var correctResult: Int
    
    init() {
        let firstNumber = Int.random(in: 1...20)
        let secondNumber = Int.random(in: 1...10)
        let operation = ["+", "-", "/", "*"].randomElement()!
        
        switch operation {
        case "+":
            self.correctResult = Int(firstNumber + secondNumber)
            self.label = "\(firstNumber) + \(secondNumber)"
        case "-":
            self.correctResult = Int(firstNumber - secondNumber)
            self.label = "\(firstNumber) - \(secondNumber)"
        case "/":
            let (smallerNumber, largerNumber) = firstNumber < secondNumber ? (firstNumber, secondNumber) : (secondNumber, firstNumber)
            let modulo = largerNumber % smallerNumber
            self.correctResult = (largerNumber - modulo) / smallerNumber
            self.label = "\(largerNumber - modulo) / \(smallerNumber)"
        case "*":
            self.correctResult = Int(firstNumber * secondNumber)
            self.label = "\(firstNumber) * \(secondNumber)"
        default:
            self.correctResult = 0
            self.label = "None"
        }
    }
}
