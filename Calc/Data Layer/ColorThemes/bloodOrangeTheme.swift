import Foundation


extension ThemeManager {
    
    var bloodOrangeTheme: CalculatorTheme {
        return CalculatorTheme(id:          "9",
            backgroundColor:                "#4A1D41",
            displayColor:                   "#ffffff",
                               
            extraFunctionColor:             "#9C3766",
            extraFunctionTitleColor:        "#ffffff",
                               
            operationColor:                 "#8D3362",
            operationTitleColor:            "#ffffff",
            operationSelectedColor:         "#AA0E67",
            operationTitleSelectedColor:    "#ffffff",
                               
            pinpadColor:                    "#C64661",
            pinpadTitleColor:               "#ffffff",
                               
            statusBarStyle:                 .light)
    }
}
