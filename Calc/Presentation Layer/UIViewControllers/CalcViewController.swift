//
//  ViewController.swift
//  Calc
//
//  Created by Hyuk Kim on 8/15/24.
//

import UIKit


class CalcViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var lcdDisplay: UIView!
    @IBOutlet weak var displayLable: UILabel!
    
    @IBOutlet weak var pinpadButton0 : UIButton!
    @IBOutlet weak var pinpadButton1 : UIButton!
    @IBOutlet weak var pinpadButton2 : UIButton!
    @IBOutlet weak var pinpadButton3 : UIButton!
    @IBOutlet weak var pinpadButton4 : UIButton!
    @IBOutlet weak var pinpadButton5 : UIButton!
    @IBOutlet weak var pinpadButton6 : UIButton!
    @IBOutlet weak var pinpadButton7 : UIButton!
    @IBOutlet weak var pinpadButton8 : UIButton!
    @IBOutlet weak var pinpadButton9 : UIButton!
    @IBOutlet weak var decimalButton : UIButton!
    
    @IBOutlet weak var clearButton : UIButton!
    @IBOutlet weak var negateButton : UIButton!
    @IBOutlet weak var percentButton : UIButton!
    
    @IBOutlet weak var devideButton : UIButton!
    @IBOutlet weak var multiplyButton : UIButton!
    @IBOutlet weak var minusButton : UIButton!
    @IBOutlet weak var addButton : UIButton!
    @IBOutlet weak var equalsButton : UIButton!
    
    // MARK: - Color themes
    
    var currentTheme: CalculatorTheme {
        return ThemeManager.shared.currentTheme
    }
    
    // MARK: - Calculator Engine
    private var calculatorEngine = CalculatorEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addThemeGestureRecogniser()
        redecorateView()
    }
    
    // MARK: - Gestures
    
    private func addThemeGestureRecogniser() {
        let themeGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(self.themeGestureRecogniserDidTap(_:)))
        themeGestureRecogniser.numberOfTapsRequired = 2
        lcdDisplay.addGestureRecognizer(themeGestureRecogniser)
    }
    
    @objc private func themeGestureRecogniserDidTap(_ gesture: UITapGestureRecognizer) {
        decorateWithNextTheme()
    }

    // MARK: - Decorate
    
    private func decorateWithNextTheme() {
        ThemeManager.shared.moveToNextTheme()
        redecorateView()
    }
    
    private func redecorateView() {
        view.backgroundColor = UIColor(hex: currentTheme.backgroundColor)
        lcdDisplay.backgroundColor = UIColor(hex: currentTheme.backgroundColor)
        displayLable.textColor = UIColor(hex: currentTheme.displayColor)

        setNeedsStatusBarAppearanceUpdate()
        
        decorateButtons()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch currentTheme.statusBarStyle {
        case .light:
            return .lightContent
        case .dark:
            return .darkContent
        }
    }
    
    private func decorateButtons() {
        decoratePinPadButton(pinpadButton0, true)
        decoratePinPadButton(pinpadButton1)
        decoratePinPadButton(pinpadButton2)
        decoratePinPadButton(pinpadButton3)
        decoratePinPadButton(pinpadButton4)
        decoratePinPadButton(pinpadButton5)
        decoratePinPadButton(pinpadButton6)
        decoratePinPadButton(pinpadButton7)
        decoratePinPadButton(pinpadButton8)
        decoratePinPadButton(pinpadButton9)
        decoratePinPadButton(decimalButton)

        decorateExtraFunctionButton(clearButton)
        decorateExtraFunctionButton(negateButton)
        decorateExtraFunctionButton(percentButton)
        
        decorateOperationButton(devideButton)
        decorateOperationButton(multiplyButton)
        decorateOperationButton(minusButton)
        decorateOperationButton(addButton)
        decorateOperationButton(equalsButton)
    }
    
    private func decorateButton(_ button: UIButton, _ usingSlicedImage: Bool = false) {
        button.setBackgroundImage(usingSlicedImage ? UIImage(named: "CircleSliced") : UIImage(named: "Circle"), for: .normal)
        button.backgroundColor = .clear
    }
    
    
    private func decorateExtraFunctionButton(_ button: UIButton) {
        decorateButton(button)
        
        button.tintColor = UIColor(hex: currentTheme.extraFunctionColor)
        button.setTitleColor(UIColor(hex: currentTheme.extraFunctionTitleColor), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
    }
    
    private func decorateOperationButton(_ button: UIButton) {
        decorateButton(button)
        
        button.tintColor = UIColor(hex: currentTheme.operationColor)
        button.setTitleColor(UIColor(hex: currentTheme.operationTitleColor), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
    }
    
    private func decoratePinPadButton(_ button: UIButton, _ usingSlicedImage: Bool = false) {
        decorateButton(button, usingSlicedImage)
        
        button.tintColor = UIColor(hex: currentTheme.pinpadColor)
        button.setTitleColor(UIColor(hex: currentTheme.pinpadTitleColor), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
    }
    
    // MARK: - IBActions
    
    @IBAction private func clearPressed() {
        calculatorEngine.clearPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func negatePressed() {
        calculatorEngine.negatePressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func percentagePressed() {
        calculatorEngine.percentagePressed()
        refreshLCDDisplay()
    }
    
    // MARK: - Operations
    
    @IBAction private func addPressed() {
        calculatorEngine.addPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func minusPressed() {
        calculatorEngine.minusPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func multiplyPressed() {
        calculatorEngine.multiplyPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func dividePressed() {
        calculatorEngine.dividePressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func equalsPressed() {
        calculatorEngine.equalsPressed()
        refreshLCDDisplay()
    }
    
    // MARK: - Number Input
    
    @IBAction private func decimalPressed() {
        calculatorEngine.decimalPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func numberPressed(_ sender: UIButton) {
        let number = sender.tag
        
        calculatorEngine.numberPressed(number)
        refreshLCDDisplay()
    }
    
    // MARK: Refresh LCDDisplay

    private func refreshLCDDisplay() {
        displayLable.text = calculatorEngine.lcdDisplayText
    }
}

