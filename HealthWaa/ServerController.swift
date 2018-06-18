
//  ServerController.swift
//  SocialBee
//
//  Created by Jitendra Yadav on 8/10/17.
//  Copyright © 2017 Harendra Sharma. All rights reserved.
//



import UIKit
import Alamofire
import SVProgressHUD



typealias CompletionBlock = (_ ServerResponse:DataResponse<Any>?, _ error: NSError?)->Void


class ServerController: NSObject {
    
    // MARK: List of APIs
     let BaseURL = "http://www.dworldhealth.com/api/"
    
     static let HW_getCountryList = "getCountryList"
     static let HW_registration = "registration"
     static let HW_login = "login"
     static let HW_getEmergencyMembers = "getEmergencyMembers"
     static let HW_addEmergencyMembers = "addEmergencyMember"
     static let HW_getFamilyList = "getFamilyMember"
     static let HW_editEmergencyMembers = "updateEmergencyMember"
     static let HW_deleteEmergencyMember = "deleteEmergencyMember"
     static let HW_addFamilyMember = "addFamilyMember"
    
    
    
    // MARK: Public method implementations
    
    
    /********************************
     Method: PostDataWithParam is the method name, Call this method.
     Params: Dictionary<String, Any>, pass dictionary and cannot be nil
     apiName: Server url/End point
     loader: Bool value for showing activity loader while getting data from server
     block: Will reture data for success and error if request is not satisfield.
     *********************************/
    
    
    public func PostDataWithParam(Params: Dictionary<String, Any>, WithApiName apiName: String, isNeedLoader loader: Bool, WithBlock block: @escaping CompletionBlock) -> Void {
        if loader {
            SVProgressHUD.show(withStatus: "Please wait...")
        }

        let URLAPI = "\(BaseURL)\(apiName)"
        print("API: \(URLAPI)")
        let headers = ["Content-Type": "application/json"]
        
        Alamofire.request(URLAPI, method: .post, parameters: (Params ), encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch(response.result) {
                
            case .success(_):
                if let data = response.result.value{
                    
                    block(response, nil)
                    
                    print("Server Response: \(data)")
                }
                break
                
            case .failure(_):
                print("Server Error: \(response.result.error ?? "" as! Error)")
                
                // block(nil, response.result.error as NSError?)
                SVProgressHUD.dismiss ()
                break
                
            }
            SVProgressHUD.dismiss ()
            
        }
    }
    
  
    /********************************
     Method: GetRequestWithUrl is the method name, Call this method.
     Url: Server url/End point
     loader: Bool value for showing activity loader while getting data from server
     block: Will reture data for success and error if request is not satisfield.
     *********************************/
    
    
    public func GetRequestWithUrl(Url: String, isNeedLoader loader: Bool, WithBlock block: @escaping CompletionBlock) -> Void {
        
        if loader {
            SVProgressHUD.show(withStatus: "wait")
        }
        let URLAPI = "\(BaseURL)\(Url)"
        print("API: \(URLAPI)")
        Alamofire.request(URLAPI).responseJSON { response in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    
                    block(response, nil)
                    
                    print("Server Response: \(data)")
                }
                break
                
            case .failure(_):
                print("Server Error: \(response.result.error ?? "" as! Error)")
                //                block(nil, response.result.error as NSError?)
                SVProgressHUD.dismiss ()
                break
                
            }
            SVProgressHUD.dismiss ()
        }
    }
    
    
//    public func GetRequestWithUrlwithParam(Url: String,Param: Dictionary<String, Any>, isNeedLoader loader: Bool, WithBlock block: @escaping CompletionBlock) -> Void {
//
//        if loader {
//            SVProgressHUD.show(withStatus: "wait")
//        }
//        let headers = ["Content-Type": "application/json"]
//        let URLAPI = "\(BaseURL)\(Url)"
//
//        Alamofire.request(URLAPI, method: .get, parameters: Param, encoding: JSONEncoding.default, headers:headers)
//            .responseJSON { response in
//
//                switch(response.result) {
//                case .success(_):
//                    if let data = response.result.value{
//                        block(response, nil)
//                        print("Server Response: \(data)")
//                    }
//                    break
//
//                case .failure(_):
//                    print("Server Error: \(response.result.error ?? "" as! Error)")
//                    // block(nil, response.result.error as NSError?)
//                    SVProgressHUD.dismiss ()
//                    break
//
//                }
//                SVProgressHUD.dismiss ()
//        }
//    }
    
}
