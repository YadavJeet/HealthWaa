//
//  Singleton.swift
//  Signature
//
//  Created by ISKPRO on 6/19/17.
//  Copyright © 2017 ISKPRO. All rights reserved.
//

import UIKit

class Singleton: NSObject {
    //MARK: Shared Instance
    
    static let sharedInstance : Singleton = {
        let instance = Singleton(array: [])
      return instance
    }()
    
//MARK: Local Variable

    var moblieNumber: NSString!
    var mobnumber: NSString!
    var emailid: NSString!
    var SignupPassword: NSString!
    var fname: NSString!
    var lname: NSString!
    var locationoff: NSString!
    var cat_index: NSString!
    var isCheck: Bool?
    var isCheckVideo: Bool?
    var videoLink: URL!
    
    
    
    
   // var allDataDic = NSDictionary ()
    var UserDetail = NSMutableDictionary()
    var facebookFriend = NSArray ()
    var isfriendreques: Bool?
   
    
    
    //MARK: Init
    
    init( array : [Any]) {
          }
}
