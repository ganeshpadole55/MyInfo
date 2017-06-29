//
//  HomeViewController.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 16/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit
import LocalAuthentication
import RNCryptor


class HomeViewController: UIViewController {

    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden=false; // hide navigation bar
        
       
        
//        // Encryption
//        let string = "welcome"
//        let data: NSData = string.data(using: .utf8)! as NSData
//        let password = "hjksllwsk"
//        let ciphertext = RNCryptor.encrypt(data: data as Data, withPassword: password)
//        
//        print(ciphertext)
//        
//        // Decryption
//        do {
//            let originalData = try RNCryptor.decrypt(data: ciphertext, withPassword: password)
//            
//            let resstr = NSString(data: originalData, encoding: String.Encoding.utf8.rawValue)
//            print("Original Value:", resstr!)
//            // ...
//        } catch {
//            print(error)
//        }
        
              
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden=true;
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

       func loadDada() {
       print("authenticateUser")
        
        
        let alertController = UIAlertController(title: "Success", message: "User Authentication Confirmed ", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            print("Cancel")
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("OK")
            
            // login successfully done
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyInfoViewController") as! MyInfoViewController
            
            ModelManager.getInstance().myinfo_flag = true
            ModelManager.getInstance().create_flag = false
            ModelManager.getInstance().edit_flag = false
            ModelManager.getInstance().requestInfoFlag = false
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    func setupData() {
        self.statusLabel.text = ""
    }
    
    @IBAction func TouchIdButtonPressed(_ sender: Any) {
        setupData()
        authenticateUser()
    }
    
    @IBAction func PinSetButtonPressed(_ sender: Any) {
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LockViewController") as! LockViewController
        
        //   ModelManager.getInstance().myinfo_flag = true
        //  ModelManager.getInstance().create_flag = false
        //   ModelManager.getInstance().edit_flag = false
        //  ModelManager.getInstance().requestInfoFlag = false
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
        
    }
    func authenticateUser() {
        let touchIDManager = PITouchIDManager()
        
        touchIDManager.authenticateUser(success: { () -> () in
            OperationQueue.main.addOperation({ () -> Void in
                self.loadDada()
            })
        }, failure: { (evaluationError: NSError) -> () in
            switch evaluationError.code {
            case LAError.Code.systemCancel.rawValue:
                print("Authentication cancelled by the system")
                self.statusLabel.text = "Authentication cancelled by the system"
            case LAError.Code.userCancel.rawValue:
                print("Authentication cancelled by the user")
                self.statusLabel.text = "Authentication cancelled by the user"
            case LAError.Code.userFallback.rawValue:
                print("User wants to use a password")
                self.statusLabel.text = "User wants to use a password"
                // We show the alert view in the main thread (always update the UI in the main thread)
                OperationQueue.main.addOperation({ () -> Void in
                    self.showPasswordAlert()
                })
            case LAError.Code.touchIDNotEnrolled.rawValue:
                print("TouchID not enrolled")
                self.statusLabel.text = "TouchID not enrolled"
            case LAError.Code.passcodeNotSet.rawValue:
                print("Passcode not set")
                self.statusLabel.text = "Passcode not set"
            default:
                print("Authentication failed")
                self.statusLabel.text = "Authentication failed"
                OperationQueue.main.addOperation({ () -> Void in
                    self.showPasswordAlert()
                })
            }
        })
    }

    
    func showPasswordAlert() {
        
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LockViewController") as! LockViewController
        
     //   ModelManager.getInstance().myinfo_flag = true
      //  ModelManager.getInstance().create_flag = false
     //   ModelManager.getInstance().edit_flag = false
      //  ModelManager.getInstance().requestInfoFlag = false
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
        
        
        
    }
    
   

    
    
}
