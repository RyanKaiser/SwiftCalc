import Foundation


extension ThemeManager {
    
    var orangeTheme: CalculatorTheme {
        return CalculatorTheme(id:          "10",
            backgroundColor:                "#DC6969",
            displayColor:                   "#ffffff",
                               
            extraFunctionColor:             "#D05353",
            extraFunctionTitleColor:        "#ffffff",
                               
            operationColor:                 "#CC4D4D",
            operationTitleColor:            "#ffffff",
            operationSelectedColor:         "#AB2F2F",
            operationTitleSelectedColor:    "#ffffff",
                               
            pinpadColor:                    "#C94848",
            pinpadTitleColor:               "#ffffff",
                               
            statusBarStyle:                 .light)
    }
}
