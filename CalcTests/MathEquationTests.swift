//
//  CalcTests.swift
//  CalcTests
//
//  Created by Hyuk Kim on 8/15/24.
//

import XCTest
@testable import Calc

final class MathEquationTests: XCTestCase {

    func testAddition() throws {
        var mathEquation = MathEquation(lhs: 0)
        mathEquation.lhs = 4
        mathEquation.operation = .add
        mathEquation.rhs = 4
        mathEquation.execute()
        
        let expectedResult = Decimal(8)
        XCTAssertTrue(mathEquation.result?.isEqual(to: expectedResult) ?? false)
    }
    
    func testSubtraction() throws {
        var mathEquation = MathEquation(lhs: .zero)
        mathEquation.lhs = 4
        mathEquation.operation = .subtract
        mathEquation.rhs = 4
        mathEquation.execute()
        
        let expectedResult = Decimal(0)
        XCTAssertTrue(mathEquation.result?.isEqual(to: expectedResult) ?? false)
    }
    
    func testMultiply() throws {
        var mathEquation = MathEquation(lhs: .zero)
        mathEquation.lhs = 4
        mathEquation.operation = .multiply
        mathEquation.rhs = 4
        mathEquation.execute()
        
        let expectedResult = Decimal(16)
        XCTAssertTrue(mathEquation.result?.isEqual(to: expectedResult) ?? false)
    }
    
    func testDevide() throws {
        var mathEquation = MathEquation(lhs: .zero)
        mathEquation.lhs = 4
        mathEquation.operation = .devide
        mathEquation.rhs = 4
        mathEquation.execute()
        
        let expectedResult = Decimal(1)
        XCTAssertTrue(mathEquation.result?.isEqual(to: expectedResult) ?? false)
    }
}
