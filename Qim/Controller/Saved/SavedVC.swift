//
//  LikeVC.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase

class SavedVC: UIViewController  {
    
    @IBOutlet weak var savedEx: UITableView!
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    
    var savedExArray = [SavedExperience]()
    
    let refreshC = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser?.uid == nil {
            
            let alert = UIAlertController(title: "", message: "الرجاء تسجيل الدخول حتى تتمكن من المتابعة", preferredStyle: .alert)
            let action = UIAlertAction(title: "حسناً", style: .default) { _ in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "profileVc") as! ProfileVc
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
                            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
       
        }
        
        
        savedEx.delegate = self
        savedEx.dataSource = self
        
        loadEx()
        
        refreshC.attributedTitle = NSAttributedString(string: "pull to refresh")
        refreshC.addTarget(self, action: #selector(ref(_:)), for: .valueChanged)
        savedEx.addSubview(refreshC)
        
    }
    
    @objc func ref(_ sender: AnyObject){
        savedExArray.removeAll()
        loadEx()
        refreshC.endRefreshing()
    }
    
    
    
    override func loadView() {
        super.loadView()
        //        favEx.allowsSelection = true
        //        favEx.isUserInteractionEnabled = true
        savedEx.rowHeight = 100
        savedEx.backgroundColor = .white
        savedEx.layer.cornerRadius = 10
        savedEx.layer.masksToBounds = true
        savedEx.translatesAutoresizingMaskIntoConstraints = false
        savedEx.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        savedEx.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        savedEx.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        savedEx.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
    }
    
    

    
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
                        let newEX = SavedExperience(name: data["UserName"] as? String ?? "no na",
                                                    userImage: data["UserImage"] as? String ?? "no img",
                                                    productName: data["productName"] as? String ?? "no product",
                                                    opinion: data["opinion"] as? String ?? "no opi",
                                                    productImage: data["productImage"] as? String ?? "no proimg")
                        self.savedExArray.append(newEX)
                        print(newEX)
                    }
                    self.savedEx.reloadData()
                    
                }
            }
        }
    }
    
    
    @objc func shareToButton() {
        
        let c = ProfileVCCell()
        let activityVC = UIActivityViewController(activityItems: [c.productName.text!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view
        print("!! share !!")
        present(activityVC, animated: true, completion: nil)
    }
    
    
}



extension SavedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if savedExArray.count == 0 {
            savedEx.setEmptyMessage("لم تقم بحفظ اي تقييم لقائمتك بعد ")
        } else {
            savedEx.restore()
        }
        return savedExArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedEx.dequeueReusableCell(withIdentifier: "cell") as! SavedCell
        cell.productName.text = savedExArray[indexPath.row].productName
        cell.userName.text = savedExArray[indexPath.row].name
        
        cell.share.addTarget(self, action: #selector(shareToButton), for: .touchUpInside)
        //        cell.rateButton.addTarget(self, action: #selector(likeCount), for: .touchUpInside)
        
        let imgStr = savedExArray[indexPath.row].userImage
        let url = "gs://qim-4f02d.appspot.com/images/" + "\(imgStr)"
        let ref = Storage.storage().reference(forURL: url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("no image download")
            } else {
                cell.userImage.image = UIImage(data: data!)
            }
        }
        
//        cell.userImage.contentMode = .scaleAspectFit
        cell.userImage.contentMode = .scaleAspectFill
        cell.userImage.layer.cornerRadius = cell.userImage.frame.width/2
        cell.userImage.clipsToBounds = true
        cell.backgroundColor = .white
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        performSegue(withIdentifier: "fav", sender: self)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "savedEx") as! SavedEx
        vc.modalPresentationStyle = .fullScreen
        vc.savedEx = savedExArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true, completion: nil)
    }
    
    
    
}




