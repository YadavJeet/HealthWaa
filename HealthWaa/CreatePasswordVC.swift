//
//  CreatePasswordVC.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 1/6/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit
import Alamofire

class CreatePasswordVC: UIViewController {

    let singletonObj = Singleton.sharedInstance
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        password.layer.addBorder(edge: UIRectEdge.bottom, color: .lightGray, thickness: 1.5)
        repassword.layer.addBorder(edge: UIRectEdge.bottom, color: .lightGray, thickness: 1.5)
        print(singletonObj.UserDetail)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func nextBTN(_ sender: Any) {
        
        if (password.text?.count)!<=0 {
            GlobleClass.ShowAlert( "Please enter your password",on: "Error!", from: self)
        }
        else if(password.text?.count)!<6 {
            GlobleClass.ShowAlert("password must content 6 characters", on: "Error!", from: self)
        }
        else if password.text != repassword.text{
            GlobleClass.ShowAlert( "Confirm password does not match", on: "Error!", from: self)
        }
        else
        {
            let Server = ServerController ()
            let params:[String:Any] = [
                "srName":singletonObj.UserDetail["sname"] as! String ,
                "firstName":singletonObj.UserDetail["fname"] as! String,
                "lastName":singletonObj.UserDetail["lname"] as! String,
                "dob":singletonObj.UserDetail["dob"] as! String,
                "tob":singletonObj.UserDetail["time"] as! String,
                "sex":singletonObj.UserDetail["gender"] as! String,
                "mobile":singletonObj.UserDetail["phone"] as! String,
                "countryId":singletonObj.UserDetail["countryId"] as! String,
                "uniqueId":singletonObj.UserDetail["UID"] as! String,
                "password":password.text!,
                "email":singletonObj.UserDetail["email"] as! String
                
            ]
            
            print("Params \(params)")
            
            Server.PostDataWithParam(Params: params, WithApiName: ServerController.HW_registration, isNeedLoader: true, WithBlock:{(ServerResponse:DataResponse<Any>?,  error: NSError?) in
                
                print("response data:\( ServerResponse!.result.value ?? "")")
                let result = ServerResponse?.result.value as? NSDictionary
                let UserDetail = result?["detail"] as? NSDictionary
                if UserDetail != nil {
                    UserDefaults.standard.set("yes", forKey: "userID")
            
                let tab = self.storyboard?.instantiateViewController(withIdentifier:  "HomeVC") as! HomeVC
                    self.navigationController?.pushViewController(tab, animated: true)
                     GlobleClass.ShowAlert("User Registration Successfully", on: "Alert!", from: self)
                }else{
                    let Error = ServerResponse?.result.value as? NSDictionary
                    let errorMessage = Error!["message"] as! String
                    GlobleClass.ShowAlert(errorMessage, on: "Alert!", from: self)
                }
              
            } )

        }
        
    }

   

}
