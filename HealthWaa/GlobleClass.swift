//
//  GlobleClass.swift
//  HashTagSwift
//
//  Created by Harendra Sharma on 23/02/17.
//  Copyright © 2017 Harendra Sharma. All rights reserved.
//

import UIKit

class GlobleClass: NSObject {
    
    
    
   class func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }   
    

   class func getRandomColor() -> UIColor{
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    
    
    class func ShowAlert(_ message: String, on title: String, from sender: UIViewController) -> Void {
        
        let actionSheetController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        sender.present(actionSheetController, animated: true, completion: nil)
        
        
        
        //    return "Hello \(person), today is \(day)."
    }
    
      
    
    
    
    
    
}

