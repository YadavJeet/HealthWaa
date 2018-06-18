//
//  AddFamityDetailVC.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 5/30/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import SDWebImage

class AddFamityDetailVC: UIViewController {

    @IBOutlet weak var userimage:UIImageView!
    @IBOutlet weak var male:UIButton!
    @IBOutlet weak var female:UIButton!
    @IBOutlet weak var DobTF:UITextField!
    @IBOutlet weak var TimeTF:UITextField!
    @IBOutlet weak var NameTF:UITextField!
    @IBOutlet weak var HospitalTF:UITextField!
    @IBOutlet weak var paediatricTF:UITextField!
    
    var time_picker  = UIDatePicker()
    var Date_picker  = UIDatePicker()
    var userImage:UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
      self.SetDate_timePicker()
      userimage.image = userImage

    
        // Do any additional setup after loading the view.
    }
    
    // MARK: Date_Time Picker
    func SetDate_timePicker() {
        // MARK: Time Picker
        self.time_picker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.time_picker.backgroundColor = UIColor.white
        self.time_picker.datePickerMode = UIDatePickerMode.time
        self.time_picker.timeZone = NSTimeZone.local
        self.time_picker.locale = Locale(identifier: "en_US_POSIX")
        TimeTF.inputView = self.time_picker
        self.time_picker.addTarget(self, action: #selector(AddFamityDetailVC.timePickerValueChanged(_:)), for: .valueChanged)
        
        // MARK: Date Picker
        self.Date_picker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.Date_picker.backgroundColor = UIColor.white
        self.Date_picker.datePickerMode = UIDatePickerMode.date
        self.Date_picker.timeZone = NSTimeZone.local
        self.Date_picker.locale = Locale(identifier: "en_US_POSIX")
        Date_picker.maximumDate = Date()
        DobTF.inputView = self.Date_picker
        self.Date_picker.addTarget(self, action: #selector(AddFamityDetailVC.datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func timePickerValueChanged(_ sender: UIDatePicker){
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        // Set time format
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        // Apply time format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        print("Selected value \(selectedDate)")
        TimeTF.text = selectedDate
        
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        // Set date format
        dateFormatter.dateFormat = "MM/dd/YYYY"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        print("Selected value \(selectedDate)")
        DobTF.text = selectedDate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: Back Action
    @IBAction func BackBTn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    // MARK: Select gender
    @IBAction func SelectGenderBTn(_ sender: UIButton) {
        switch sender.tag {
        case 101:
            female.backgroundColor = UIColor(red: 225/255, green: 28/255, blue: 98/255, alpha: 1)
            male.backgroundColor = UIColor.white
        case 102:
            male.backgroundColor = UIColor(red: 225/255, green: 28/255, blue: 98/255, alpha: 1)
            female.backgroundColor = UIColor.white
        default:
            break
        }
    }
    // MARK: Submit action
    @IBAction func SubmitBTn(_ sender: UIButton) {
      
        let Server = ServerController ()
        let params:Parameters = [        "uniqueId":"1",
                                         "memberUniqueId":"1",
                                         "memberUniqueStatus":"1",
                                         "relation":"1",
                                         "activeStatus":"1",
                                         "createdAt":"1",
                                         "updateAt":"1",
                                         "id":"1",
                                         "name":"Jitendra",
                                         "dob":"1",
                                         "image":"1",
                                         "birthPlaceLatLong":"1",
                                         "birthPlaceName":"1",
                                         "paediaticName":"1",
                                         "operationType":"1",
                                         "height":"1",
                                         "heightType":"1",
                                         "weight":"1",
                                         "weightType":"1",
                                         "bodyTemp":"1",
                                         "bodyTempType":"1",
                                         "placeTemp":"1",
                                         "placeTempType":"1",
                                         "breastfeeding":"1"
        ]
        
        Server.PostDataWithParam(Params: params, WithApiName: ServerController.HW_addFamilyMember, isNeedLoader: true, WithBlock:{(ServerResponse:DataResponse<Any>?,  error: NSError?) in
            
            print("response data:\( ServerResponse!.result.value ?? "")")
        })
    }
    
}
