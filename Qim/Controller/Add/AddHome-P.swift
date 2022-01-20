//
//  AddHome-P.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit

class AddHome_P: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var categorys: UICollectionView!
    
    var category = [
        CategoryAdd(name: "Home"),
        CategoryAdd(name: "Kitchen"),
        CategoryAdd(name: "Technology"),
        CategoryAdd(name: "Other")
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
            performSegue(withIdentifier: "Aho", sender: self)
        case 1:
           performSegue(withIdentifier: "Aki", sender: self)
        case 2:
            performSegue(withIdentifier: "Ate", sender: self)
        case 3:
            performSegue(withIdentifier: "Aot", sender: self)
          
        default:
            print("no index")
        }

    }


    
}



