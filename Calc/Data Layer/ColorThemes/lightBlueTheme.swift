

import Foundation


extension ThemeManager {
    
    var lightBlueTheme: CalculatorTheme {
        return CalculatorTheme(
            id: "4",
            backgroundColor:                "#F8F8F8",
            displayColor:                   "#000000",
                               
            extraFunctionColor:             "#D6DEE5",
            extraFunctionTitleColor:        "#00B4FF",
                               
            operationColor:                 "#00B4FF",
            operationTitleColor:            "#FFFFFF",
                               
            pinpadColor:                    "#EEEEEE",
            pinpadTitleColor:               "#000000",
            
            statusBarStyle: .light
        )
    }
}
