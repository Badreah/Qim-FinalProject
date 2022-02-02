//
//  HomeCateogry.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit

class HomeCateogry: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        
        categorys.delegate = self
        categorys.dataSource = self
        //        categorys.backgroundColor = UIColor(named: "backGround")
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categorys.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCell
        cell.categoryName.text = category[indexPath.row].name
        cell.layer.cornerRadius = 10
        cell.backgroundColor = UIColor(named: "Vi")
        cell.categoryName.textColor = UIColor(named: "Bu")
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "h1", sender: self)
        case 1:
            performSegue(withIdentifier: "h2", sender: self)
        case 2:
            performSegue(withIdentifier: "h3", sender: self)
        case 3:
            performSegue(withIdentifier: "h4", sender: self)
        case 4:
            performSegue(withIdentifier: "h5", sender: self)
        case 5:
            performSegue(withIdentifier: "h6", sender: self)
        default:
            print("no index")
        }
        
    }
    
    
    
    
}



