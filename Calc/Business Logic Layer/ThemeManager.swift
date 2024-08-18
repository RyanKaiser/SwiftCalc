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
        restoreSavedThemeIndex()
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
    
    private func restoreSavedThemeIndex() {
        savedThemeIndex = 0
        
        if let previousThemeIndex = dataStore.getValue() as? Int {
            savedThemeIndex = previousThemeIndex
        }
        savedTheme = themes[savedThemeIndex]
    }
    
    private func saveThemeIndexToDisk() {
        dataStore.set(savedThemeIndex)
    }
    
    // MARK: - Next Theme
    
    func moveToNextTheme() {
        
        savedThemeIndex += 1
        if savedThemeIndex > themes.count - 1 {
            savedThemeIndex = 0
        }
        
        savedTheme = themes[savedThemeIndex]
        saveThemeIndexToDisk()
    }
}
