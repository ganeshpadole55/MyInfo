import UIKit

open class CodeInputView: UIView, UIKeyInput

    

{
    open var delegate: CodeInputViewDelegate?
   // open var frame = CGRect(x: 15, y: 10, width: 35, height: 40)
    
    fileprivate var nextTag = 1

    // MARK: - UIResponder

    open override var canBecomeFirstResponder : Bool {
        return true
    }

    // MARK: - UIView

    public override init(frame: CGRect) {
        super.init(frame: frame)

        // Add four digitLabels
        var frame = CGRect(x: 15, y: 10, width: 35, height: 40)
        for index in 1...4 {
            
           let passwordTextField = UITextField(frame: frame)
            
            passwordTextField.font = UIFont.systemFont(ofSize: 42)
            passwordTextField.tag = index
          //  passwordTextField.isSecureTextEntry = true
            
            passwordTextField.text = "-"
            passwordTextField.textAlignment = .center
            addSubview(passwordTextField)
            frame.origin.x += 35 + 15
            
        }
    }
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") } // NSCoding

    // MARK: - UIKeyInput

    public var hasText : Bool {
        return nextTag > 1 ? true : false
    }

    open func insertText(_ text: String) {
        
        
        
        if nextTag < 5 {
            (viewWithTag(nextTag)! as! UITextField).text = text
            (viewWithTag(nextTag)! as! UITextField).isSecureTextEntry = true
            
            nextTag += 1
            
            if nextTag == 5 {
                var code = ""
                for index in 1..<nextTag {
                    code += (viewWithTag(index)! as! UITextField).text!
                }
                delegate?.codeInputView(self, didFinishWithCode: code)
            }
        }

        
        
//        if nextTag < 5 {
//            (viewWithTag(nextTag)! as! UILabel).text = text
//            nextTag += 1
//
//            if nextTag == 5 {
//                var code = ""
//                for index in 1..<nextTag {
//                    code += (viewWithTag(index)! as! UILabel).text!
//                }
//                delegate?.codeInputView(self, didFinishWithCode: code)
//            }
//        }
    }

    open func deleteBackward() {
        
        if nextTag > 1 {
            nextTag -= 1
            (viewWithTag(nextTag)! as! UITextField).isSecureTextEntry = false

            (viewWithTag(nextTag)! as! UITextField).text = "-"
                    }
        
//        if nextTag > 1 {
//            nextTag -= 1
//            (viewWithTag(nextTag)! as! UILabel).text = "–"
//        }
    }

    open func clear() {
        while nextTag > 1 {
            deleteBackward()
        }
    }

    // MARK: - UITextInputTraits

    open var keyboardType: UIKeyboardType { get { return .numberPad } set { } }
    
    //open var isSecureTextEntry: Bool { get set } // default is NO
    @nonobjc open var isSecureTextEntry:  UITextInputTraits{ get { return true as! UITextInputTraits} set{}}

}

public protocol CodeInputViewDelegate {
    func codeInputView(_ codeInputView: CodeInputView, didFinishWithCode code: String)
}
