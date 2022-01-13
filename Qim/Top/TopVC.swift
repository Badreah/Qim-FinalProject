//
//  TopVC.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase

class TopVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    let myTabel = UITableView()
    
    let db = Firestore.firestore()
    var topExArray = [TopEX]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        myTabel.register(TopVCCell.self, forCellReuseIdentifier: "cell")
        myTabel.delegate = self
        myTabel.dataSource = self
        myTabel.allowsSelection = true
        myTabel.isUserInteractionEnabled = true
        myTabel.rowHeight = 70
//        myTabel.backgroundColor = .systemGray
        
        fetchEx()
        
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(myTabel)
        myTabel.translatesAutoresizingMaskIntoConstraints = false
        myTabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        myTabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        myTabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        myTabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
    }
    
    
    func fetchEx() {
        db.collection("NewEX").getDocuments { [self]
            (snapShot, error) in
            if let error = error {
                print("!!",error.localizedDescription)
            } else {
                for doc in snapShot!.documents {
                    let data = doc.data()
                    let newUser = TopEX(productName: data["productName"] as? String ?? "no pro")
                    self.topExArray.append(newUser)
                    print(newUser)
                }
                self.myTabel.reloadData()
            }
        }
    }
    
    
   
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topExArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTabel.dequeueReusableCell(withIdentifier: "cell") as! TopVCCell
        cell.backgroundColor = .separator
//        cell.userName.text = topExArray[indexPath.row].name
//        cell.userImage.image = topExArray[indexPath.row].userImage
        cell.titleLabel.text = topExArray[indexPath.row].productName
        return cell
    }
    
}



    struct TopEX {
//        var name: String
//        var userImage: String
        var productName: String
    }

