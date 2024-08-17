//
//  MathInputController.swift
//  Calc
//
//  Created by Hyuk Kim on 8/16/24.
//

import Foundation

struct MathInputController {
    
    // MARK: - Operand Editing Side
    
    enum OperandSide {
        case leftHandSide
        case rightHandSide
    }

    private var operandSide = OperandSide.leftHandSide
    
    // MARK: - Constants
    
    private let groupingSymbol = Locale.current.groupingSeparator ?? ","
    private let decimalSymbol = Locale.current.decimalSeparator ?? "."
    private let minusSymble = "-"
    private let errorMessage = "Error"
    // MARK: - Math Equation
    
    private(set) var mathEquation = MathEquation(lhs: .zero)
    private var isEnteringDecimal = false
    
    // MARK: - LCD Display
    
    var lcdDisplayText = ""
    
    // MARK: - Initializer
    
    init() {
        lcdDisplayText = formatLCDDisplay(mathEquation.lhs)
    }
    
    // MARK: - Extra Functions
    
    mutating func negatePressed() {
        guard isCompleted == false else { return }
        
        switch operandSide {
        case .leftHandSide:
            mathEquation.negateLeftHandSide()
            
            displayNegateSymbolOnDisplay(mathEquation.lhs)
        case .rightHandSide:
            mathEquation.negateRightHandSide()
            
            displayNegateSymbolOnDisplay(mathEquation.rhs)
        }
    }
    
    private mutating func displayNegateSymbolOnDisplay(_ decimal: Decimal?) {
        guard let decimal = decimal else { return }
        
        let isNegativeValue = decimal < 0 ? true : false
        if isNegativeValue {
            lcdDisplayText.addPrefixIfNeeded(minusSymble)
        } else {
            lcdDisplayText.removePrefixIfNeeded(minusSymble)
        }
    }
    
    mutating func percentagePressed() {
        guard isCompleted == false else { return }
        
        switch operandSide {
        case .leftHandSide:
            mathEquation.applyPercentageToLeftHandSide()
            lcdDisplayText = formatLCDDisplay(mathEquation.lhs)
        case .rightHandSide:
            mathEquation.applyPercentageToRightHandSide()
            lcdDisplayText = formatLCDDisplay(mathEquation.rhs)
        }
    }
    
    // MARK: - Operations
    mutating private func startingRightHandSide() {
        operandSide = .rightHandSide
        isEnteringDecimal = false
    }
    
    mutating func addPressed() {
        guard isCompleted == false else { return }
        
        mathEquation.operation = .add
        startingRightHandSide()
    }
    
    mutating func minusPressed() {
        guard isCompleted == false else { return }
        
        mathEquation.operation = .subtract
        startingRightHandSide()
    }
    
    mutating func multiplyPressed() {
        guard isCompleted == false else { return }
        
        mathEquation.operation = .multiply
        startingRightHandSide()
    }
    
    mutating func dividePressed() {
        guard isCompleted == false else { return }
        
        mathEquation.operation = .devide
        startingRightHandSide()
    }
    
    mutating func execute() {
        guard isCompleted == false else { return }
        
        mathEquation.execute()
        lcdDisplayText = formatLCDDisplay(mathEquation.result)
    }
    
    // MARK: - Number Input
    
    mutating func decimalPressed() {
        lcdDisplayText = appendDecimalPointIfNeeded(lcdDisplayText)
        isEnteringDecimal = true
    }
    
    private func appendDecimalPointIfNeeded(_ string: String) -> String {
        if string.contains(decimalSymbol) {
            return string
        }
            
        return string.appending(decimalSymbol)
    }
    
    mutating func numberPressed(_ number: Int) {
        guard number >= -9, number <= 9 else { return }
        
        switch operandSide {
        case .leftHandSide:
            let tuple = appendNewNumber(number, toPreviousInput: mathEquation.lhs)
            mathEquation.lhs = tuple.0
            lcdDisplayText = tuple.1
        case .rightHandSide:
            let tuple = appendNewNumber(number, toPreviousInput: mathEquation.rhs ?? .zero)
            mathEquation.rhs = tuple.0
            lcdDisplayText = tuple.1
        }
    }
    
    private func appendNewNumber(_ number: Int, toPreviousInput previousInput: Decimal) -> (newNumber: Decimal, newLCDDisplayText: String) {
        
        guard isEnteringDecimal == false else {
            return appendNewDecimalNumber(number)
        }
        
        let stringInput = String(number)
        var newStringRepresentation = previousInput.isZero ? "" : lcdDisplayText
        newStringRepresentation.append(stringInput)
        
        newStringRepresentation = newStringRepresentation.replacingOccurrences(of: groupingSymbol, with: "")
        
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = .decimal
        guard let convertedNumber = formatter.number(from: newStringRepresentation) else { return (.nan, errorMessage)}
        
        let newNumber = convertedNumber.decimalValue
        let newLCDDisplayText = formatLCDDisplay(newNumber)
        return (newNumber, newLCDDisplayText)
    }
    
    private func appendNewDecimalNumber(_ number: Int) -> (newNumber: Decimal, newLCDDisplayText: String) {
        let stringInput = String(number)
        let newStringRepresentation = lcdDisplayText.appending(stringInput)
        
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = .decimal
        guard let convertedNumber = formatter.number(from: newStringRepresentation) else { return (.nan, errorMessage)}
        
        return (convertedNumber.decimalValue, newStringRepresentation)
    }
    
    // MARK: - LCD Display Formatting
    private func formatLCDDisplay(_ decimal: Decimal?) -> String {
        guard 
            let decimal = decimal,
            decimal.isNaN    == false
        else { return errorMessage }
        
        return decimal.formatted()
    }

    // MARK: - Computed Properties
    
    var isCompleted: Bool {
        return mathEquation.executed
    }
}
