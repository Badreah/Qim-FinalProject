//
//  AddHome.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit

class AddHome: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var catCollection: UICollectionView!
    
    @IBOutlet weak var devcollection: UICollectionView!
    
    @IBOutlet weak var brCollection: UICollectionView!
    
    var catArray = [ "c1","c2","c3","c4","c1","c2","c3","c4","c1","c2","c3","c4"]
    var devArray = ["d1","d2","d3","d4","d1","d2","d3","d4","d1","d2","d3","d4"]
    var brArray = ["b1","b2","b3","b4","b1","b2","b3","b4","b1","b2","b3","b4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catCollection.delegate = self
        catCollection.dataSource = self
        devcollection.delegate = self
        devcollection.dataSource = self
        brCollection.delegate = self
        brCollection.dataSource = self

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == catCollection {
            return catArray.count
        } else if collectionView ==  devcollection {
            return devArray.count
        } else {
        return brArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == catCollection {
            let ccell = catCollection.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CatCell
            ccell.cLabel.text = catArray[indexPath.row]
            ccell.cLabel.textColor = .white
            ccell.cLabel.textAlignment = .center
            ccell.layer.cornerRadius = 10
            ccell.backgroundColor = .red
            return ccell
        } else if collectionView == devcollection {
            let dcell = devcollection.dequeueReusableCell(withReuseIdentifier: "dcell", for: indexPath) as! DevCell
            dcell.dLabel.text = devArray[indexPath.row]
            dcell.layer.cornerRadius = 10
            dcell.backgroundColor = .orange
            return dcell
        } else {
            let bcell = brCollection.dequeueReusableCell(withReuseIdentifier: "bcell", for: indexPath) as! BrCell
            bcell.bLabel.text = brArray[indexPath.row]
            bcell.layer.cornerRadius = 10
            bcell.backgroundColor = .purple
            return bcell
        }
        
       
    }
    



}
