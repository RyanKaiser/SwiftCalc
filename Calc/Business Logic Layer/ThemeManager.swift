//
//  ThemeManager.swift
//  Calc
//
//  Created by Hyuk Kim on 8/17/24.
//

import Foundation

class ThemeManager {
    
    // MARK: - Singleton
    
    static let shared = ThemeManager()
    
    // MARK: - Themes
    
    private(set) var themes: [CalculatorTheme] = []
    private var savedTheme: CalculatorTheme?
    var currentTheme: CalculatorTheme {
        guard let savedTheme = savedTheme else {
            return themes.first ?? darkBlueTheme
        }
        
        return savedTheme
    }
    
    
    init() {
        populateArrayOfTheme()
    }
    
    private func populateArrayOfTheme() {
        themes = [
            darkTheme,
            darkBlueTheme,
            bloodOrangeTheme,
            electroTheme,
            lightBlueTheme,
            lightTheme,
            orangeTheme,
            pinkTheme,
            purpleTheme,
            washedOutTheme
        ]
    }
}
