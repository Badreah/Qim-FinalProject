//
//  AddHome-P.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase

class AddHome: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var categorys: UICollectionView!
    
    var category = [
        Category(name: "المنزل"),
        Category(name: "المطبخ"),
        Category(name: "التقنية"),
        Category(name: "معدات رياضية"),
        Category(name: "الات موسيقية"),
        Category(name: "اخرى")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if Auth.auth().currentUser?.uid == nil {
            
            let alert = UIAlertController(title: "", message: "الرجاء تسجيل الدخول حتى تتمكن من المتابعة", preferredStyle: .alert)
            let action = UIAlertAction(title: "حسناً", style: .default) { _ in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "profileVc") as! ProfileVc
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
                            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
       
        }
        
        categorys.delegate = self
        categorys.dataSource = self
        categorys.backgroundColor = UIColor(named: "backGround")
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AddCell
        cell.categoryName.text = category[indexPath.row].name
        cell.layer.cornerRadius = 10
        cell.backgroundColor = UIColor(named: "Vi")
        cell.categoryName.textColor = UIColor(named: "Bu")
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "a1", sender: self)
        case 1:
            performSegue(withIdentifier: "a2", sender: self)
        case 2:
            performSegue(withIdentifier: "a3", sender: self)
        case 3:
            performSegue(withIdentifier: "a4", sender: self)
        case 4:
            performSegue(withIdentifier: "a5", sender: self)
        case 5:
            performSegue(withIdentifier: "a6", sender: self)
            
        default:
            print("no index")
        }
        
    }
    
    
    
}



