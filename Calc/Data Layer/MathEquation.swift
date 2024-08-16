//
//  MathEquation.swift
//  Calc
//
//  Created by Hyuk Kim on 8/15/24.
//

import Foundation

struct MathEquation {
    
    enum OperationType {
        case add
        case subtract
        case multiply
        case devide
    }
    
    var lhs: Decimal
    var rhs: Decimal?
    var operation: OperationType?
    var result: Decimal?
    
    mutating func execute() {
        
        guard
            let rhs = self.rhs,
            let operation = self.operation else {
                return
            }
        
        // MARK: - Execution
        
        switch operation {
        case .add:
            result = lhs + rhs
        case .subtract:
            result = lhs - rhs
        case .multiply:
            result = lhs * rhs
        case .devide:
            result = lhs / rhs
        }
    }
    
    // MARK: - Negate
    
    mutating func negateLeftHandSide() {
        lhs.negate()
    }
    
    mutating func negateRightHandSide() {
        rhs?.negate()
    }
    
    // MARK: - Percentage
    
    mutating func applyPercentageToLeftHandSide() {
        lhs = calculatePercentageValue(lhs)
    }
    
    mutating func applyPercentageToRightHandSide() {
        guard let decimal = rhs else { return }
        
        rhs = calculatePercentageValue(decimal)
    }
    
    private func calculatePercentageValue(_ decimal: Decimal) -> Decimal {
           return decimal / 100
    }
    
    // MARK: - String Representation
    func generatePrintout() -> String {
        let operationString = generateStringRepresentationOfOperation()
        return lhs.formatted() + " " + operationString + " " + (rhs?.formatted() ?? "") + " = " + (result?.formatted() ?? "")
    }
    
    private func generateStringRepresentationOfOperation() -> String {
        switch operation {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "*"
        case .devide: return "/"
        case .none: return ""
        }
    }
}
