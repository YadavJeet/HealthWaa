//
//  FamilyVC.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 5/26/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit
import JJFloatingActionButton
import DropDown
import Alamofire
import SDWebImage

class FamilyVC: UIViewController {
fileprivate let actionButton = JJFloatingActionButton()
    
    @IBOutlet weak var TV: UITableView!
    var userImage:UIImage? = nil
    var GetFamily = [familyUser]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.treeButton()
        self.getfamilyList()
        let nib = UINib(nibName: "FamilyCell", bundle: Bundle.main)
        TV.register(nib, forCellReuseIdentifier: "family")
        TV.estimatedRowHeight = 145
        TV.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    
    func getfamilyList() {
        let Server = ServerController ()
        let params:Parameters = ["uniqueId":UserDefaults.standard.value(forKey: "uniqueId") as! String]
        Server.PostDataWithParam(Params: params, WithApiName: ServerController.HW_getFamilyList, isNeedLoader: true, WithBlock:{(ServerResponse:DataResponse<Any>?,  error: NSError?) in
            
            print("response data:\( ServerResponse!.result.value ?? "")")
            let res = ServerResponse!.result.value as! [String:Any]
            if res["code"] as! Bool == false {
              let detailUser = res["detail"] as! [Any]
                self.GetFamily = [familyUser]()
                for detail in detailUser {
                    let  i  = detail as! [String: Any]
                    let hModel  = familyUser()
                    hModel.birthPlaceLatLong = i["birthPlaceLatLong"] as? String
                    hModel.birthPlaceName = i["birthPlaceName"] as? String
                    hModel.bodyTemp = i["bodyTemp"] as? String
                    hModel.bodyTempType = i["bodyTempType"] as? String
                    hModel.breastfeeding = i["breastfeeding"] as? String
                    hModel.createdAt = i["createdAt"] as? String
                    hModel.dob = i["dob"] as? String
                    hModel.height = i["height"] as? String
                    hModel.heightType = i["heightType"] as? String
                    hModel.images = i["image"] as? String
                    hModel.operationType = i["operationType"] as? String
                    hModel.paediaticName = i["paediaticName"] as? String
                    hModel.placeTemp = i["placeTemp"] as? String
                    hModel.id = i["id"] as? Int
                    hModel.placeTempType = i["placeTempType"] as? String
                    hModel.relation = i["relation"] as? String
                    hModel.name = i["name"] as? String
                    hModel.sex = i["sex"] as? String
                    hModel.status = i["status"] as? String
                    hModel.time = i["time"] as? String
                    hModel.trackeId = i["trackeId"] as? String
                    hModel.uniqueId = i["uniqueId"] as? String
                    hModel.updateAt = i["updateAt"] as? String
                    hModel.weight = i["weight"] as? String
                    hModel.weightType = i["weightType"] as? String
                    self.GetFamily.append(hModel)
                }
                self.TV.reloadData()
            }
        })
    }
    
    func treeButton() {
        actionButton.itemAnimationConfiguration = .circularSlideIn(withRadius: 120)
        actionButton.buttonAnimationConfiguration = .rotation(toAngle: .pi * 3 / 4)
        actionButton.buttonAnimationConfiguration.opening.duration = 0.8
        actionButton.buttonAnimationConfiguration.closing.duration = 0.6
        
        actionButton.addItem(image: #imageLiteral(resourceName: "child")) { item in

            self.userImage = #imageLiteral(resourceName: "ic_child")
            self.performSegue(withIdentifier: "addFM", sender: self)
        }
        
        actionButton.addItem(image: #imageLiteral(resourceName: "brother")) { item in
             self.userImage = #imageLiteral(resourceName: "ic_brother.png")
             self.performSegue(withIdentifier: "addFM", sender: self)
        }
        
        actionButton.addItem(image: #imageLiteral(resourceName: "sister")) { item in
            self.userImage = #imageLiteral(resourceName: "ic_sister")
            self.performSegue(withIdentifier: "addFM", sender: self)
        }
        
        actionButton.addItem(image: #imageLiteral(resourceName: "father")) { item in
             self.userImage = #imageLiteral(resourceName: "ic_father")
             self.performSegue(withIdentifier: "addFM", sender: self)
        }
        actionButton.addItem(image: #imageLiteral(resourceName: "mother")) { item in
             self.userImage = #imageLiteral(resourceName: "ic_mother")
             self.performSegue(withIdentifier: "addFM", sender: self)
        }
        actionButton.display(inViewController: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackBTn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addFM"{
            let vc = segue.destination as! AddFamityDetailVC
            vc.userImage = userImage

            //Data has to be a variable name in your RandomViewController
        }
    }

}

extension FamilyVC: UITableViewDelegate,UITableViewDataSource {
    
    // MARK:- UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GetFamily.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let htModel = self.GetFamily[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "family") as! FamilyCell
        cell.name.text = htModel.name?.capitalized
        cell.dob.text = htModel.dob
        cell.birthPlaceName.text = htModel.birthPlaceName
        cell.operationType.text = htModel.operationType
        
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
