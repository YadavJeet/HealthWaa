//
//  FinallyMeetVC.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 1/4/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit

class FinallyMeetVC: UIViewController {

    @IBOutlet weak var emojiLBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let str : String = "Finally we met 😊"
        emojiLBL.text = str
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
