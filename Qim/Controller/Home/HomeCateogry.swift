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
        CategoryHome(name: "Home"),
        CategoryHome(name: "Kitchen"),
        CategoryHome(name: "Technology"),
        CategoryHome(name: "Other")
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        categorys.delegate = self
        categorys.dataSource = self
        categorys.backgroundColor = UIColor(named: "backGround")
   

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
//         cell.layer.shadowColor = UIColor.white.cgColor
//         cell.layer.shadowOpacity = 3
//         cell.layer.shadowOffset = .zero
//         cell.layer.shadowRadius = 10
 
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "ho", sender: self)
        case 1:
           performSegue(withIdentifier: "ki", sender: self)
        case 2:
            performSegue(withIdentifier: "te", sender: self)

        case 3:
            performSegue(withIdentifier: "ot", sender: self)
          
        default:
            print("no index")
        }

    }
    

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = UIScreen.main.bounds.width / 2
//        return CGSize(width: size, height: size)
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        20
//    }
    
    
    
    
}



