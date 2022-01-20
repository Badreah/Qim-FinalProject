//
//  LikeVC.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase

class LikeVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var favEx: UITableView!
    
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    
    var favExArray = [favEX]()

    let refreshC = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        favEx.delegate = self
        favEx.dataSource = self
//        favEx.allowsSelection = true
//        favEx.isUserInteractionEnabled = true
        favEx.rowHeight = 100
        favEx.backgroundColor = .white
        favEx.layer.cornerRadius = 10
        favEx.layer.masksToBounds = true
        
        loadEx()
        
        refreshC.attributedTitle = NSAttributedString(string: "pull to refresh")
        refreshC.addTarget(self, action: #selector(ref(_:)), for: .valueChanged)
        favEx.addSubview(refreshC)
        
    }
    
    @objc func ref(_ sender: AnyObject){
        favExArray.removeAll()
        loadEx()
        refreshC.endRefreshing()
    }
    
    override func loadView() {
        super.loadView()
        favEx.translatesAutoresizingMaskIntoConstraints = false
        favEx.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        favEx.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        favEx.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        favEx.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
    }
    
    
//    func fetchEx() {
//        db.collection("NewEX").getDocuments { [self]
//            (snapShot, error) in
//            if let error = error {
//                print("!!",error.localizedDescription)
//            } else {
//                for doc in snapShot!.documents {
//                    let data = doc.data()
//                    let newUser = favEX(name: data["UserName"] as? String ?? "no na",
//                                        userImage: data["UserImage"] as? String ?? "no img",
//                                        productName: data["productName"] as? String ?? "no product",
//                                        opi: data["opi"] as? String ?? "no opi",
//                                        pro: data["pro"] as? String ?? "no pro",
//                                        con: data["con"] as? String ?? "no con")
//                    self.favExArray.append(newUser)
//                    print(newUser)
//                }
//                self.myTabel.reloadData()
//            }
//        }
//    }
    

    
    func loadEx() {
        db.collection("Saved").getDocuments { [self] (qurysnapshot, error) in
            if let error = error {
                print("no new saved!", error.localizedDescription)
            } else {
                for doc in qurysnapshot!.documents {
                    let data = doc.data()
                    print((doc.get("UserID") as? String ?? "nil!") == Auth.auth().currentUser?.uid )
                    if (doc.get("UserID") as? String ?? "nil!") == Auth.auth().currentUser?.uid {
                        print("!!",(doc.get("UserID") as? String ?? "nil!") == Auth.auth().currentUser?.uid )
                   let newEX = favEX(name: data["UserName"] as? String ?? "no na",
                                     userImage: data["UserImage"] as? String ?? "no img",
                                     productName: data["productName"] as? String ?? "no product",
                                     opinion: data["opi"] as? String ?? "no opi")
                    self.favExArray.append(newEX)
                        print(newEX)
                    }
                    self.favEx.reloadData()
                    
                    }
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
        return favExArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favEx.dequeueReusableCell(withIdentifier: "cell") as! LikeVCCell
        cell.userName.text = favExArray[indexPath.row].name
//        cell.userImage.image = topExArray[indexPath.row].userImage
        cell.productName.text = favExArray[indexPath.row].productName
//        cell.rateNum.text = topExArray[indexPath.row].like

//        cell.selectionStyle = .none
        cell.share.addTarget(self, action: #selector(shareToButton), for: .touchUpInside)
//        cell.rateButton.addTarget(self, action: #selector(likeCount), for: .touchUpInside)
//        cell.userImage.layer.cornerRadius =  cell.userImage.frame.height/2
//                cell.userImage.layer.cornerRadius = cell.userImage.frame.width / 2

//        cell.titleLabel.text = productSaved
        
        cell.userImage.contentMode = .scaleAspectFit
        
        let imgStr = favExArray[indexPath.row].userImage
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
   performSegue(withIdentifier: "fav", sender: self)
    }
    

}


struct favEX {
    var name: String
    var userImage: String
    var productName: String
    var opinion: String
 
}



