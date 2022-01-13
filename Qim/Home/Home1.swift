//
//  Home1.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit

class Home1: UIViewController {

    @IBOutlet weak var myCollection: UICollectionView!
    
    @IBOutlet weak var myTable: UITableView!
    
    
    var devArray = [
        Device(title: "DishWasher"),
        Device(title: "washing"),
        Device(title: "air"),
        Device(title: "heater")
    ]
    
    var prandArray1 = [
      "H1a","H1b","H1c","H1d"
    ]
    var prandArray2 = [
      "k1a","k1b","k1c","k1d"
    ]
    
    var prandArray3 = [
      "t1a","t1b","t1c","t1d"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollection.delegate = self
        myCollection.dataSource = self
        myTable.delegate = self
        myTable.dataSource = self
        
        
        
    }

//    override func loadView() {
//        super.loadView()
//        myTable.translatesAutoresizingMaskIntoConstraints = false
//        myTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 300.0).isActive = true
//        myTable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
//        myTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
//        myTable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
//        myTable.backgroundColor = .systemGray
//
//        myCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
//        myCollection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
//        myCollection.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
//        myCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -600.0).isActive = true
//        myCollection.translatesAutoresizingMaskIntoConstraints = false
//    }
    
}


extension Home1: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prandArray1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "tcell") as! TableViewCell
        cell.tLabel.text = prandArray1[indexPath.row]
        return cell
    }
    
    
    
}


extension Home1: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CollectionViewCell
        cell.cLabel.text = devArray[indexPath.row].title
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
   
    
}


struct Device {
    var title: String
}
