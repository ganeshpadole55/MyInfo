//
//  CreateEmploymentInfoViewController.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 24/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CreateEmploymentInfoViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var streetAddressTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var stateTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var cityTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var zipTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var emailIdTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var phoneNumberTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var startDateTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var jobPositionTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var companyNametextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var dateOfBirthdTextField: SkyFloatingLabelTextField!
    var textFields: [SkyFloatingLabelTextField]!
    var currentTextField :UITextField!
    
    var personContactData : personalContact!
    var imageView = UIImageView()
    var leftContainerView = UIView()
    var leftButton = UIButton()
    
    var animateDistance = CGFloat()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden=false;
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        
       self.title = "Create Employment"
        
        textFields = [firstNameTextField, lastNameTextField,streetAddressTextField,stateTextField,cityTextField,zipTextField,emailIdTextField,phoneNumberTextField,startDateTextField,jobPositionTextField,companyNametextField,dateOfBirthdTextField]
        setupTextField()
        
        
        // DatePicker as textField---> startDateTextField,dateOfBirthdTextField
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        
        let clearBtn = UIBarButtonItem(title: "Clear", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CreateEmploymentInfoViewController.tappedToolBarBtn))
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(CreateEmploymentInfoViewController.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = "Select a date"
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([clearBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        
        startDateTextField.inputAccessoryView = toolBar

        
        leftContainerView = UIView(frame: CGRect(x: 0, y: 6, width: 40, height: 32))
        leftButton = UIButton(type:.custom)
        leftButton = UIButton(frame: CGRect(x: 0, y: 6, width: 40, height: 32))
        leftButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        leftButton.addTarget(self, action: #selector(goToBackViewController), for: UIControlEvents.touchUpInside)
        leftContainerView.addSubview(leftButton)
    }

    func donePressed(_ sender: UIBarButtonItem) {
        
        
        dateOfBirthdTextField.resignFirstResponder()
        startDateTextField.resignFirstResponder()
        
    }
    
    func tappedToolBarBtn(_ sender: UIBarButtonItem) {
        
//        if (currentTextField! == startDateTextField)
//        {
//            startDateTextField.text = ""
//            startDateTextField.placeholder = "Select Joining Date"
//        }
//        if (currentTextField == dateOfBirthdTextField)
//        {
//            startDateTextField.text = ""
//            startDateTextField.placeholder = "Select Date Of Birth"
//        }
        
       
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        
        let datePickerView: UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(CreateEmploymentInfoViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
    }
    
    func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        startDateTextField.text = dateFormatter.string(from: sender.date)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        navigationController?.navigationBar.addSubview(leftContainerView)
        navigationController?.navigationBar.addSubview(leftButton)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        leftContainerView.removeFromSuperview()
        leftButton.removeFromSuperview()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func goToBackViewController(sender: UIButton!)
    {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        
    }
    
    func setupTextField() {
        
        applySkyscannerTheme(textField: firstNameTextField)
        applySkyscannerTheme(textField: lastNameTextField)
        applySkyscannerTheme(textField: streetAddressTextField)
        applySkyscannerTheme(textField: cityTextField)
        
        applySkyscannerTheme(textField: stateTextField)
        applySkyscannerTheme(textField: zipTextField)
        applySkyscannerTheme(textField: emailIdTextField)
        applySkyscannerTheme(textField: phoneNumberTextField)
        
        applySkyscannerTheme(textField: startDateTextField)
        applySkyscannerTheme(textField: jobPositionTextField)
        applySkyscannerTheme(textField: companyNametextField)
        applySkyscannerTheme(textField: dateOfBirthdTextField)
        
    }
    
    func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {
        
        textField.tintColor = ColorConstants.overcastBlueColor
        
        textField.textColor = ColorConstants.darkGreyColor
        textField.lineColor = ColorConstants.lightGreyColor
        
        textField.selectedTitleColor = ColorConstants.overcastBlueColor
        textField.selectedLineColor = ColorConstants.overcastBlueColor
        
        // Set custom fonts for the title, placeholder and textfield labels
        textField.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        textField.placeholderFont = UIFont(name: "AppleSDGothicNeo-Light", size: 14)
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let textFieldRect : CGRect = self.view.window!.convert(textField.bounds, from: textField)
        let viewRect : CGRect = self.view.window!.convert(self.view.bounds, from: self.view)
        
        let midline : CGFloat = textFieldRect.origin.y + 0.5 * textFieldRect.size.height
        let numerator : CGFloat = midline - viewRect.origin.y - MoveKeyboard.MINIMUM_SCROLL_FRACTION * viewRect.size.height
        let denominator : CGFloat = (MoveKeyboard.MAXIMUM_SCROLL_FRACTION - MoveKeyboard.MINIMUM_SCROLL_FRACTION) * viewRect.size.height
        var heightFraction : CGFloat = numerator / denominator
        
        if heightFraction==1.0
        {
            heightFraction = 1.0
        }
        
        let orientation : UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
        if (orientation == UIInterfaceOrientation.portrait || orientation == UIInterfaceOrientation.portraitUpsideDown) {
            animateDistance = floor(MoveKeyboard.PORTRAIT_KEYBOARD_HEIGHT * heightFraction)
        } else {
            animateDistance = floor(MoveKeyboard.LANDSCAPE_KEYBOARD_HEIGHT * heightFraction)
        }
        
        var viewFrame : CGRect = self.view.frame
        viewFrame.origin.y -= animateDistance
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(TimeInterval(MoveKeyboard.KEYBOARD_ANIMATION_DURATION))
        
        self.view.frame = viewFrame
        
        UIView.commitAnimations()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var viewFrame : CGRect = self.view.frame
        viewFrame.origin.y += animateDistance
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        
        UIView.setAnimationDuration(TimeInterval(MoveKeyboard.KEYBOARD_ANIMATION_DURATION))
        
        self.view.frame = viewFrame
        
        UIView.commitAnimations()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        streetAddressTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        
        stateTextField.resignFirstResponder()
        zipTextField.resignFirstResponder()
        emailIdTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        
        startDateTextField.resignFirstResponder()
        jobPositionTextField.resignFirstResponder()
        dateOfBirthdTextField.resignFirstResponder()
        companyNametextField.resignFirstResponder()
        
        return true;
    }


   
    @IBAction func SaveButtonPressed(_ sender: Any) {
    }

    @IBAction func GenerateQRCodeButtonPressed(_ sender: Any) {
    }
    
}
