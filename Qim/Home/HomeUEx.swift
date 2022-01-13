//
//  HomeUEx.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase

class HomeUEx: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let backButton = UIButton(frame: CGRect(x: 0, y: 50, width: 100, height: 50))


    let myTabel = UITableView()
    
    let db = Firestore.firestore()
    
    var allAraay = [allEX]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        view.addSubview(myTabel)
        
        myTabel.register(UExCell.self, forCellReuseIdentifier: "cell")
        myTabel.delegate = self
        myTabel.dataSource = self
        myTabel.allowsSelection = true
        myTabel.isUserInteractionEnabled = true
        myTabel.rowHeight = 70
        myTabel.backgroundColor = .white
        
        view.addSubview(backButton)
        
        backButton.setTitleColor(.black, for: .normal)
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        

        loadAllEX()
        
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
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }

    
//    db.collection("New EX").addDocument(data: [
//        "UserID" : userID!,
////            "UserName": nameID!,
//        "ExID": exID,
//        "productName": productName.text!,
//        "opi": opinion.text!,
//        "pro": pros.text!,
//        "con": cons.text!,
//        "price": price.text!,
//
        
//    func loadAllEX() {
//        db.collection("NewEX").order(by: "", descending: true).addSnapshotListener { qurySnap, error in
//            if let error = error {
//                print("!!E",error)
//            } else {
//                for doc in qurySnap!.documents {
//                    let data = doc.data()
//                    let allEX = allEX(name: data["UserName"] as? String ?? "no un",
//                                      productname: data["productName"] as? String ?? "no pn ")
//                    self.allAraay.append(allEX)
//                    self.myTabel.reloadData()
//                }
//            }
//        }
//    }
    
    func loadAllEX() {
    db.collection("NewEX").getDocuments { [self]
        (snapShot, error) in
        if let error = error {
            print("!!",error.localizedDescription)
        } else {
            for doc in snapShot!.documents {
                let data = doc.data()
                let newUser = allEX(productname: data["productName"] as? String ?? "no pro")
                self.allAraay.append(newUser)
                print(newUser)
            }
            self.myTabel.reloadData()
        }
    }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAraay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTabel.dequeueReusableCell(withIdentifier: "cell") as! UExCell
        cell.titleLabel.text = allAraay[indexPath.row].productname

        return cell
    }
    
    

}


struct allEX {
//    var name: String
//    var userImage: UIImage
    var productname: String
}
