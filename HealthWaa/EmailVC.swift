//
//  EmailVC.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 1/5/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit

class EmailVC: UIViewController,UITextFieldDelegate {
     let singletonObj = Singleton.sharedInstance
    
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var emailaddress: UITextField!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var tabView: UIView!
    var gender = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         gender = singletonObj.UserDetail["gender"] as! String
        if gender == "1" {
             btn1.setTitle("Mrs.", for: .normal)
        }
         tabView.isHidden = true
         emailaddress.layer.addBorder(edge: UIRectEdge.bottom, color: .lightGray, thickness: 1.5)
         lname.layer.addBorder(edge: UIRectEdge.bottom, color: .lightGray, thickness: 1.5)
         fname.layer.addBorder(edge: UIRectEdge.bottom, color: .lightGray, thickness: 1.5)
         btn1.addTarget(self, action: #selector(Tapped), for: .touchUpInside)
      
    }
    @objc func Tapped() {
        tabView.isHidden = false
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func nextBTN(_ sender: Any) {
        if (fname.text?.count)!<=0 {
            GlobleClass .ShowAlert("Please enter first name", on: "Error!", from: self)
        }
        else if (lname.text?.count)!<=0 {
            GlobleClass .ShowAlert("Please enter last name", on: "Error!", from: self)
        }
        else if (emailaddress.text?.count)!<=0 {
            
        GlobleClass .ShowAlert("Please enter email address", on: "Error!", from: self)
            
        }else if (!GlobleClass.isValidEmail(testStr: emailaddress.text!))
        {
            GlobleClass .ShowAlert("Please enter correct email address", on: "Error!", from: self)
        }else{
        
        singletonObj.UserDetail.setValue(fname.text!, forKey: "fname")
        singletonObj.UserDetail.setValue(lname.text!, forKey: "lname")
        singletonObj.UserDetail.setValue(emailaddress.text!, forKey: "email")
        singletonObj.UserDetail.setValue(btn1.titleLabel?.text!, forKey: "sname")
        let tab = self.storyboard?.instantiateViewController(withIdentifier:  "CreatePasswordVC") as! CreatePasswordVC
        self.navigationController?.pushViewController(tab, animated: true)
        
        }
    }
    
    @IBAction func btnTab(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            btn1.setTitle("Mr.", for: .normal)
            tabView.isHidden = true
        case 2:
            btn1.setTitle("Mrs.", for: .normal)
            tabView.isHidden = true
        default:
            break
        }
    }

}
