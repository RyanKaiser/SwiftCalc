
import Foundation


extension ThemeManager {
    
    var pinkTheme: CalculatorTheme {
        return CalculatorTheme(
            id: "7",
            backgroundColor:                "#253C5B",
            displayColor:                   "#EBF0EF",
                               
            extraFunctionColor:             "#294666",
            extraFunctionTitleColor:        "#EBF0EF",
                               
            operationColor:                 "#FA569C",
            operationTitleColor:            "#EBF0EF",
                               
            pinpadColor:                    "#16253A",
            pinpadTitleColor:               "#EBF0EF",
            
            statusBarStyle: .light
        )
    }
}
