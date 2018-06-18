//
//  EmergencyContactCell.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 6/1/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit

protocol EmergencyContactDalegate:class {
    
    func delete(cell:EmergencyContactCell)
    func edit(cell:EmergencyContactCell)
    func track(cell:EmergencyContactCell)
}

class EmergencyContactCell: UITableViewCell {

    weak var delegate:EmergencyContactDalegate!
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var relation:UILabel!
    @IBOutlet weak var mobile:UILabel!
    @IBOutlet weak var status:UISwitch!
    
    @IBOutlet weak var editbutton:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func editBTn(_ sender: Any) {
       delegate?.edit(cell: self)
    }
    @IBAction func deleteBTn(_ sender: Any) {
       delegate?.delete(cell: self)
    }
    @IBAction func trackBTn(_ sender: Any) {
       delegate.track(cell: self)
    }
    
}
