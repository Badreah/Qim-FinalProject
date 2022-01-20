//
//  TopVC.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase

class TopVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var topEx: UITableView!
    
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    
    var topExArray = [TopEX]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
//        myTabel.delaysContentTouches = false
        
        topEx.delegate = self
        topEx.dataSource = self
//        myTabel.allowsSelection = true
//        myTabel.isUserInteractionEnabled = true
        topEx.rowHeight = 100
        topEx.backgroundColor = .white
        topEx.layer.cornerRadius = 10
        topEx.layer.masksToBounds = true
       
        fetchEx()
    }
    
    override func loadView() {
        super.loadView()
        topEx.translatesAutoresizingMaskIntoConstraints = false
        topEx.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        topEx.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        topEx.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        topEx.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
    }
    
    
    func fetchEx() {
        db.collection("NewEX").getDocuments { [self]
            (snapShot, error) in
            if let error = error {
                print("!!",error.localizedDescription)
            } else {
                for doc in snapShot!.documents {
                    let data = doc.data()
                    let newUser = TopEX(name: data["UserName"] as? String ?? "no na",
                                        userImage: data["UserImage"] as? String ?? "no img",
                                        productName: data["productName"] as? String ?? "no product",
                                        opinion: data["opi"] as? String ?? "no opi")
//                                        rate: data["rate"] as? String ?? "empty")
                    self.topExArray.append(newUser)
                    print(newUser)
                }
                self.topEx.reloadData()
            }
        }
    }
    
    
           
    
    
//    func update() {
//        db.collection("NewEX").document().updateData(["rate": likeCount()]) { error in
//            if error == nil {
//                print("like updated")
//            } else {
//                print("no like",error?.localizedDescription)
//            }
//        }
//    }
    
    
    @objc func shareToButton() {

        let c = ProfileVCCell()
        let activityVC = UIActivityViewController(activityItems: [c.titleLabel.text!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view
        print("!! share !!")
        present(activityVC, animated: true, completion: nil)
    }
    
    

   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topExArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = topEx.dequeueReusableCell(withIdentifier: "cell") as! TopVCCell
        cell.userName.text = topExArray[indexPath.row].name
        cell.productName.text = topExArray[indexPath.row].productName

        cell.share.addTarget(self, action: #selector(shareToButton), for: .touchUpInside)

        cell.userImage.contentMode = .scaleAspectFit
        
        let imgStr = topExArray[indexPath.row].userImage
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
        performSegue(withIdentifier: "top", sender: self)
    }
    
        
}



    struct TopEX {
        var name: String
        var userImage: String
        var productName: String
        var opinion: String

    }

