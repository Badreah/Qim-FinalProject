//
//  HomeUEx.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase

class HomeUEx: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   

    @IBOutlet weak var allEx: UITableView!
    
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    var allExAraay = [AllEX]()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        allEx.delegate = self
        allEx.dataSource = self
//        allEx.allowsSelection = true
//        allEx.isUserInteractionEnabled = true
        allEx.rowHeight = 100
        allEx.backgroundColor = .white
        allEx.layer.cornerRadius = 10
        allEx.layer.masksToBounds = true
       
        loadAllEX()
        
    }
    
    override func loadView() {
        super.loadView()
        allEx.translatesAutoresizingMaskIntoConstraints = false
        allEx.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        allEx.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        allEx.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        allEx.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
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
                    let newUser = AllEX(name: data["UserName"] as? String ?? "no na",
                                        userImage: data["UserImage"] as? String ?? "no img",
                                        productname: data["productName"] as? String ?? "no product",
                                        opinion: data["opi"] as? String ?? "no opi")
                    self.allExAraay.append(newUser)
                    print(newUser)
                }
                self.allEx.reloadData()
            }
        }
    }
    
    @objc func shareToButton() {
        let c = ProfileVCCell()
        let activityVC = UIActivityViewController(activityItems: [c.titleLabel.text!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view
        print("!! share !!")
        present(activityVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allExAraay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = allEx.dequeueReusableCell(withIdentifier: "cell") as! UExCell
        cell.productName.text = allExAraay[indexPath.row].productname
        cell.userName.text = allExAraay[indexPath.row].name
        
        cell.share.addTarget(self, action: #selector(shareToButton), for: .touchUpInside)
        
        let imgStr = allExAraay[indexPath.row].userImage
        let url = "gs://qim-4f02d.appspot.com/images/" + "\(imgStr)"
        let ref = Storage.storage().reference(forURL: url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("no image download")
            } else {
                cell.userImage.image = UIImage(data: data!)
            }
        }
        
        cell.userImage.contentMode = .scaleAspectFill
        cell.userImage.layer.cornerRadius = cell.userImage.frame.width/2
        cell.userImage.clipsToBounds = true
        cell.backgroundColor = .white

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeEx") as! HomeEx
        vc.modalPresentationStyle = .fullScreen
        vc.homeex = allExAraay[indexPath.row]
        self.present(vc, animated: true, completion: nil)

     }
   
}



