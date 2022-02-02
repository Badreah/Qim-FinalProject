//
//  TopVC.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase

class RecentVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var recenEx: UITableView!
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    
    var recenExArray = [RecentExperience]()

    override func viewDidLoad() {
        super.viewDidLoad()

                
        recenEx.delegate = self
        recenEx.dataSource = self

        
       
        fetchEx()
    }
    
    override func loadView() {
        super.loadView()
        recenEx.rowHeight = 100
        recenEx.backgroundColor = .white
        recenEx.layer.cornerRadius = 10
        recenEx.layer.masksToBounds = true
        recenEx.translatesAutoresizingMaskIntoConstraints = false
        recenEx.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        recenEx.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        recenEx.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        recenEx.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
    }
    
    
    func fetchEx() {
        db.collection("NewEX").order(by: "creationDate", descending: true)
            .getDocuments { [self]
            (snapShot, error) in
            if let error = error {
                print("!!",error.localizedDescription)
            } else {
                for doc in snapShot!.documents {
                    let data = doc.data()
                    let timestamp: Timestamp = data["creationDate"] as! Timestamp
                    let datetest: Date = timestamp.dateValue()
                    let newUser = RecentExperience(name: data["UserName"] as? String ?? "no na",
                                        userImage: data["UserImage"] as? String ?? "no img",
                                        productName: data["productName"] as? String ?? "no product",
                                                   opinion: data["opinion"] as? String ?? "no opi", productImage: data["productImage"] as? String ?? "no proimg",
                    creationDate: datetest)
//                                        rate: data["rate"] as? String ?? "empty")
                    self.recenExArray.append(newUser)
                    print(newUser)
                }
                self.recenEx.reloadData()
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
        if Auth.auth().currentUser?.uid == nil {
            
            let alert = UIAlertController(title: "", message: "الرجاء تسجيل الدخول حتى تتمكن من المتابعة", preferredStyle: .alert)
            let action = UIAlertAction(title: "حسناً", style: .default) { _ in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "profileVc") as! ProfileVc
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
                            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
       
        } else {

        let c = ProfileVCCell()
        let activityVC = UIActivityViewController(activityItems: [c.productName.text!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view
        print("!! share !!")
        present(activityVC, animated: true, completion: nil)
    }
    }
    

   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recenExArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recenEx.dequeueReusableCell(withIdentifier: "cell") as! RecentCell
        cell.productName.text = recenExArray[indexPath.row].productName
        cell.userName.text = recenExArray[indexPath.row].name

        cell.share.addTarget(self, action: #selector(shareToButton), for: .touchUpInside)

//        cell.userImage.contentMode = .scaleAspectFit
        
        let imgStr = recenExArray[indexPath.row].userImage
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
        
        let date = recenExArray[indexPath.row].creationDate
        var stringDate = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        stringDate =  formatter.string(from: date ?? Date())
        //
         
        cell.creationDate.text = stringDate
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecentEX") as! RecentEXContent
        vc.modalPresentationStyle = .fullScreen
        vc.recEx = recenExArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true, completion: nil)
       
    }

        
}


