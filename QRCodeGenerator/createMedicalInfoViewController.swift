//
//  createMedicalInfoViewController.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 22/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import STZPopupView
import QRCoder
import DropDown

class createMedicalInfoViewController: UIViewController {

    
    
    @IBOutlet weak var PrimaryPhysicianNameTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var PrimaryPhysicianTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var PrimaryPhysicianAddress: SkyFloatingLabelTextField!
    
    @IBOutlet weak var DiseaseButton: NiceButton!
    
    @IBOutlet weak var SaveButton: UIButton!
    
    @IBOutlet weak var GenerateQRCodeButton: UIButton!
    
    var DiseaseArray = [String]()
    let DiseaseDropDown = DropDown()
    
    var textFields: [SkyFloatingLabelTextField]!
    var imageView = UIImageView()
    var leftContainerView = UIView()
    var leftButton = UIButton()
    var personContactData : personalContact!
    var personMedicalData : MedicalInfo!
    
    
    
    var animateDistance = CGFloat()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden=false;
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        textFields = [PrimaryPhysicianNameTextField, PrimaryPhysicianTextField,PrimaryPhysicianAddress]
        setupTextField()
        
        DiseaseArray = ["Hypertension","Hepatitis","Cancer","Stroke","Diabetes"]
        
        if ModelManager.getInstance().create_flag
        {
            self.title = "Create Medical Info"
            SaveButton.isHidden = false
            GenerateQRCodeButton.isHidden = true
            DiseaseButton.isEnabled = true
        
        }
        if ModelManager.getInstance().requestInfoFlag
        {
            self.title = "Create Medical Info"
            SaveButton.isHidden = true
            GenerateQRCodeButton.isHidden = false
            
        }
        
        if ModelManager.getInstance().edit_flag  // from edit menu option
        {
            if ModelManager.getInstance().insert_New_MedicalRecord_Flag
            {
                self.title = "Create Medical Info"
            
                print("C_Id", ModelManager.getInstance().Medical_ContactData.contactId)
                SaveButton.isHidden = false
                GenerateQRCodeButton.isHidden = true
                
            }
            else{
            
                self.title = "Edit Medical Info"
                self.setPersonMedicalInfoData(personMedicalData: personMedicalData)
                
                SaveButton.isHidden = false
                GenerateQRCodeButton.isHidden = true
                DiseaseButton.isEnabled = true
            }
            
        }
        
        
        if ModelManager.getInstance().myinfo_flag
        {
                self.title = "Edit Medical Info"
                self.setPersonMedicalInfoData(personMedicalData: personMedicalData)
                
                SaveButton.isHidden = true
                GenerateQRCodeButton.isHidden = false
                DiseaseButton.isEnabled = false
       
           
        }
        
        
        self.DiseaseDropDown.dismissMode = .onTap
        self.DiseaseDropDown.direction = .bottom
        self.setupDiseaseDropDowns()
        
             
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

    func setPersonMedicalInfoData(personMedicalData: MedicalInfo)   {
        
        print("Medical Edit Id",personMedicalData.MedicalInfoId)
        
        PrimaryPhysicianNameTextField.text = personMedicalData.PrimaryPhysicianName as String
        PrimaryPhysicianTextField.text = personMedicalData.PrimaryPhysician as String
        PrimaryPhysicianAddress.text = personMedicalData.PrimaryPhysicianAddress as String
   
        
        if ModelManager.getInstance().create_flag
        {
                DiseaseButton.setTitle("Disease" , for: .normal)
        }
        
        if ModelManager.getInstance().edit_flag
        {
             DiseaseButton.setTitle(personMedicalData.Disease as String, for: .normal)
        
        }
        if ModelManager.getInstance().myinfo_flag
        {
            DiseaseButton.setTitle(personMedicalData.Disease as String, for: .normal)

        }
        
        
    }

    
    func setupTextField() {
        
        applySkyscannerTheme(textField: PrimaryPhysicianNameTextField)
        applySkyscannerTheme(textField: PrimaryPhysicianTextField)
        applySkyscannerTheme(textField: PrimaryPhysicianAddress)
       
        
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
        
        PrimaryPhysicianNameTextField.resignFirstResponder()
        PrimaryPhysicianTextField.resignFirstResponder()
        PrimaryPhysicianAddress.resignFirstResponder()
       
        
        return true;
    }
    
    
    @IBAction func DiseaseButtonPressed(_ sender: Any) {
        
        PrimaryPhysicianNameTextField.resignFirstResponder()
        PrimaryPhysicianTextField.resignFirstResponder()
        PrimaryPhysicianAddress.resignFirstResponder()
        
        
        DiseaseDropDown.show()
    }
    
    func setupDiseaseDropDowns() {
        chooseDiseaseDropDownValue()
        
    }
    
    func chooseDiseaseDropDownValue() {
        DiseaseDropDown.anchorView = DiseaseButton
        
        // Will set a custom with instead of anchor view width
        //		dropDown.width = 100
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        DiseaseDropDown.bottomOffset = CGPoint(x: 0, y: DiseaseButton.bounds.height)
        
        
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        DiseaseDropDown.dataSource = DiseaseArray
        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        DiseaseDropDown.cellNib = UINib(nibName: "MyCell", bundle: nil)
        
        DiseaseDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard cell is MyCell else { return }
            
            
        }
        
        
        // Action triggered on selection
        DiseaseDropDown.selectionAction = { [unowned self] (index, item) in
            
            
            self.DiseaseButton.setTitle(item, for: .normal)
            
        }
        
    }
    

    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
       
        
        
            if(DiseaseButton.currentTitle == "Disease")
            {
                Util.invokeAlertMethod("Alert", strBody: "Please select disease", delegate: nil)
                return
            }
            
            if(PrimaryPhysicianNameTextField.text!.isEmpty)
            {
                Util.invokeAlertMethod("Alert", strBody: "Primary Physician Name Required.", delegate: nil)
                return
            }
            else if(PrimaryPhysicianTextField.text!.isEmpty)
            {
                Util.invokeAlertMethod("Alert", strBody: "Physician Required.", delegate: nil)
                return
            }
            else if(PrimaryPhysicianAddress.text!.isEmpty)
            {
                Util.invokeAlertMethod("Alert", strBody: "Physician Address Required.", delegate: nil)
                return
            }
            else{
                
                
                // resign all text fileds
                PrimaryPhysicianNameTextField.resignFirstResponder()
                PrimaryPhysicianTextField.resignFirstResponder()
                PrimaryPhysicianAddress.resignFirstResponder()
                
                
                
                let personalMedicalInfo: MedicalInfo = MedicalInfo()
                personalMedicalInfo.PrimaryPhysicianName = PrimaryPhysicianNameTextField.text!
                personalMedicalInfo.PrimaryPhysician = PrimaryPhysicianTextField.text!
                personalMedicalInfo.PrimaryPhysicianAddress = PrimaryPhysicianAddress.text!
                personalMedicalInfo.Disease = DiseaseButton.titleLabel!.text!
                
                
                if ModelManager.getInstance().create_flag
                {
                    
                    ModelManager.getInstance().insert_New_MedicalRecord_Flag = false
                    
                    // insert record
                    personalMedicalInfo.MedicalInfoId = ModelManager.getInstance().sharedContactData.contactId
                    
                    print("Medical Info Id:",personalMedicalInfo.MedicalInfoId)
                    
                    let isInserted = ModelManager.getInstance().addPersonMedicalData(personalMedicalInfo)
                    
                    if isInserted
                    {
                        print("Record inserted successfully")
                        Util.invokeAlertMethod("", strBody: "Record Inserted successfully.", delegate: nil)
                        
                        
                        let alertController = UIAlertController(title: "Alert", message: "Do you want to create new record? ", preferredStyle: UIAlertControllerStyle.alert)
                        let cancelAction = UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
                            // go to MyInfoViewController
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyInfoViewController") as! MyInfoViewController
                            
                            ModelManager.getInstance().myinfo_flag = true
                            ModelManager.getInstance().create_flag = false
                            ModelManager.getInstance().edit_flag = false
                            ModelManager.getInstance().requestInfoFlag = false
                            
                            
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                            print("Cancel")
                        }
                        let okAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                            print("OK")
                            
                            // Go to gatagories again
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatagoriesViewController") as! CatagoriesViewController
                            
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                        }
                        alertController.addAction(cancelAction)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        
                    } else {
                        Util.invokeAlertMethod("", strBody: "Error in inserting record.", delegate: nil)
                    }
                } // end of insert record
                
       
                
                if ModelManager.getInstance().edit_flag{
                
                    
                    if ModelManager.getInstance().insert_New_MedicalRecord_Flag
                    {
                        // insert record
                        personalMedicalInfo.MedicalInfoId = ModelManager.getInstance().Medical_ContactData.contactId
                        
                        let isInserted = ModelManager.getInstance().addPersonMedicalData(personalMedicalInfo)
                        if isInserted
                        {
                            print("Record inserted successfully")
                            Util.invokeAlertMethod("", strBody: "Record Inserted successfully.", delegate: nil)
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MedicalInfoViewController") as! MedicalInfoViewController
                            nextViewController.person = ModelManager.getInstance().Medical_ContactData
                            
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                            
                        }
                        else{
                            Util.invokeAlertMethod("", strBody: "Error in inserting record.", delegate: nil)
                        }

                        
                    }
                    else{
                    
                        personalMedicalInfo.MedicalInfoId = personMedicalData.MedicalInfoId
                        personalMedicalInfo.M_ID = personMedicalData.M_ID
                        print("Medical Info Id:", personalMedicalInfo.MedicalInfoId)
                        
                        print("Id",personMedicalData.M_ID)
                        
                        let isUpdated = ModelManager.getInstance().updatePersonMedicalData(personalMedicalInfo)
                        
                        if isUpdated
                        {
                            
                            print("Record Updated successfully")
                            Util.invokeAlertMethod("", strBody: "Record Updated successfully.", delegate: nil)
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MedicalInfoViewController") as! MedicalInfoViewController
                            
                            ModelManager.getInstance().medical_update_flag = true
                            nextViewController.medical = personalMedicalInfo
                            nextViewController.person = ModelManager.getInstance().Medical_ContactData
                            
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                            
                        }
                        else{
                            Util.invokeAlertMethod("", strBody: "Error in updating record.", delegate: nil)
                        }
                        
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
            
            let dict = ["Physician Name" : PrimaryPhysicianNameTextField.text!,
                        "Physician" : PrimaryPhysicianTextField.text!,
                        "Address" : PrimaryPhysicianAddress.text!,
                        "Disease" : DiseaseButton.titleLabel!.text!
            ]
            
            
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
