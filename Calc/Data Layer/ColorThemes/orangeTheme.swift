import Foundation


extension ThemeManager {
    
    var orangeTheme: CalculatorTheme {
        return CalculatorTheme(
            id: "6",
            backgroundColor:                "#DC6969",
            displayColor:                   "#FFFFFF",
                               
            extraFunctionColor:             "#D05353",
            extraFunctionTitleColor:        "#FFFFFF",
                               
            operationColor:                 "#CC4D4D",
            operationTitleColor:            "#FFFFFF",
                               
            pinpadColor:                    "#C94848",
            pinpadTitleColor:               "#FFFFFF",
            
            statusBarStyle: .light
        )
    }
}
