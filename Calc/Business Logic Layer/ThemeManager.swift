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
    
    // MARK: - Data Storage
    
    private let dataStore = DataStoreManager(key: "ryan.Calc.ThemeManager.ThemeIndex")

    // MARK: - Themes
    
    private var savedThemeIndex = 0
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
        restoreSavedTheme()
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
    
    // MARK: - Save & Restore to Disk
    
    private func restoreSavedTheme() {
        guard let encodedTheme = dataStore.getValue() as? Data else {
            return
        }
        let decoder = JSONDecoder()
        if let previousTheme = try? decoder.decode(CalculatorTheme.self, from: encodedTheme) {
            savedTheme = previousTheme
        }
        
    }
    
    private func saveThemeIndexToDisk(_ theme: CalculatorTheme) {
        let encoder = JSONEncoder()
        if let encodedTheme = try? encoder.encode(theme) {
            dataStore.set(encodedTheme)
        }
    }
    
    // MARK: - Next Theme
    
    func moveToNextTheme() {
        
        let currentThemeID = currentTheme.id
        let index = themes.firstIndex { calculatorTheme in
            calculatorTheme.id == currentThemeID
        }
        
        guard let indexOfExistingTheme = index else {
            if let firstTheme = themes.first {
                updateSystemWithTheme(firstTheme)
            }
            return
        }
        
        
        savedThemeIndex += indexOfExistingTheme + 1
        if savedThemeIndex > themes.count - 1 {
            savedThemeIndex = 0
        }
        
        let theme = themes[savedThemeIndex]
        updateSystemWithTheme(theme)
    }
    
    private func updateSystemWithTheme(_ theme:CalculatorTheme) {
        savedTheme = theme
        saveThemeIndexToDisk(theme)
    }
}
