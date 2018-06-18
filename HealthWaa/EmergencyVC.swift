//
//  EmergencyVC.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 5/26/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import SDWebImage

class EmergencyVC: UIViewController,EmergencyContactDalegate {
   
    
 @IBOutlet weak var TV: UITableView!
 @IBOutlet weak var AddEmergencyPopView: UIView!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var relationBtn: UIButton!
    @IBOutlet weak var Popstatus:UISwitch!
    
    @IBOutlet weak var editEmergency: UILabel!
    @IBOutlet weak var addbutton: UIButton!
    
    var isPopstatus:String?
    
    var userid:String?
    var uniqueID:String?
    
    var GetEmergency  = [EmergencyUser]()
    
    //MARK: - DropDown's
      let relationDropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.relationDropDown
        ]
    }()
    @IBAction func chooserelationBtn(_ sender: AnyObject) {
        relationDropDown.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("PopUp Status: \(Popstatus.isOn)")
        
        
        let nib = UINib(nibName: "EmergencyContactCell", bundle: Bundle.main)
        TV.register(nib, forCellReuseIdentifier: "emrcell")
    
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.AddEmergencyPopView.addGestureRecognizer(gesture)
        self.getEmergancyList()
        setupDropDowns()
        // Do any additional setup after loading the view.
      
           isPopstatus = "0"
        if Popstatus.isOn == true{
           isPopstatus = "1"
        }
    }
    
    
    @IBAction func PopIStatus(_ sender: Any) {
       
        if Popstatus.isOn == true{
            isPopstatus = "1"
        }else{
             isPopstatus = "0"
        }
    }
    
    func getEmergancyList() {
        let Server = ServerController ()
        let params:Parameters = ["uniqueId":UserDefaults.standard.value(forKey: "uniqueId") as! String]
        Server.PostDataWithParam(Params: params, WithApiName: ServerController.HW_getEmergencyMembers, isNeedLoader: true, WithBlock:{(ServerResponse:DataResponse<Any>?,  error: NSError?) in
            
            print("response data:\( ServerResponse!.result.value ?? "")")
            let res = ServerResponse!.result.value as! [String:Any]
            if res["code"] as! Bool == false {
                let detailUser = res["detail"] as! [Any]
                self.GetEmergency = [EmergencyUser]()
                for detail in detailUser.reversed() {
                    let  i  = detail as! [String: Any]
                    let hModel  = EmergencyUser()
                    hModel.activeStatus = i["activeStatus"] as? String
                    hModel.createdAt = i["createdAt"] as? String
                    hModel.id = i["id"] as? String
                    hModel.isOnOff = i["isOnOff"] as? String
                    hModel.mobileNo = i["mobileNo"] as? String
                    hModel.name = i["name"] as? String
                    hModel.relationId = i["relationId"] as? String
                    hModel.relationName = i["relationName"] as? String
                    hModel.uniqueId = i["uniqueId"] as? String
                    hModel.uniqueIdStatus = i["uniqueIdStatus"] as? String
                    hModel.updatedAt = i["updatedAt"] as? String
                    self.GetEmergency.append(hModel)
                }
                self.TV.reloadData()
            }
            
        })
    }
    
    
    func delete(cell: EmergencyContactCell) {
        guard let indexPath = self.TV.indexPath(for: cell) else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }
        
        //  Do whatever you need to do with the indexPath
        print("Button tapped on row \(indexPath.row)")
        let hxModel = self.GetEmergency[indexPath.row]
        self.deleteEmergencyMember(userid: hxModel.id!)
    }
    
    func edit(cell: EmergencyContactCell) {
        
        guard let indexPath = self.TV.indexPath(for: cell) else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }
       
        //  Do whatever you need to do with the indexPath
        print("Button tapped on row \(indexPath.row)")
        let hxModel = self.GetEmergency[indexPath.row]
        
        if cell.editbutton.isSelected == false {
            print("ON")
            AddEmergencyPopView.isHidden = false
            self.editEmergency.text = "Edit Emergency Contact"
            self.addbutton.setTitle("edit", for: .normal)
            self.phone.text = hxModel.mobileNo
            self.relationBtn.setTitle(hxModel.relationName, for: .normal)
            self.name.text = hxModel.name
            let status = hxModel.isOnOff
            if status == "1" {
                 self.Popstatus.isOn = true
            }else{
                self.Popstatus.isOn = false
            }
            self.relationBtn.setTitleColor(self.name.textColor, for: .normal)
            
            userid = hxModel.id
            uniqueID = hxModel.uniqueId
            
        }else{
            print("OFF")
            AddEmergencyPopView.isHidden = true
        }
    }
    
    func track(cell: EmergencyContactCell) {
        
    }
    
    func setupDropDowns() {
        setupChooserelationDropDown()
        
    }
    func setupChooserelationDropDown() {
        relationDropDown.anchorView = relationBtn
        
        // Will set a custom with instead of anchor view width
        relationDropDown.width = relationBtn.frame.size.width
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        relationDropDown.bottomOffset = CGPoint(x: 0, y: relationBtn.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        relationDropDown.dataSource = [
            "Brother",
            "Sister",
            "Father",
            "Mother",
            "Son",
            "Daughter",
            "Doctor",
            "Wife",
            "Other"
        ]
        
        // Action triggered on selection
        relationDropDown.selectionAction = { [weak self] (index, item) in
            self?.relationBtn.setTitle(item, for: .normal)
            self?.relationBtn.setTitleColor(self?.name.textColor, for: .normal)
        }
    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        AddEmergencyPopView.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func BackBTn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }

    @IBAction func AddBtn(_ sender: UIButton) {
        if sender.isSelected == false {
            print("ON")
            AddEmergencyPopView.isHidden = false
            self.editEmergency.text = "Emergency Contact"
            self.addbutton.setTitle("add", for: .normal)
            self.Popstatus.isOn = false
            self.phone.text = ""
            self.relationBtn.setTitle("Brother", for: .normal)
            self.relationBtn.setTitleColor(sender.titleLabel?.textColor, for: .normal)
            self.name.text = ""
        }else{
            print("OFF")
            AddEmergencyPopView.isHidden = true
        }
    }
    
    @IBAction func AddContactBtn(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "edit" {
            print("edit")
            EditComntact(userId:userid!, uniqueID: uniqueID!)
        }else{
            AddComntact(userId: UserDefaults.standard.value(forKey: "uniqueId") as! String)
        }
    }
    
    func AddComntact(userId:String) {
        if (name.text?.count)!<=0 {}
        else if (phone.text?.count)!<=0 {}
        else{
            let Server = ServerController ()
            let params:Parameters = ["uniqueId":userId,"relationName":relationBtn.titleLabel!.text!,"name":name.text!,"mobileNo":phone.text!,"isOnOff":isPopstatus!]
            print("Param: \(params)")
            
            Server.PostDataWithParam(Params: params, WithApiName: ServerController.HW_addEmergencyMembers, isNeedLoader: true, WithBlock:{(ServerResponse:DataResponse<Any>?,  error: NSError?) in
                
                print("response data:\( ServerResponse!.result.value ?? "")")
                let res = ServerResponse!.result.value as! [String:Any]
                if res["code"] as! Bool == false {
                    self.AddEmergencyPopView.isHidden = true
                    self.name.text = nil
                    self.phone.text = nil
                    self.Popstatus.isOn = false
                    self.getEmergancyList()
                }
            })
        }
    }
    
    func EditComntact(userId:String,uniqueID:String) {
        if (name.text?.count)!<=0 {}
        else if (phone.text?.count)!<=0 {}
        else{
            let Server = ServerController ()
            let params:Parameters = ["uniqueId":uniqueID,"relationName":relationBtn.titleLabel!.text!,"name":name.text!,"mobileNo":phone.text!,"isOnOff":isPopstatus!,"id":userId]
            print("Param: \(params)")
            
            Server.PostDataWithParam(Params: params, WithApiName: ServerController.HW_editEmergencyMembers, isNeedLoader: true, WithBlock:{(ServerResponse:DataResponse<Any>?,  error: NSError?) in
                
                print("response data:\( ServerResponse!.result.value ?? "")")
                let res = ServerResponse!.result.value as! [String:Any]
                if res["code"] as! Bool == false {
                    self.AddEmergencyPopView.isHidden = true
                    self.name.text = nil
                    self.phone.text = nil
                    self.Popstatus.isOn = false
                    self.getEmergancyList()
                }
            })
        }
    }
    
    func deleteEmergencyMember(userid:String) {
        let Server = ServerController ()
        let params:Parameters = ["id":userid]
        
        Server.PostDataWithParam(Params: params, WithApiName: ServerController.HW_deleteEmergencyMember, isNeedLoader: true, WithBlock:{(ServerResponse:DataResponse<Any>?,  error: NSError?) in
            
            print("response data:\( ServerResponse!.result.value ?? "")")
             self.getEmergancyList()
        })
    }
}

extension EmergencyVC: UITableViewDelegate,UITableViewDataSource {
    
    // MARK:- UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GetEmergency.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let hxModel = self.GetEmergency[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "emrcell") as! EmergencyContactCell
        cell.name.text = hxModel.name?.capitalized
        cell.relation.text = hxModel.relationName
        cell.mobile.text = hxModel.mobileNo
        cell.delegate = self
        let status = hxModel.isOnOff
        if status == "1" {
            cell.status.isOn = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

