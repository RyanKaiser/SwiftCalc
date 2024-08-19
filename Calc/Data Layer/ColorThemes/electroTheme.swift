import Foundation


extension ThemeManager {
    
    var electroTheme: CalculatorTheme {
        return CalculatorTheme(id:          "2",
            backgroundColor:                "#0E0E41",
            displayColor:                   "#ffffff",
                               
            extraFunctionColor:             "#14145C",
            extraFunctionTitleColor:        "#4BE6A9",
                               
            operationColor:                 "#4BE6A9",
            operationTitleColor:            "#14145C",
            operationSelectedColor:         "#70729D",
            operationTitleSelectedColor:    "#ffffff",
                               
            pinpadColor:                    "#14145C",
            pinpadTitleColor:               "#ffffff",
                               
            statusBarStyle:                 .light)
    }
}
