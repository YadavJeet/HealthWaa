//
//  SelectCountryVC.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 1/4/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class SelectCountryVC: UIViewController {
    @IBOutlet weak var SelectCountryFld: UITextField!
    @IBOutlet weak var CV: UICollectionView!
     var CountryArr = NSArray()
    let singletonObj = Singleton.sharedInstance
    var yesMeet = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(singletonObj.UserDetail)
     SelectCountryFld.layer.addBorder(edge: UIRectEdge.bottom, color: .lightGray, thickness: 1.5)
        
        let Server = ServerController ()
        
        Server.GetRequestWithUrl(Url: ServerController.HW_getCountryList, isNeedLoader: true, WithBlock: { ( ServerResponse:DataResponse<Any>?, error: NSError?) in
            
            print("result\( ServerResponse?.result.value! ?? "")")
            let CountryDic = ServerResponse?.result.value as! NSDictionary
            self.CountryArr = CountryDic.value(forKey: "detail") as! NSArray
             self.CV.dataSource = self
             self.CV.delegate = self
             self.CV.reloadData()
            
        })
    }

    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension SelectCountryVC: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CountryArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
    
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CountryCell
        let countryDetail = CountryArr.object(at: indexPath.item) as! NSDictionary
        cell.cuntoryName?.text = countryDetail["name"] as? String
        let image = countryDetail["image"] as? String
        let url = NSURL(string: "http://www.dworldhealth.com/includes/data/countries/\(image!)")!
        print(url)
        cell.countryImage.sd_setImage(with: url as URL!, placeholderImage: nil);
        
    
        return cell
    }
    
    
}

extension SelectCountryVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.CV.frame.size.width)/3-15, height: (self.CV.frame.size.width)/3-15);
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        if yesMeet == "yesmeet" {
            
            let countryDetail = CountryArr.object(at: indexPath.item) as! NSDictionary
            let tab = self.storyboard?.instantiateViewController(withIdentifier:  "AdharVC") as! AdharVC
            tab.countryDic = countryDetail
            self.navigationController?.pushViewController(tab, animated: true)
            
        }else
        {
            
        let countryDetail = CountryArr.object(at: indexPath.item) as! NSDictionary
        let tab = self.storyboard?.instantiateViewController(withIdentifier:  "NumberVC") as! NumberVC
        tab.countryDic = countryDetail
        self.navigationController?.pushViewController(tab, animated: true)
    }
   }
}

class CountryCell: UICollectionViewCell {
    @IBOutlet weak var cuntoryName: UILabel!
    
    @IBOutlet weak var countryImage: UIImageView!
}

