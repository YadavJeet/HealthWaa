//
//  NumberVC.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 1/5/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit

class NumberVC: UIViewController {

    let singletonObj = Singleton.sharedInstance
    @IBOutlet weak var phoneNumberFld: UITextField!
    @IBOutlet weak var countryCodeLBL: UILabel!
    @IBOutlet weak var UIDFld: UITextField!
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var mdi: UILabel!
    @IBOutlet weak var hdiLBL: UILabel!
    @IBOutlet weak var poputalionLBL: UILabel!
    var countryDic = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(countryDic)
        self.GetData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func NextBTN(_ sender: Any) {
        
        if (UIDFld.text?.count)!<=0{
            GlobleClass.ShowAlert("Please enter \(countryDic["uniqueIdName"] as? String ?? "")", on: "Alert!", from: self)
        }
         else if (phoneNumberFld.text?.count)!<=0 {
            GlobleClass.ShowAlert("Please enter phone number", on: "Alert!", from: self)
        }else  {
            let number = "\(countryCodeLBL.text!)\( phoneNumberFld.text!)"
            
            singletonObj.UserDetail.setValue(number, forKey: "phone")
            singletonObj.UserDetail.setValue(UIDFld.text!, forKey: "UID")
            
            let tab = self.storyboard?.instantiateViewController(withIdentifier:  "AgeVC") as! AgeVC
            self.navigationController?.pushViewController(tab, animated: true)
        }
        
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    func GetData()  {
        UIDFld.layer.addBorder(edge: UIRectEdge.bottom, color: .lightGray, thickness: 1.5)
        phoneNumberFld.layer.addBorder(edge: UIRectEdge.bottom, color: .lightGray, thickness: 1.5)
        UIDFld.placeholder = countryDic["uniqueIdName"] as? String
        countryCodeLBL.text = countryDic["code"] as? String
        poputalionLBL.text = countryDic["population"] as? String
        hdiLBL.text = countryDic["hdi"] as? String
        mdi.text = countryDic["mdi"] as? String
        let image = countryDic["image"] as? String
        let url = NSURL(string: "http://www.dworldhealth.com/includes/data/countries/\(image!)")!
        logoImage.sd_setImage(with: url as URL!, placeholderImage: nil);
        singletonObj.UserDetail.setValue(countryDic["id"] as? String, forKey: "countryId")
        
    }
   
}
