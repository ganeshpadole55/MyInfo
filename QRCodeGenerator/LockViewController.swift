//
//  LockViewController.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 20/06/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit
import Locksmith

class LockViewController: UIViewController {

    var leftContainerView = UIView()
    var leftButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false; // hide navigation bar
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        self.title = "Home View"
        
        leftContainerView = UIView(frame: CGRect(x: 0, y: 6, width: 40, height: 32))
        leftButton = UIButton(type:.custom)
        leftButton = UIButton(frame: CGRect(x: 0, y: 6, width: 40, height: 32))
        leftButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        leftButton.addTarget(self, action: #selector(goToBackViewController), for: UIControlEvents.touchUpInside)
        leftContainerView.addSubview(leftButton)
        

        
        // Do any additional setup after loading the view.
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

    @IBAction func LoginButtonPressed(_ sender: Any) {
        
        let dictionary1 = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount1")
        let dictionary2 = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount2")
        
        if (dictionary1 == nil) && (dictionary2 == nil)
        {
            Util.invokeAlertMethod("Alert", strBody: "Please create password first.", delegate: self)
            return
        }
        else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreatePasswordLockViewController") as! CreatePasswordLockViewController
            
            ModelManager.getInstance().login_flag = true
            ModelManager.getInstance().create_Password_flag = false
            ModelManager.getInstance().changePassword_flag = false
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            
        }

        
        
       
        
    }
   
    @IBAction func CreatePasswordButtonPressed(_ sender: Any) {
        
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreatePasswordLockViewController") as! CreatePasswordLockViewController
        
        ModelManager.getInstance().login_flag = false
        ModelManager.getInstance().create_Password_flag = true
        ModelManager.getInstance().changePassword_flag = false
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }

    @IBAction func RemovePasswordButtonPressed(_ sender: Any) {
        
        
        let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to delete this password?", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            print("Cancel")
        }
        let okAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            
            do {
                try Locksmith.deleteDataForUserAccount(userAccount: "myUserAccount1")
                try Locksmith.deleteDataForUserAccount(userAccount: "myUserAccount2")
                
                let dictionary1 = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount1")
                let dictionary2 = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount2")
                
                if (dictionary1 == nil) && (dictionary2 == nil)
                {
                    print("User password deleted")
                    
                    Util.invokeAlertMethod("Success", strBody: "User password reset successfully.", delegate: self)
                }
                else{
                
                    
                }
                
                
            } catch  {
                print(error)
            }
            
            print("OK")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        
       
        
    }
    
    @IBAction func changePasswordButtonPressed(_ sender: Any) {
        
        
        let dictionary1 = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount1")
        let dictionary2 = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount2")
        
        if (dictionary1 == nil) && (dictionary2 == nil)
        {
            
            Util.invokeAlertMethod("Alert", strBody: "Please create password first.", delegate: self)
            return
        }
        else{
            ModelManager.getInstance().login_flag = false
            ModelManager.getInstance().create_Password_flag = false
            ModelManager.getInstance().changePassword_flag = true
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreatePasswordLockViewController") as! CreatePasswordLockViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            
        }
        
        
        
        
    }
}
