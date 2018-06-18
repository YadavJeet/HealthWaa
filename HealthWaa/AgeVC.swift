//
//  AgeVC.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 1/5/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit

class AgeVC: UIViewController,UITextFieldDelegate{

    let singletonObj = Singleton.sharedInstance
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var dob: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dob.delegate = self
        self.time.delegate = self
        
         dob.layer.addBorder(edge: UIRectEdge.bottom, color: .lightGray, thickness: 1.5)
         time.layer.addBorder(edge: UIRectEdge.bottom, color: .lightGray, thickness: 1.5)
        // Do any additional setup after loading the view.
  
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        dob.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        
        let datePickerView1 = UIDatePicker()
        datePickerView1.datePickerMode = .time
        time.inputView = datePickerView1
        datePickerView1.addTarget(self, action: #selector(handleDatePicker1(sender:)), for: .valueChanged)
    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dob.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func handleDatePicker1(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        time.text = dateFormatter.string(from: sender.date)
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }

    @IBAction func nextBTN(_ sender: Any) {
        if (dob.text?.count)!<=0 {
            GlobleClass .ShowAlert("Please select your Date of Birth", on: "Error!", from: self)
        }
        else if (time.text?.count)!<=0 {
            GlobleClass .ShowAlert("Please select your Time of Birth", on: "Error!", from: self)
        }else{
        
       singletonObj.UserDetail.setValue(dob.text!, forKey: "dob")
       singletonObj.UserDetail.setValue(time.text!, forKey: "time")
       
        let tab = self.storyboard?.instantiateViewController(withIdentifier:  "EmailVC") as! EmailVC
        self.navigationController?.pushViewController(tab, animated: true)
        }
    }
    
}
