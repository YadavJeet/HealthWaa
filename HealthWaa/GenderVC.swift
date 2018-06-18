//
//  GenderVC.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 1/4/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit

class GenderVC: UIViewController {
    let singletonObj = Singleton.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func GenderBTN(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.performSegue(withIdentifier: "gen", sender: self)
            singletonObj.UserDetail.setValue("0", forKey: "gender")
        case 2:
            self.performSegue(withIdentifier: "gen", sender: self)
             singletonObj.UserDetail.setValue("1", forKey: "gender")
        case 3:
            self.performSegue(withIdentifier: "gen", sender: self)
             singletonObj.UserDetail.setValue("2", forKey: "gender")
        default:
            break
        }
    }

}
