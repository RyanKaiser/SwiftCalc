import UIKit

class LCDDisplay: UIView {
    
    //MARK: - IBOutlets
    
    @IBOutlet var label: UILabel!
    
    // MARK: - Initialisers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    private func sharedInit() {
        addMenuGestureRecognizer()
    }
    
    // MARK: - Gesture Recognizer
    
    private func addMenuGestureRecognizer() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureEventFired(_:)))
        addGestureRecognizer(longPressGesture)
    }
    
    @objc private func longPressGestureEventFired(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            showMenu(from: gesture)
        default:
            break
        }
        
        
    }
    
    // MARK: - UIMenuController
    
    private func showMenu(from gestureRecognizer: UILongPressGestureRecognizer) {
        
        becomeFirstResponder()
        
        let menu = UIMenuController.shared
        guard menu.isMenuVisible == false else { return }
        
        let locationOfTouch = gestureRecognizer.location(in: self)
        var rect = bounds
        rect.origin = locationOfTouch
        rect.origin.y = rect.origin.y - 20
        rect.size = CGSize(width: 1, height: 44)
        menu.showMenu(from: self, rect: rect)
    }
    
    private func hideMenu() {
        UIMenuController.shared.hideMenu(from: self)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy(_:)) ||
            action == #selector(UIResponderStandardEditActions.paste(_:))
        
    }
    
    @objc override func copy(_ sender: Any?) {
        UIPasteboard.general.string = label.text
    }
    
    @objc override func paste(_ sender: Any?) {
        guard let numberToPaste = UIPasteboard.general.string?.doubleValue else { return }

        let userInfo: [AnyHashable: Any] = ["PasteKey": numberToPaste]
        NotificationCenter.default.post(name: Notification.Name("ryan.Calc.LCDDisplay.pasteNumber"), object: nil, userInfo: userInfo)
    }
    
    // MARK: - Color Themes
    
    func prepareForColorColorThemeUpdate() {
        hideMenu()
    }
}
