//
//  FamilyMemberTableViewCell.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 26/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class FamilyMemberTableViewCell: MGSwipeTableCell {

    
    @IBOutlet weak var familyMemberNameLabel: UILabel!
    
    @IBOutlet weak var memberRelationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
