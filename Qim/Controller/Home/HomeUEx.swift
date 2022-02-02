//
//  HomeUEx.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase


class HomeUEx: UIViewController {
    
    
    @IBOutlet weak var allEx: UITableView!
        
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    
    var allExAraay = [AllEX]()
    
    var categoryType: BrandCategory!
    var categoryName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryName = categoryType.name
        
        allEx.delegate = self
        allEx.dataSource = self
        
        loadAllEX()
        
        
    }
    
    
    override func loadView() {
        super.loadView()
        allEx.rowHeight = 100
        allEx.backgroundColor = .white
        allEx.layer.cornerRadius = 10
        allEx.layer.masksToBounds = true
        allEx.translatesAutoresizingMaskIntoConstraints = false
        allEx.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        allEx.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        allEx.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        allEx.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
    }
    
   
    
    func loadAllEX() {
        db.collection("NewEX").whereField("ExType", isEqualTo: categoryName)
            .getDocuments { [self]
                (snapShot, error) in
                if let error = error {
                    print("!!",error.localizedDescription)
                } else {
                    for doc in snapShot!.documents {
                        let data = doc.data()
                        let timestamp: Timestamp = data["creationDate"] as! Timestamp
                        let datetest: Date = timestamp.dateValue()
//                        let imageStr = data["productImage"] as? String ?? "no proimg"
                        let newUser = AllEX(name: data["UserName"] as? String ?? "no na",
                                            userImage: data["UserImage"] as? String ?? "no img",
                                            productname: data["productName"] as? String ?? "no product",
                                            opinion: data["opinion"] as? String ?? "no opi",
                                            productImage: data["productImage"] as? String ?? "no proimg",
                        creationDate: datetest)
                        self.allExAraay.append(newUser)
//                        self.loadImage(imageStr: imageStr)
                        print(newUser)
                    }
                    self.allEx.reloadData()
                }
            }
    }
    
    
//    func loadImage(imageStr: String) {
//        let url = "gs://qim-4f02d.appspot.com/images/" + "\(imageStr)"
//        let ref = Storage.storage().reference(forURL: url)
//        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
//            if error != nil {
//                print("no image down!")
//                print(error?.localizedDescription)
//            } else {
//                self.vc.productImage.image = UIImage(data: data!)
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
    
    
    
}




extension HomeUEx: UITableViewDelegate, UITableViewDataSource {
    
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
        
        let date = allExAraay[indexPath.row].creationDate
        var stringDate = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        stringDate =  formatter.string(from: date ?? Date())
        //
         
        cell.creationDate.text = stringDate

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeEx") as! HomeEx
        vc.modalPresentationStyle = .fullScreen
        vc.homeex = allExAraay[indexPath.row]
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
