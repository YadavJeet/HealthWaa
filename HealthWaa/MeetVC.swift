//
//  MeetVC.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 1/3/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit

class MeetVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func yesMeet(_ sender: Any)
    {
        let tab = self.storyboard?.instantiateViewController(withIdentifier:  "SelectCountryVC") as! SelectCountryVC
        tab.yesMeet = "yesmeet"
        self.navigationController?.pushViewController(tab, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
