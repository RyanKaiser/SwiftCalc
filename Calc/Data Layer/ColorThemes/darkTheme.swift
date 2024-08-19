import Foundation


extension ThemeManager {
    
    var darkTheme: CalculatorTheme {
        return CalculatorTheme(id:          "1",
            backgroundColor:                "#000000",
            displayColor:                   "#ffffff",
                               
            extraFunctionColor:             "#a6a6a6",
            extraFunctionTitleColor:        "#000000",
                               
            operationColor:                 "#ff9f0a",
            operationTitleColor:            "#ffffff",
            operationSelectedColor:         "#ffffff",
            operationTitleSelectedColor:    "#ff9f0a",
                               
            pinpadColor:                    "#333333",
            pinpadTitleColor:               "#ffffff",
                               
            statusBarStyle:                 .light)
    }
}
