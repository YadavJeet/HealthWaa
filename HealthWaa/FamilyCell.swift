//
//  FamilyCell.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 6/2/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit

class FamilyCell: UITableViewCell {
    
     @IBOutlet weak var name:UILabel!
     @IBOutlet weak var dob:UILabel!
     @IBOutlet weak var birthPlaceName:UILabel!
     @IBOutlet weak var operationType:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
