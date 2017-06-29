//
//  ContactInfoTableViewCell.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 22/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class ContactInfoTableViewCell: MGSwipeTableCell {

    
    // person contact info
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    // person Medical Info
   
    @IBOutlet weak var primaryPhysicianNameLabel: UILabel!
    @IBOutlet weak var physicianAddressLabel: UILabel!
    @IBOutlet weak var diseaseLabel: UILabel!
    
   
    // Motor Vehicle Info
    @IBOutlet weak var MakeLabel: UILabel!
    @IBOutlet weak var LicensePlateLabel: UILabel!
    @IBOutlet weak var VINLabel: UILabel!
    @IBOutlet weak var ModelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
}
