//
//  CreateUserInfoViewController.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 17/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import DropDown
import STZPopupView
import QRCoder


class CreateUserInfoViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNametextField: SkyFloatingLabelTextField!
    @IBOutlet weak var MITextField: SkyFloatingLabelTextField!
    @IBOutlet weak var streetAddresstextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var cityTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var statetextField: SkyFloatingLabelTextField!
    @IBOutlet weak var zipTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailIdTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var primaryPhoneTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var secondaryPhoneTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var driverLicenseTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var SSNTextField: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var personRelationButton: UIButton!
    
    
    @IBOutlet weak var SaveButton: UIButton!
     
    @IBOutlet weak var GenerateQRCodeButton: UIButton!
    
    
    var textFields: [SkyFloatingLabelTextField]!
    var leftContainerView = UIView()
    var leftButton = UIButton()
    
    var personRelationArray = [String]()
    var otherRelationArray = [String]()
    
    let personRelationDropDown = DropDown()
    var imageView = UIImageView()
    var personContactData : personalContact!
    
    
    
    var animateDistance = CGFloat()
    
       
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden=false;
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        self.title="Edit Personal Info"
        
        personRelationArray = ["Self","Brother","Sister","Father","Mother","Grandpa","Granny","Other"]
        
        if ModelManager.getInstance().requestInfoFlag
        {
             self.title="Edit Personal Info"
            
            SaveButton.isHidden = true
            GenerateQRCodeButton.isHidden = false
            GenerateQRCodeButton.isEnabled = true
            personRelationButton.isHidden = true
            
        }
        else if ModelManager.getInstance().myinfo_flag{
            
              self.setPersonContactinfo(personContactData: personContactData)
            
            SaveButton.isHidden = true
            GenerateQRCodeButton.isHidden = false
            personRelationButton.isHidden = false
            personRelationButton.isEnabled = false
        }
        else if ModelManager.getInstance().edit_flag  // edit option
        {
            self.setPersonContactinfo(personContactData: personContactData)
            SaveButton.isHidden = false
            GenerateQRCodeButton.isHidden = true
            personRelationButton.isHidden = false
            personRelationButton.isEnabled = true
            
        }else if ModelManager.getInstance().create_flag
        {
            self.setPersonContactinfo(personContactData: personContactData)
            SaveButton.isHidden = false
            GenerateQRCodeButton.isHidden = true
            personRelationButton.isHidden = false
            personRelationButton.isEnabled = true
        
        }else
        {
           
            SaveButton.isHidden = false
            GenerateQRCodeButton.isHidden = true
            personRelationButton.isHidden = false
            personRelationButton.isEnabled = true
        }
        
        
      
        textFields = [firstNameTextField, lastNametextField, MITextField, streetAddresstextField, cityTextField,statetextField,zipTextField,emailIdTextField,primaryPhoneTextField,secondaryPhoneTextField,driverLicenseTextField,SSNTextField]
        setupTextField()
        
        // for relation dropdown [self,brother,father,mother...]
        self.personRelationDropDown.dismissMode = .onTap
        self.personRelationDropDown.direction = .top
        self.setupPersonRelationDropDowns()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.resigntextFileds(_:)))
        view.addGestureRecognizer(tapGesture)
        
        leftContainerView = UIView(frame: CGRect(x: 0, y: 6, width: 40, height: 32))
        leftButton = UIButton(type:.custom)
        leftButton = UIButton(frame: CGRect(x: 0, y: 6, width: 40, height: 32))
        leftButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        leftButton.addTarget(self, action: #selector(goToBackViewController), for: UIControlEvents.touchUpInside)
        leftContainerView.addSubview(leftButton)
    
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
    
    func setPersonContactinfo(personContactData: personalContact)   {
        
        firstNameTextField.text = personContactData.FirstName
        lastNametextField.text = personContactData.LastName
        MITextField.text = personContactData.MI
        streetAddresstextField.text = personContactData.StreetAddress
        cityTextField.text = personContactData.City
        statetextField.text = personContactData.State
        zipTextField.text = personContactData.Zip
        emailIdTextField.text = personContactData.Email
        primaryPhoneTextField.text = personContactData.PrimaryPhoneNumber
        secondaryPhoneTextField.text = personContactData.SecondaryPhoneNumber
        SSNTextField.text = personContactData.SSN
        driverLicenseTextField.text = personContactData.DriverLicense
        print(personContactData.Relation)
        
       
        if ModelManager.getInstance().myinfo_flag
        {
            personRelationButton.setTitle(personContactData.Relation as String, for: .normal)
            
        }
        
        if ModelManager.getInstance().create_flag // create menu pressed
        {
            
            personRelationButton.setTitle(personContactData.Relation as String, for: .normal)
            personRelationButton.isEnabled = false;
            
        }
        
        if ModelManager.getInstance().edit_flag  // from edit menu pressed
        {
             personRelationButton.setTitle(personContactData.Relation as String, for: .normal)
            
        }
        
        if ModelManager.getInstance().requestInfoFlag
        {
            personRelationButton.setTitle(personContactData.Relation as String, for: .normal)
        }
        
    
    }
    func setupTextField() {
        
        
        applySkyscannerTheme(textField: firstNameTextField)
        applySkyscannerTheme(textField: lastNametextField)
        applySkyscannerTheme(textField: MITextField)
        applySkyscannerTheme(textField: streetAddresstextField)
        applySkyscannerTheme(textField: cityTextField)
        
        applySkyscannerTheme(textField: statetextField)
        applySkyscannerTheme(textField: zipTextField)
        applySkyscannerTheme(textField: emailIdTextField)
        applySkyscannerTheme(textField: primaryPhoneTextField)
        applySkyscannerTheme(textField: secondaryPhoneTextField)
        
        applySkyscannerTheme(textField: SSNTextField)
        applySkyscannerTheme(textField: driverLicenseTextField)
    }
    
    func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {
        
        textField.tintColor = ColorConstants.overcastBlueColor
        
        textField.textColor = ColorConstants.darkGreyColor
        textField.lineColor = ColorConstants.lightGreyColor
        
        textField.selectedTitleColor = ColorConstants.overcastBlueColor
        textField.selectedLineColor = ColorConstants.overcastBlueColor
        
        // Set custom fonts for the title, placeholder and textfield labels
        textField.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        textField.placeholderFont = UIFont(name: "AppleSDGothicNeo-Light", size: 13)
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
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
    //This is for the keyboard to GO AWAYY !! when user clicks anywhere on the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        firstNameTextField.resignFirstResponder()
        lastNametextField.resignFirstResponder()
        MITextField.resignFirstResponder()
        streetAddresstextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        
        statetextField.resignFirstResponder()
        zipTextField.resignFirstResponder()
        emailIdTextField.resignFirstResponder()
        primaryPhoneTextField.resignFirstResponder()
        secondaryPhoneTextField.resignFirstResponder()
        
        SSNTextField.resignFirstResponder()
        driverLicenseTextField.resignFirstResponder()
        
        return true;
    }
    
    func resigntextFileds(_ sender: UITapGestureRecognizer) {
        firstNameTextField.resignFirstResponder()
        lastNametextField.resignFirstResponder()
        MITextField.resignFirstResponder()
        streetAddresstextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        
        statetextField.resignFirstResponder()
        zipTextField.resignFirstResponder()
        emailIdTextField.resignFirstResponder()
        primaryPhoneTextField.resignFirstResponder()
        secondaryPhoneTextField.resignFirstResponder()
        
        SSNTextField.resignFirstResponder()
        driverLicenseTextField.resignFirstResponder()

    }
    func setupPersonRelationDropDowns() {
        choosePersonRelationDropDownValue()
        
    }
   
       func choosePersonRelationDropDownValue() {
        personRelationDropDown.anchorView = personRelationButton
        
        // Will set a custom with instead of anchor view width
        //		dropDown.width = 100
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        personRelationDropDown.bottomOffset = CGPoint(x: 0, y: personRelationButton.bounds.height)
        
        
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        personRelationDropDown.dataSource = personRelationArray
        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        personRelationDropDown.cellNib = UINib(nibName: "MyCell", bundle: nil)
        
        personRelationDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard cell is MyCell else { return }
            
            
        }
        
        
        // Action triggered on selection
        personRelationDropDown.selectionAction = { [unowned self] (index, item) in
            
            
            self.personRelationButton.setTitle(item, for: .normal)
           
        }
    
    }


    @IBAction func personRelationButtonPressed(_ sender: Any) {
        
        firstNameTextField.resignFirstResponder()
        lastNametextField.resignFirstResponder()
        MITextField.resignFirstResponder()
        streetAddresstextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        
        statetextField.resignFirstResponder()
        zipTextField.resignFirstResponder()
        emailIdTextField.resignFirstResponder()
        primaryPhoneTextField.resignFirstResponder()
        secondaryPhoneTextField.resignFirstResponder()
        
        SSNTextField.resignFirstResponder()
        driverLicenseTextField.resignFirstResponder()
        
         personRelationDropDown.show()
    }
    
   
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        
        
        // resign all text fields
        firstNameTextField.resignFirstResponder()
        lastNametextField.resignFirstResponder()
        MITextField.resignFirstResponder()
        streetAddresstextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        
        statetextField.resignFirstResponder()
        zipTextField.resignFirstResponder()
        emailIdTextField.resignFirstResponder()
        primaryPhoneTextField.resignFirstResponder()
        secondaryPhoneTextField.resignFirstResponder()
        
        SSNTextField.resignFirstResponder()
        driverLicenseTextField.resignFirstResponder()
        
        
        
        if ModelManager.getInstance().create_flag
        {
            personContactData.contactId = ModelManager.getInstance().sharedContactData.contactId
            
        }
        if ModelManager.getInstance().edit_flag
        {
            personContactData.contactId = personContactData.contactId
            
        }
        
        
        personContactData.FirstName = firstNameTextField.text!
        personContactData.LastName = lastNametextField.text!
        personContactData.MI = MITextField.text!
        personContactData.StreetAddress = streetAddresstextField.text!
        personContactData.City = cityTextField.text!
        personContactData.State = statetextField.text!
        personContactData.Zip = zipTextField.text!
        personContactData.Email = emailIdTextField.text!
        personContactData.PrimaryPhoneNumber = primaryPhoneTextField.text!
        personContactData.SecondaryPhoneNumber = secondaryPhoneTextField.text!
        personContactData.SSN = SSNTextField.text!
        personContactData.DriverLicense = driverLicenseTextField.text!
        
        personContactData.Relation = personRelationButton.titleLabel!.text!
        print( personContactData.Relation)
        
        if(personRelationButton.currentTitle == "Relation")
        {
            Util.invokeAlertMethod("Alert", strBody: "Please select person relation.", delegate: nil)
            return
        }
        
        
        if (firstNameTextField.text!.isEmpty)
        {
            Util.invokeAlertMethod("Alert", strBody: "First Name Required.", delegate: nil)
            return
        }
        else if(lastNametextField.text!.isEmpty)
        {
            Util.invokeAlertMethod("Alert", strBody: "Last Name Required.", delegate: nil)
            return
            
        }else if(emailIdTextField.text!.isEmpty)
        {
            Util.invokeAlertMethod("Alert", strBody: "Email Required.", delegate: nil)
            return
        }
        else{
        
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            
            if emailTest .evaluate(with: emailIdTextField.text!)==false
            {
                // create alert
                
                Util.invokeAlertMethod("Alert", strBody: "Please enter a valid email address.", delegate: nil)
                //displayMyAlertMessage("Please enter a valid email address")
                return
                
            }
            else{
                
                
                
                
                
                // update record
                
                let isUpdated = ModelManager.getInstance().updatePersonData(personContactData)
                if isUpdated {
                    
                    
                    Util.invokeAlertMethod("", strBody: "Record updated successfully.", delegate: nil)
                    var message: String!
                    
                    if ModelManager.getInstance().create_flag{
                         message = "Do you want to create new record? "
                        
                    }
                    if ModelManager.getInstance().edit_flag{
                        message = "Do you want to update other record? "

                    }
                    
                    
                  
                        let alertController = UIAlertController(title: "Alert", message: message , preferredStyle: UIAlertControllerStyle.alert)
                        let cancelAction = UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
                            // go to MyInfoViewController
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyInfoViewController") as! MyInfoViewController
                            
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                            print("Cancel")
                        }
                        let okAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                            print("OK")
                            
                            // Go to gatagories again
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatagoriesViewController") as! CatagoriesViewController
                            
                            if ModelManager.getInstance().edit_flag
                            {
                                nextViewController.myInfoContactData = self.personContactData
                            }
                            
                            
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                        }
                        alertController.addAction(cancelAction)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                 
             
                    
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in updating record.", delegate: nil)
                }
 
            }
        }
        
        
    }
    
    @IBAction func generateQRButtonPressed(_ sender: Any) {
        
        let popupView = createPopupview()
        
        presentPopupView(popupView)
    }
    
    func createPopupview() -> UIView {
        
        let generator = QRCodeGenerator()
        
        let popupView = UIView(frame: CGRect(x: 0, y: 0, width: 230, height: 230))
        popupView.backgroundColor = UIColor.white
        
        // Close button
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 70, y: 193, width: 80, height: 40)
        button.setTitle("CANCEL", for: UIControlState())
        button.addTarget(self, action: #selector(touchClose), for: UIControlEvents.touchUpInside)
        popupView.addSubview(button)
        
        
        // uiview
        let customView = UIView()
        
        customView.frame = CGRect.init(x: 0, y: 0, width: 230, height: 40)
        customView.backgroundColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)     //give color to the view
        //  customView.center = self.view.center
        popupView.addSubview(customView)
        
        // uilabel
        
        let label = UILabel(frame: CGRect(x: 80, y: 80, width: 230, height: 21))
        label.center = CGPoint(x:115, y: 20)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "Generated Code"
        customView.addSubview(label)
        
        
        // object to jsonRepresentation
        var jsonRepresentation : String {
            
            let dict = ["First Name" : firstNameTextField.text!,
                        "Last Name" : lastNametextField.text!,
                        "M.I." : MITextField.text!,
                        "StreetAddress": streetAddresstextField.text!,
                        "City": cityTextField.text!,
                        "State": statetextField.text!,
                        "Zip": zipTextField.text!,
                        "Email": emailIdTextField.text!,
                        "PrimaryPhoneNumber": primaryPhoneTextField.text!,
                        "SecondaryPhoneNumber": secondaryPhoneTextField.text!,
                        "SSN": SSNTextField.text!,
                        "DriverLicense": driverLicenseTextField.text!,
                        "Relation": personRelationButton.titleLabel!.text!]
            
            
            let data =  try! JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data:data, encoding:.isoLatin1)!
        }
        
        
        imageView = UIImageView(frame: CGRect(x: 40, y: 50,width: 150,height: 150))
        imageView.contentMode = .scaleAspectFill
        imageView.image=generator.createImage(jsonRepresentation,size: CGSize(width: 150,height: 150))
        popupView.addSubview(imageView)
        
        return popupView
    }
    
    func touchClose() {
        dismissPopupView()
    }

}
