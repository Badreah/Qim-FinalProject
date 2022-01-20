//
//  Add4.swift
//  Qim
//
//  Created by Badreah Saad on 16/01/2022.
//

import UIKit

class Add4: UIViewController {

    
    @IBOutlet weak var subcategory: UICollectionView!
    
    let categoryBran1 = UITableView()
    let categoryBran2 = UITableView()
    let categoryBran3 = UITableView()
    let categoryBran4 = UITableView()
    
    var addsubcategorys4 = [
        Addsubcategorys4(name: "one"),
        Addsubcategorys4(name: "two"),
        Addsubcategorys4(name: "three"),
        Addsubcategorys4(name: "four")
    ]
    
    var categorysBran1 = [
      "one1","one2","one3","one4"
    ]
    var categorysBran2 = [
      "two1","two2","two3","two4"
    ]
    
    var categorysBran3 = [
      "three1","three2","three3","three4"
    ]
    
    var categorysBran4 = [
      "four1","four2","four3","four4"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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

                
        categoryBran2.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        categoryBran2.delegate = self
        categoryBran2.dataSource = self
        categoryBran2.allowsSelection = true
        categoryBran2.isUserInteractionEnabled = true
        categoryBran2.rowHeight = 70
        categoryBran2.layer.cornerRadius = 10
        categoryBran2.layer.masksToBounds = true
        categoryBran2.backgroundColor = .white


        
        categoryBran3.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        categoryBran3.delegate = self
        categoryBran3.dataSource = self
        categoryBran3.allowsSelection = true
        categoryBran3.isUserInteractionEnabled = true
        categoryBran3.rowHeight = 70
        categoryBran3.layer.cornerRadius = 10
        categoryBran3.layer.masksToBounds = true
        categoryBran3.backgroundColor = .white

        
        
        categoryBran4.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        categoryBran4.delegate = self
        categoryBran4.dataSource = self
        categoryBran4.allowsSelection = true
        categoryBran4.isUserInteractionEnabled = true
        categoryBran4.rowHeight = 70
        categoryBran4.layer.cornerRadius = 10
        categoryBran4.layer.masksToBounds = true
        categoryBran4.backgroundColor = .white

        categoryBran1.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        categoryBran1.delegate = self
        categoryBran1.dataSource = self
        categoryBran1.allowsSelection = true
        categoryBran1.isUserInteractionEnabled = true
        categoryBran1.rowHeight = 70
        categoryBran1.layer.cornerRadius = 10
        categoryBran1.layer.masksToBounds = true
        categoryBran1.backgroundColor = .white

       
    }

    override func loadView() {
        super.loadView()
        
        view.addSubview(categoryBran2)
        categoryBran2.translatesAutoresizingMaskIntoConstraints = false
        categoryBran2.topAnchor.constraint(equalTo: view.topAnchor, constant: 250.0).isActive = true
        categoryBran2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        categoryBran2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130.0).isActive = true
        categoryBran2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        
        view.addSubview(categoryBran3)
        categoryBran3.translatesAutoresizingMaskIntoConstraints = false
        categoryBran3.topAnchor.constraint(equalTo: view.topAnchor, constant: 250.0).isActive = true
        categoryBran3.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        categoryBran3.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130.0).isActive = true
        categoryBran3.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        
        view.addSubview(categoryBran4)
        categoryBran4.translatesAutoresizingMaskIntoConstraints = false
        categoryBran4.topAnchor.constraint(equalTo: view.topAnchor, constant: 250.0).isActive = true
        categoryBran4.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        categoryBran4.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130.0).isActive = true
        categoryBran4.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        
        view.addSubview(categoryBran1)
        categoryBran1.translatesAutoresizingMaskIntoConstraints = false
        categoryBran1.topAnchor.constraint(equalTo: view.topAnchor, constant: 250.0).isActive = true
        categoryBran1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        categoryBran1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130.0).isActive = true
        categoryBran1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        
    }
    
}


extension Add4: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == categoryBran4 {
        return categorysBran4.count
        } else if tableView == categoryBran2 {
            return categorysBran2.count
        } else if tableView == categoryBran3 {
            return categorysBran2.count
        } else {
            return categorysBran1.count
        }
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == categoryBran3 {
        let cell = categoryBran3.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.categoryBranName.text = categorysBran3[indexPath.row]
            cell.backgroundColor = .white
        return cell
        } else if tableView == categoryBran2 {
            let cell = categoryBran2.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            cell.categoryBranName.text = categorysBran2[indexPath.row]
            cell.backgroundColor = .white
            return cell
        } else if tableView == categoryBran4 {
            let cell = categoryBran4.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            cell.categoryBranName.text = categorysBran4[indexPath.row]
            cell.backgroundColor = .white
            return cell
        } else {
            let cell = categoryBran1.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            cell.categoryBranName.text = categorysBran1[indexPath.row]
            cell.backgroundColor = .white
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "ex", sender: self)
    }
    
}


extension Add4: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addsubcategorys4.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = subcategory.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! CollectionViewCell
        cell.subCategoryName.text = addsubcategorys4[indexPath.row].name
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
        case 1:
            categoryBran1.isHidden = true
            categoryBran2.isHidden = false
            categoryBran3.isHidden = true
            categoryBran4.isHidden = true
        case 2:
            categoryBran1.isHidden = true
            categoryBran2.isHidden = true
            categoryBran3.isHidden = false
            categoryBran4.isHidden = true
        case 3:
            categoryBran1.isHidden = true
            categoryBran2.isHidden = true
            categoryBran3.isHidden = true
            categoryBran4.isHidden = false
        default:
            break
        }
    }
    
   
    
}


struct Addsubcategorys4 {
    var name: String
}


