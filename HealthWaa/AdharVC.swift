//
//  AdharVC.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 1/6/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit

class AdharVC: UIViewController {
    let singletonObj = Singleton.sharedInstance
    @IBOutlet weak var UIDFld: UITextField!
    @IBOutlet weak var logoImage: UIImageView!
    var countryDic = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIDFld.layer.addBorder(edge: UIRectEdge.bottom, color: .lightGray, thickness: 1.5)
        UIDFld.placeholder = countryDic["uniqueIdName"] as? String
        let image = countryDic["image"] as? String
        let url = NSURL(string: "http://www.dworldhealth.com/includes/data/countries/\(image!)")!
        logoImage.sd_setImage(with: url as URL!, placeholderImage: nil);

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func nextBTN(_ sender: Any) {
       if (UIDFld.text?.count)!<=0 {
            GlobleClass .ShowAlert("Please enter Register \(countryDic["uniqueIdName"] as! String) ", on: "Error!", from: self)
       }else{
        let tab = self.storyboard?.instantiateViewController(withIdentifier:  "PasswordVC") as! PasswordVC
        tab.adharnumber = self.UIDFld.text!
        self.navigationController?.pushViewController(tab, animated: true)
    }
    }
    

  

}
