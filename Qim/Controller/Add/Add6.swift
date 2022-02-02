//
//  Add6.swift
//  Qim
//
//  Created by Badreah Saad on 27/01/2022.
//

import UIKit

class Add6: UIViewController {
    
    
    @IBOutlet weak var subcategory: UICollectionView!
    
    let categoryBran1 = UITableView()
    let categoryBran2 = UITableView()
   

    
    var addSubcategorys6 = [
        Subcategorys(name: "اجهزة العناية بالشعر"),
        Subcategorys(name: "ميزان")
    ]
    
    var brandCategory1 = [
        BrandCategory(name: "جهاز للشعر براون"),
        BrandCategory(name: "جهاز للشعر فيليبس"),
        BrandCategory(name: "جهاز للشعر بيبي ليس")
    ]
    
    
    var brandCategory2 = [
        BrandCategory(name: "ميزان كينوود"),
        BrandCategory(name: "ميزان هومز")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
    }
    
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(categoryBran2)
        categoryBran2.backgroundColor = .white
        categoryBran2.translatesAutoresizingMaskIntoConstraints = false
        categoryBran2.topAnchor.constraint(equalTo: view.topAnchor, constant: 250.0).isActive = true
        categoryBran2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        categoryBran2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130.0).isActive = true
        categoryBran2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        
        view.addSubview(categoryBran1)
        categoryBran1.backgroundColor = .white
        categoryBran1.translatesAutoresizingMaskIntoConstraints = false
        categoryBran1.topAnchor.constraint(equalTo: view.topAnchor, constant: 250.0).isActive = true
        categoryBran1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        categoryBran1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130.0).isActive = true
        categoryBran1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        
    }
    
    
    
}


extension Add6: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if tableView == categoryBran2 {
            return brandCategory2.count
        } else {
            return brandCategory1.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == categoryBran2 {
            let cell = categoryBran2.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            cell.categoryBranName.text = brandCategory2[indexPath.row].name
            cell.backgroundColor = .white
            return cell
        } else {
            let cell = categoryBran1.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            cell.categoryBranName.text = brandCategory1[indexPath.row].name
            cell.backgroundColor = .white
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if tableView == categoryBran2 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "addEX") as! AddEX1
            vc.addEx = brandCategory2[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "addEX") as! AddEX1
            vc.addEx = brandCategory1[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
}


extension Add6: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addSubcategorys6.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = subcategory.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CollectionViewCell
        cell.subCategoryName.text = addSubcategorys6[indexPath.row].name
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            categoryBran1.isHidden = false
            categoryBran2.isHidden = true
        case 1:
            categoryBran1.isHidden = true
            categoryBran2.isHidden = false
          default:
            break
        }
    }
    
    
    
}



extension Add6 {
    
    func setUp() {
        
        subcategory.delegate = self
        subcategory.dataSource = self
        categoryBran1.delegate = self
        categoryBran1.dataSource = self
        categoryBran2.delegate = self
        categoryBran2.dataSource = self
        
        categoryBran2.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        categoryBran2.delegate = self
        categoryBran2.dataSource = self
        categoryBran2.allowsSelection = true
        categoryBran2.isUserInteractionEnabled = true
        categoryBran2.rowHeight = 70
        categoryBran2.layer.cornerRadius = 10
        categoryBran2.layer.masksToBounds = true
         
        categoryBran1.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        categoryBran1.delegate = self
        categoryBran1.dataSource = self
        categoryBran1.allowsSelection = true
        categoryBran1.isUserInteractionEnabled = true
        categoryBran1.rowHeight = 70
        categoryBran1.layer.cornerRadius = 10
        categoryBran1.layer.masksToBounds = true
        
    }
    
    
    
}
