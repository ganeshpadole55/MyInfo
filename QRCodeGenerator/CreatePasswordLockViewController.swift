//
//  CreatePasswordLockViewController.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 20/06/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit
import Locksmith

class CreatePasswordLockViewController: UIViewController,CodeInputViewDelegate {

    var leftContainerView = UIView()
    var leftButton = UIButton()
    var count: Int = 0
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        self.navigationController?.navigationBar.isHidden = false; // hide navigation bar
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        
        let codeInputView = CodeInputView(frame: CGRect(x: (view.frame.width-215)/2, y: 242, width: 215, height: 60))
        codeInputView.delegate = self
        codeInputView.tag = 17
        view.addSubview(codeInputView)
        
        codeInputView.becomeFirstResponder()
        
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
    func goToBackViewController(sender: UIButton!)
    {
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        count = 0
        if ModelManager.getInstance().create_Password_flag
        {
            self.title = "Create a password"
            passwordLabel.text = "Create a password"
        }
        if ModelManager.getInstance().login_flag
        {
            self.title = "Login"
             passwordLabel.text = "Enter password"
        }
        if ModelManager.getInstance().changePassword_flag
        {
            self.title = "Change password"
            passwordLabel.text = "Enter password"
        
        }
        
        navigationController?.navigationBar.addSubview(leftContainerView)
        navigationController?.navigationBar.addSubview(leftButton)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        count = 0
        leftContainerView.removeFromSuperview()
        leftButton.removeFromSuperview()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func codeInputView(_ codeInputView: CodeInputView, didFinishWithCode code: String) {
        
        
        if ModelManager.getInstance().create_Password_flag
        {
            
            // craete password
            
           
                let dictionary1 = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount1")
                let dictionary2 = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount2")
                
                if dictionary1 == nil
                {
                    
                    do {
                        try Locksmith.saveData(data: ["key1": code], forUserAccount: "myUserAccount1")
                        (self.view.viewWithTag(17)! as! CodeInputView).clear()
                        passwordLabel.text = "Re enter password"
                    } catch  {
                        print(error)
                    }
                    
                }
                else if dictionary2 == nil {
                    
                    do {
                        try Locksmith.saveData(data: ["key2": code], forUserAccount: "myUserAccount2")
                    } catch  {
                        print(error)
                    }
                    
                    let loadDictionary1 = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount1")
                    let loadDictionary2 = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount2")
                    
                    let password1 = loadDictionary1?["key1"] as! String
                    let password2 = loadDictionary2?["key2"] as! String
                    
                    if password1 == password2
                    {
                        print("LoginSuccessful")
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyInfoViewController") as! MyInfoViewController
                        
                        ModelManager.getInstance().myinfo_flag = true
                        ModelManager.getInstance().create_flag = false
                        ModelManager.getInstance().edit_flag = false
                        ModelManager.getInstance().requestInfoFlag = false
                        
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                        
                    }
                    else{
                        
                        print("Password does not match")
                        (self.view.viewWithTag(17)! as! CodeInputView).clear()
                        passwordLabel.text = "Password does not match"
                        
                        do {
                            try Locksmith.deleteDataForUserAccount(userAccount: "myUserAccount1")
                            try Locksmith.deleteDataForUserAccount(userAccount: "myUserAccount2")
                            
                            
                        } catch  {
                            print(error)
                        }
                        
                        
                    }
                    
                    
                }
                else {
                    
                    
                }

        }
        
        if ModelManager.getInstance().changePassword_flag
        {
            
            
            switch count {
            case 0:
                
                do {
                    try Locksmith.updateData(data: ["key1": code], forUserAccount: "myUserAccount1")
                    (self.view.viewWithTag(17)! as! CodeInputView).clear()
                    passwordLabel.text = "Re enter Password"
                } catch  {
                    print(error)
                }
                
                count += 1
                break
            case 1:
                
                do {
                    try Locksmith.updateData(data: ["key2": code], forUserAccount: "myUserAccount2")
                    
                    let dictionary1 = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount1")
                    let dictionary2 = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount2")
                    
                    let password1 = dictionary1?["key1"] as! String
                    let password2 = dictionary2?["key2"] as! String
                    
                    if password1 == password2
                    {
                        print("Password changed successfully")
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyInfoViewController") as! MyInfoViewController
                        
                        ModelManager.getInstance().myinfo_flag = true
                        ModelManager.getInstance().create_flag = false
                        ModelManager.getInstance().edit_flag = false
                        ModelManager.getInstance().requestInfoFlag = false
                        
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                    }
                    else{
                    
                        count = 0
                        (self.view.viewWithTag(17)! as! CodeInputView).clear()
                        passwordLabel.text = "Enter Password"
                        
                        Util.invokeAlertMethod("Alert", strBody: "Please enter valid password", delegate: self)
                    }
                    
                } catch  {
                     print(error)
                }
                
                
                break
            default:
                print("default case")
            }
            
        
          
        }
        
        if ModelManager.getInstance().login_flag
        {
            let dictionary1 = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount1")
            let dictionary2 = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount2")
            if (dictionary1 != nil) && (dictionary2 != nil){
            
            let password1 = dictionary1?["key1"] as! String
            let password2 = dictionary2?["key2"] as! String
            if (password1 == password2) && (password1 == code)
            {
                print("both are same")
            
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyInfoViewController") as! MyInfoViewController
            
                ModelManager.getInstance().myinfo_flag = true
                ModelManager.getInstance().create_flag = false
                ModelManager.getInstance().edit_flag = false
                ModelManager.getInstance().requestInfoFlag = false
                
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
                
            }
            else{
                    print("Not same")
                
                    Util.invokeAlertMethod("Alert", strBody: "Password does not match.", delegate: nil)
                                    return
                
                }

                
            }
            else{
                Util.invokeAlertMethod("Alert", strBody: "Please set password first.", delegate: self)
                return
            }
            
        
//            (self.view.viewWithTag(17)! as! CodeInputView).clear()
        }
    }
}
