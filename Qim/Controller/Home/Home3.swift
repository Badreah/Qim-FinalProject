//
//  home3.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit

class Home3: UIViewController {
    
    
    
    @IBOutlet weak var subcategory: UICollectionView!
    
    let categoryBran1 = UITableView()
    let categoryBran2 = UITableView()
    let categoryBran3 = UITableView()
    let categoryBran4 = UITableView()
    let categoryBran5 = UITableView()

    
    var subcategorys3 = [
        Subcategorys(name: "الجوالات"),
        Subcategorys(name: "اجهزة لوحية"),
        Subcategorys(name: "ساعات ذكية"),
        Subcategorys(name: "لابتوبات"),
        Subcategorys(name: "تلفزيونات")
    ]
    
    var brandCategory1 = [
        BrandCategory(name: "جوال ابل"),
        BrandCategory(name: "جوال سامسونج"),
        BrandCategory(name: "جوال هواوي"),
        BrandCategory(name: "جوال نوكيا"),
        BrandCategory(name: "جوال لينوفو"),
        BrandCategory(name: "جوال شاومي")
    ]
    var brandCategory2 = [
        BrandCategory(name: "جهاز لوحي بل"),
        BrandCategory(name: "جهاز لوحي سامسونج"),
        BrandCategory(name: "جهاز لوحي شاومي"),
        BrandCategory(name: "جهاز لوحي لينوفو"),
        BrandCategory(name: "جهاز لوحي هواوي"),
        BrandCategory(name: "جهاز لوحي آي لايف")
    ]
    
    var brandCategory3 = [
        BrandCategory(name: "ساعة ابل"),
        BrandCategory(name: "ساعة سامسونج"),
        BrandCategory(name: "ساعة شاومي"),
        BrandCategory(name: "ساعة فيت بت"),
        BrandCategory(name: "ساعة هواوي"),
        BrandCategory(name: "ساعة ماستر شيلد")
    ]
    
   
    var brandCategory4 = [
        BrandCategory(name: "لابتوب ابل"),
        BrandCategory(name: "لابتوب اتش بي"),
        BrandCategory(name: "لابتوب اسوس"),
        BrandCategory(name: "لابتوب ايسر"),
        BrandCategory(name: "لابتوب لينوفو"),
        BrandCategory(name: "لابتوب هواوي")
    ]
    
    var brandCategory5 = [
        BrandCategory(name: "تلفزيون ال جي"),
        BrandCategory(name: "تلفزيون سوني"),
        BrandCategory(name: "تلفزيون سامسونج"),
        BrandCategory(name: "تلفزيون توشيبا"),
        BrandCategory(name: "تلفزيون هواوي"),
        BrandCategory(name: "تلفزيون فيليبس")
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
        
        view.addSubview(categoryBran3)
        categoryBran3.backgroundColor = .white
        categoryBran3.translatesAutoresizingMaskIntoConstraints = false
        categoryBran3.topAnchor.constraint(equalTo: view.topAnchor, constant: 250.0).isActive = true
        categoryBran3.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        categoryBran3.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130.0).isActive = true
        categoryBran3.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        
        view.addSubview(categoryBran4)
        categoryBran4.backgroundColor = .white
        categoryBran4.translatesAutoresizingMaskIntoConstraints = false
        categoryBran4.topAnchor.constraint(equalTo: view.topAnchor, constant: 250.0).isActive = true
        categoryBran4.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        categoryBran4.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130.0).isActive = true
        categoryBran4.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        
        view.addSubview(categoryBran5)
        categoryBran5.backgroundColor = .white
        categoryBran5.translatesAutoresizingMaskIntoConstraints = false
        categoryBran5.topAnchor.constraint(equalTo: view.topAnchor, constant: 250.0).isActive = true
        categoryBran5.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        categoryBran5.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130.0).isActive = true
        categoryBran5.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
       
        view.addSubview(categoryBran1)
        categoryBran1.backgroundColor = .white
        categoryBran1.translatesAutoresizingMaskIntoConstraints = false
        categoryBran1.topAnchor.constraint(equalTo: view.topAnchor, constant: 250.0).isActive = true
        categoryBran1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        categoryBran1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130.0).isActive = true
        categoryBran1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        
    }
    
}


extension Home3: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == categoryBran5 {
            return brandCategory5.count
        } else
        if tableView == categoryBran4 {
            return brandCategory4.count
        } else if tableView == categoryBran2 {
            return brandCategory2.count
        } else if tableView == categoryBran3 {
            return brandCategory3.count
        } else {
            return brandCategory1.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == categoryBran5 {
            let cell = categoryBran5.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            cell.categoryBranName.text = brandCategory5[indexPath.row].name
            cell.backgroundColor = .white
            return cell
        } else
        if tableView == categoryBran3 {
            let cell = categoryBran3.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            cell.categoryBranName.text = brandCategory3[indexPath.row].name
            cell.backgroundColor = .white
            return cell
        } else if tableView == categoryBran2 {
            let cell = categoryBran2.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            cell.categoryBranName.text = brandCategory2[indexPath.row].name
            cell.backgroundColor = .white
            return cell
        } else if tableView == categoryBran4 {
            let cell = categoryBran4.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            cell.categoryBranName.text = brandCategory4[indexPath.row].name
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
//        performSegue(withIdentifier: "showEX", sender: self)
        if tableView == categoryBran4 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "homeUEx") as! HomeUEx
            vc.categoryType = brandCategory4[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        } else if tableView == categoryBran2 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "homeUEx") as! HomeUEx
            vc.categoryType = brandCategory2[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        } else if tableView == categoryBran3 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "homeUEx") as! HomeUEx
            vc.categoryType = brandCategory3[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "homeUEx") as! HomeUEx
            vc.categoryType = brandCategory1[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}


extension Home3: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subcategorys3.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = subcategory.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CollectionViewCell
        cell.subCategoryName.text = subcategorys3[indexPath.row].name
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            categoryBran1.isHidden = false
            categoryBran2.isHidden = true
            categoryBran3.isHidden = true
            categoryBran4.isHidden = true
            categoryBran5.isHidden = true
        case 1:
            categoryBran1.isHidden = true
            categoryBran2.isHidden = false
            categoryBran3.isHidden = true
            categoryBran4.isHidden = true
            categoryBran5.isHidden = true
        case 2:
            categoryBran1.isHidden = true
            categoryBran2.isHidden = true
            categoryBran3.isHidden = false
            categoryBran4.isHidden = true
            categoryBran5.isHidden = true
        case 3:
            categoryBran1.isHidden = true
            categoryBran2.isHidden = true
            categoryBran3.isHidden = true
            categoryBran4.isHidden = false
            categoryBran5.isHidden = true
        case 4:
            categoryBran1.isHidden = true
            categoryBran2.isHidden = true
            categoryBran3.isHidden = true
            categoryBran4.isHidden = true
            categoryBran5.isHidden = false
        default:
            break
        }
    }
    
    
    
}



extension Home3 {
    
    func setUp() {
        
        subcategory.delegate = self
        subcategory.dataSource = self
        categoryBran1.delegate = self
        categoryBran1.dataSource = self
        categoryBran2.delegate = self
        categoryBran2.dataSource = self
        categoryBran3.delegate = self
        categoryBran3.dataSource = self
        categoryBran4.delegate = self
        categoryBran4.dataSource = self
        categoryBran5.delegate = self
        categoryBran5.dataSource = self
        
        categoryBran2.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        categoryBran2.delegate = self
        categoryBran2.dataSource = self
        categoryBran2.allowsSelection = true
        categoryBran2.isUserInteractionEnabled = true
        categoryBran2.rowHeight = 70
        categoryBran2.layer.cornerRadius = 10
        categoryBran2.layer.masksToBounds = true
        
        categoryBran3.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        categoryBran3.delegate = self
        categoryBran3.dataSource = self
        categoryBran3.allowsSelection = true
        categoryBran3.isUserInteractionEnabled = true
        categoryBran3.rowHeight = 70
        categoryBran3.layer.cornerRadius = 10
        categoryBran3.layer.masksToBounds = true
        
        
        categoryBran4.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        categoryBran4.delegate = self
        categoryBran4.dataSource = self
        categoryBran4.allowsSelection = true
        categoryBran4.isUserInteractionEnabled = true
        categoryBran4.rowHeight = 70
        categoryBran4.layer.cornerRadius = 10
        categoryBran4.layer.masksToBounds = true
        
        categoryBran5.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        categoryBran5.delegate = self
        categoryBran5.dataSource = self
        categoryBran5.allowsSelection = true
        categoryBran5.isUserInteractionEnabled = true
        categoryBran5.rowHeight = 70
        categoryBran5.layer.cornerRadius = 10
        categoryBran5.layer.masksToBounds = true
       
        
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
