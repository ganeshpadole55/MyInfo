//
//  MainViewController.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 26/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit
import SideMenu

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Define the menus
        SideMenuManager.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
