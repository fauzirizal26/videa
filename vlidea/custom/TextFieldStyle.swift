import UIKit

class TextFieldStyle: UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpField()
    }
    
    func setUpField() {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.frame.height))
        
        self.leftView = paddingView
        self.leftViewMode = .always
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
        self.attributedPlaceholder = NSAttributedString(string: "Tulis satu/dua kata tentang idemu...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
    }
}
