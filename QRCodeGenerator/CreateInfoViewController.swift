//
//  CreateInfoViewController.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 17/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SideMenu
import DropDown


class CreateInfoViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var streetAddressTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var stateTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var cityTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var zipTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailIdTextField: SkyFloatingLabelTextField!
   
     @IBOutlet weak var personRelationButton: UIButton!
     let personRelationDropDown = DropDown()
  
    var textFields: [SkyFloatingLabelTextField]!

    var leftContainerView = UIView()
    var leftButton = UIButton()
    var personRelationArray = [String]()
    var animateDistance = CGFloat()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.title = "Create Info"
        
        self.navigationController?.navigationBar.isHidden=false;
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        
        
        textFields = [firstNameTextField, lastNameTextField,streetAddressTextField,stateTextField,cityTextField,zipTextField,emailIdTextField]
        
        setupTextField()
        
        personRelationArray = ["Self","Brother","Sister","Father","Mother","Husband","wife","Grandpa","Granny","Other"]
        
        // for relation dropdown [self,brother,father,mother...]
        self.personRelationDropDown.dismissMode = .onTap
        self.personRelationDropDown.direction = .top
        self.setupPersonRelationDropDowns()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.resigntextFileds(_:)))
        
        view.addGestureRecognizer(tapGesture)

        navigationController?.navigationBar.barTintColor = UIColor(red: 71.0/255.0, green: 176.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        leftContainerView = UIView(frame: CGRect(x: 0, y: 6, width: 40, height: 32))
        leftButton = UIButton(type:.custom)
        leftButton = UIButton(frame: CGRect(x: 0, y: 6, width: 40, height: 32))
        leftButton.setImage(UIImage(named: "menu_list")?.withRenderingMode(.alwaysOriginal), for: .normal)
        leftButton.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
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

        
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        streetAddressTextField.text = ""
        stateTextField.text = ""
        cityTextField.text = ""
        zipTextField.text = ""
        emailIdTextField.text = ""
        
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
        lastNameTextField.resignFirstResponder()
        streetAddressTextField.resignFirstResponder()
        stateTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        zipTextField.resignFirstResponder()
        emailIdTextField.resignFirstResponder()
        
        personRelationDropDown.show()
    }
    
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
        
        SideMenuManager.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
       // SideMenuManager.menuAllowPushOfSameClassTwice = false
       
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        leftContainerView.removeFromSuperview()
        leftButton.removeFromSuperview()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func resigntextFileds(_ sender: UITapGestureRecognizer) {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        streetAddressTextField.resignFirstResponder()
        stateTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        zipTextField.resignFirstResponder()
        emailIdTextField.resignFirstResponder()
       
    }
    func setupTextField() {
        
        
        applySkyscannerTheme(textField: firstNameTextField)
        applySkyscannerTheme(textField: lastNameTextField)
        applySkyscannerTheme(textField: streetAddressTextField)
        applySkyscannerTheme(textField: stateTextField)
        applySkyscannerTheme(textField: cityTextField)
        applySkyscannerTheme(textField: zipTextField)
        applySkyscannerTheme(textField: emailIdTextField)
      
        
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
    //This is for the keyboard to GO AWAYY !! when user clicks anywhere on the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        streetAddressTextField.resignFirstResponder()
        stateTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        zipTextField.resignFirstResponder()
        emailIdTextField.resignFirstResponder()
        return true;
    }

    @IBAction func SavePersonalInfo(_ sender: Any) {
        
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
        else if(lastNameTextField.text!.isEmpty)
       {
         Util.invokeAlertMethod("Alert", strBody: "Last Name Required.", delegate: nil)
         return
       }
        else if(emailIdTextField.text!.isEmpty)
       {
        Util.invokeAlertMethod("Alert", strBody: "Email Required.", delegate: nil)
        return
       }
        else if(streetAddressTextField.text!.isEmpty)
       {
        Util.invokeAlertMethod("Alert", strBody: "Street Address Required.", delegate: nil)
        return
        }else if(cityTextField.text!.isEmpty)
       {
        Util.invokeAlertMethod("Alert", strBody: "City Required.", delegate: nil)
        return
        
        }else if(zipTextField.text!.isEmpty)
       {
        Util.invokeAlertMethod("Alert", strBody: "Zip Code Required.", delegate: nil)
        return
        }
       else
       {
        
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
        
                let personalContactInfo: personalContact = personalContact()
                personalContactInfo.FirstName = firstNameTextField.text!
                personalContactInfo.LastName = lastNameTextField.text!
                personalContactInfo.StreetAddress = streetAddressTextField.text!
                personalContactInfo.City = cityTextField.text!
                personalContactInfo.Zip = zipTextField.text!
                personalContactInfo.State = stateTextField.text!
                personalContactInfo.Email = emailIdTextField.text!
                personalContactInfo.Relation = personRelationButton.titleLabel!.text!
                
                let isInserted = ModelManager.getInstance().addPersonalContactData(personalContactInfo)
                if isInserted
                {
                    print("Record inserted successfully")
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatagoriesViewController") as! CatagoriesViewController
                    ModelManager.getInstance().myInfo_self_familyMemberFlag = false
                    nextViewController.personContactData = personalContactInfo
                   // nextViewController.personContactData
                    
                    ModelManager.getInstance().sharedContactData = personalContactInfo
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                    Util.invokeAlertMethod("", strBody: "Record Inserted successfully.", delegate: nil)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in inserting record.", delegate: nil)
                }

        
                }
        
        
        
        }
        
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateUserInfoViewController") as! CreateUserInfoViewController
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
   
}
