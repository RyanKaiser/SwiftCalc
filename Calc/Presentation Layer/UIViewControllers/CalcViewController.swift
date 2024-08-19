//
//  ViewController.swift
//  Calc
//
//  Created by Hyuk Kim on 8/15/24.
//

import UIKit


class CalcViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var lcdDisplay: LCDDisplay!
    
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
    
    @IBOutlet weak var divideButton : UIButton!
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
        addThemeGestureRecognizer()
        redecorateView()
        registerForNotification()
    }
    
    // MARK: - Gestures
    
    private func addThemeGestureRecognizer() {
        let themeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.themeGestureRecognizerDidTap(_:)))
        themeGestureRecognizer.numberOfTapsRequired = 2
        lcdDisplay.addGestureRecognizer(themeGestureRecognizer)
    }
    
    @objc private func themeGestureRecognizerDidTap(_ gesture: UITapGestureRecognizer) {
        lcdDisplay.prepareForColorColorThemeUpdate()
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
        lcdDisplay.label.textColor = UIColor(hex: currentTheme.displayColor)

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
        
        decorateOperationButton(divideButton)
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
        button.setTitleColor(UIColor(hex: currentTheme.operationTitleSelectedColor), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
    }
    
    private func decoratePinPadButton(_ button: UIButton, _ usingSlicedImage: Bool = false) {
        decorateButton(button, usingSlicedImage)
        
        button.tintColor = UIColor(hex: currentTheme.pinpadColor)
        button.setTitleColor(UIColor(hex: currentTheme.pinpadTitleColor), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
    }
    
    // MARK: - Select Operation Buttons
    
    private func deselectOperationButtons() {
        selectOperationButton(divideButton, false)
        selectOperationButton(multiplyButton, false)
        selectOperationButton(addButton, false)
        selectOperationButton(minusButton, false)
    }
    
    private func selectOperationButton(_ button: UIButton, _ selected: Bool) {
        button.tintColor = selected ? UIColor(hex: currentTheme.operationSelectedColor) : UIColor(hex: currentTheme.operationColor)
        button.isSelected = selected
    }
    
    // MARK: - IBActions
    
    @IBAction private func clearPressed() {
        clearButton.bounce()
        deselectOperationButtons()
        calculatorEngine.clearPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func negatePressed() {
        negateButton.bounce()
        deselectOperationButtons()
        calculatorEngine.negatePressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func percentagePressed() {
        percentButton.bounce()
        deselectOperationButtons()
        calculatorEngine.percentagePressed()
        refreshLCDDisplay()
    }
    
    // MARK: - Operations
    
    @IBAction private func addPressed() {
        addButton.bounce()
        
        deselectOperationButtons()
        selectOperationButton(addButton, true)
        
        calculatorEngine.addPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func minusPressed() {
        minusButton.bounce()
        
        deselectOperationButtons()
        selectOperationButton(minusButton, true)
        
        calculatorEngine.minusPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func multiplyPressed() {
        multiplyButton.bounce()
        deselectOperationButtons()
        selectOperationButton(multiplyButton, true)
        
        calculatorEngine.multiplyPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func dividePressed() {
        divideButton.bounce()
        deselectOperationButtons()
        selectOperationButton(divideButton, true)
        
        calculatorEngine.dividePressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func equalsPressed() {
        equalsButton.bounce()
        
        deselectOperationButtons()
        
        calculatorEngine.equalsPressed()
        refreshLCDDisplay()
    }
    
    // MARK: - Number Input
    
    @IBAction private func decimalPressed() {
        decimalButton.bounce()
        
        deselectOperationButtons()
        
        calculatorEngine.decimalPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func numberPressed(_ sender: UIButton) {
        let number = sender.tag
        sender.bounce()
        
        deselectOperationButtons()
        
        calculatorEngine.numberPressed(number)
        refreshLCDDisplay()
    }
    
    // MARK: Refresh LCDDisplay

    private func refreshLCDDisplay() {
        lcdDisplay.label.text = calculatorEngine.lcdDisplayText
    }
    
    // MARK: - Notifications
    
    private func registerForNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceivePasteNotification(notification:)), name: Notification.Name("ryan.Calc.LCDDisplay.pasteNumber"), object: nil)
    }
    
    @objc private func didReceivePasteNotification(notification: Notification) {
        guard let doubleValue = notification.userInfo?["PasteKey"] as? Double else { return }
        
        let decimalValue = Decimal(doubleValue)
        pasateNumberIntoCalculator(from: decimalValue)
    }
    
    // MARK: - Copy & Pasate
    
    private func pasateNumberIntoCalculator(from decimal: Decimal) {
        calculatorEngine.pasteInNumber(from: decimal)
        refreshLCDDisplay()
    }
}

