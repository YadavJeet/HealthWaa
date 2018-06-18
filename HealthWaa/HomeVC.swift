//
//  HomeVC.swift
//  HealthWaa
//
//  Created by JItendra Yadav on 1/6/18.
//  Copyright © 2018 Jitendra yadav. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
  
  @IBOutlet weak var CV: UICollectionView!
    var ContantArray = [("Family","APP_0000","ic_family"),("Emergency","APP_0001","ic_emergency"),("Coming Soon","APP_0002","logo"),("Coming Soon","APP_0003","logo"),("Coming Soon","APP_0004","logo"),("Coming Soon","APP_0005","logo"),("Coming Soon","APP_0006","logo"),("Logout","APP_0007","ic_logout")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeVC: UICollectionViewDataSource,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ContantArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCell
        let (name,images,logo) = ContantArray[indexPath.row]
        cell.name.text = name
        cell.BackImage.image = UIImage(named: images)
        cell.frontImge.image = UIImage(named: logo)
        return cell
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.CV.frame.size.width)/2-18, height: 240)
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            self.performSegue(withIdentifier: "family", sender: self)
        case 1:
            self.performSegue(withIdentifier: "emergency", sender: self)
        case 7:
            UserDefaults.standard.removeObject(forKey: "userID")
            self.performSegue(withIdentifier: "logout", sender: self)
        default:
            break
        }
    }
}

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var BackImage: UIImageView!
    @IBOutlet weak var frontImge: UIImageView!
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
