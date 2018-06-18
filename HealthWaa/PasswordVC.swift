//
//  PasswordVC.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 1/6/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit
import Alamofire
class PasswordVC: UIViewController {
@IBOutlet weak var password: UITextField!
    var adharnumber = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        password.layer.addBorder(edge: UIRectEdge.bottom, color: .lightGray, thickness: 1.5)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func nextBTN(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            if (password.text?.count)!<=0 {
                  GlobleClass .ShowAlert("Please enter password ", on: "Error!", from: self)
            }else{
                self.login()
            }
            case 2:
            print("hello")
        default:
            break
        }
        
    }
    
    func login() {
        
        let Server = ServerController ()
        let params:[String:Any] = [
            "userName":adharnumber ,
            "password":password.text!,
        ]
        
        print("Params \(params)")
        
        Server.PostDataWithParam(Params: params, WithApiName: ServerController.HW_login, isNeedLoader: true, WithBlock:{(ServerResponse:DataResponse<Any>?,  error: NSError?) in
            
            print("response data:\( ServerResponse!.result.value ?? "")")
            let result = ServerResponse?.result.value as! [String:Any]
            if result["code"] as! Bool == false {
            let UserDetail = result["detail"] as! [String:Any]
            UserDefaults.standard.set("yes", forKey: "userID")
            UserDefaults.standard.set(UserDetail["uniqueId"], forKey: "uniqueId")
            let tab = self.storyboard?.instantiateViewController(withIdentifier:  "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(tab, animated: true)
                 GlobleClass.ShowAlert("Login Successfully", on: "Alert!", from: self)
            }else{
                
                GlobleClass.ShowAlert("Invalid Login credential", on: "Alert!", from: self)
            }
        } )

    }

}
