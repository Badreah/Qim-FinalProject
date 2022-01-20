//
//  ViewController.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase

class ProfileVc: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let db = Firestore.firestore()
    var userID = Auth.auth().currentUser?.uid
    let imagePicker = UIImagePickerController()
    var updateImageName = "\(UUID().uuidString).png"

    
    let loginView: UIView = {
        let loginView = UIView()
//        loginView.backgroundColor = .systemCyan
//        loginView.frame = CGRect(x: 0, y: 60, width: 400, height: 660)
        return loginView
    }()
    
    let loginButton = UIButton()
//    (frame: CGRect(x: 150, y: 200, width: 300, height: 50))
    
    let signUpLabel = UILabel(frame: CGRect(x: 130, y: 400, width: 200, height: 50))
    
    let signUpButton = UIButton(frame: CGRect(x: 160, y: 460, width: 70, height: 50))
   
    
    
    @IBOutlet weak var lView: UIView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var pView: UIView!
    
    let profileView: UIView = {
        let profileView = UIView()
        return profileView
    }()
    
    let logOutButton = UIButton()
    var userImage = UIImageView()
    var userName = UILabel()
    let myTabel = UITableView()

    
    var exArray = [Ex]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self


        view.backgroundColor = .white
        view.addSubview(loginView)
//        loginView.backgroundColor = .white
        loginView.isHidden = true
        view.addSubview(profileView)
//        profileView.backgroundColor = .red
        profileView.isHidden = true
        
        profileView.addSubview(logOutButton)
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30.0).isActive = true
        loginView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20.0).isActive = true
        loginView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -0.0).isActive = true
        
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30.0).isActive = true
        profileView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        profileView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20.0).isActive = true
        profileView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -0.0).isActive = true
//
        
        logOutButton.setTitle("تسجيل الخروج", for: .normal)
        logOutButton.setTitleColor(UIColor(named: "Bu"), for: .normal)
        logOutButton.layer.cornerRadius = 10
        logOutButton.addTarget(self, action: #selector(userLogOut), for: .touchUpInside)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 30.0).isActive = true
        logOutButton.leftAnchor.constraint(equalTo: profileView.leftAnchor, constant: 273.0).isActive = true
        
        profileView.addSubview(userImage)
        userImage.image = UIImage(systemName: "person")
        userImage.frame = CGRect(x: 280, y: 110, width: 100, height: 100)
        userImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(addUserImage))
        userImage.addGestureRecognizer(tap)
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = userImage.frame.width/2
        userImage.clipsToBounds = true
        
        profileView.addSubview(userName)

        userName.textColor = UIColor(named: "Bu")
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 140.0).isActive = true
        userName.rightAnchor.constraint(equalTo: profileView.rightAnchor, constant: -250.0).isActive = true

        
        profileView.addSubview(myTabel)
        myTabel.register(ProfileVCCell.self, forCellReuseIdentifier: "cell")
        myTabel.delegate = self
        myTabel.dataSource = self
//        myTabel.allowsSelection = true
//        myTabel.isUserInteractionEnabled = true
        myTabel.rowHeight = 80
        myTabel.backgroundColor = .white
        myTabel.layer.cornerRadius = 10
        myTabel.layer.masksToBounds = true
        myTabel.translatesAutoresizingMaskIntoConstraints = false
        myTabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 225.0).isActive = true
        myTabel.leftAnchor.constraint(equalTo: profileView.leftAnchor, constant: 20.0).isActive = true
        myTabel.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -80.0).isActive = true
        myTabel.rightAnchor.constraint(equalTo: profileView.rightAnchor, constant: -20.0).isActive = true

        loginView.addSubview(loginButton)
        loginView.addSubview(signUpLabel)
        loginView.addSubview(signUpButton)
        
        loginButton.backgroundColor = UIColor(named: "Bu")
        loginButton.setTitle("تسجيل الدخول", for: .normal)
        loginButton.setTitleColor(UIColor(named: "Vi"), for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(userLogIn), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 230.0).isActive = true
        loginButton.rightAnchor.constraint(equalTo: loginView.rightAnchor, constant: -100.0).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
       
        
        signUpLabel.text = "ليس لديك حساب؟"
        signUpLabel.textColor = UIColor(named: "Bu")
        
        signUpButton.setTitle("سجل", for: .normal)
        signUpButton.setTitleColor(UIColor(named: "Bu"), for: .normal)
        signUpButton.addTarget(self, action: #selector(userSignUP), for: .touchUpInside)
        
        if Auth.auth().currentUser?.uid != nil {
            profileView.isHidden = false
            loginView.isHidden = true
            lView.isHidden = true
            
        } else {
            profileView.isHidden = true
            loginView.isHidden = false
            labelView.isHidden = true
            pView.isHidden = true
            lView.layer.cornerRadius = 20
            lView.layer.shadowColor = UIColor.black.cgColor
            lView.layer.shadowOpacity = 1
            lView.layer.shadowOffset = .zero
            lView.layer.shadowRadius = 5
            lView.translatesAutoresizingMaskIntoConstraints = false
            lView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200.0).isActive = true
            lView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
            lView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200.0).isActive = true
            lView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
            

        }

        loadUserProfile()
        loadEx()
//        updateImage()
    }
    
    
   
    
    // loginView
    @objc func userSignUP() {
        let vc = SignUPVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func userLogIn() {
        performSegue(withIdentifier: "Lvc", sender: self)
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Lvc") as! LoginVC
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)

    }
    
    // profileView
    
    @objc func userLogOut() {
        let alert = UIAlertController(title: nil, message: "هل متأكد من تسجبل الخروج", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "تسجيل الخروج", style: .default) {_ in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "tab") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            do {
                try Auth.auth().signOut()
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "الغاء", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)

    }
    
 
    func loadUserProfile() {
        if let userId = userID {
            db.collection("Users").document(userId).getDocument { snapshot, error in
                if let error = error {
                    print("!!",error.localizedDescription)
                } else {
                    self.userName.text = snapshot?.get("UserName") as? String ?? "no name!"
                    let imageStr = snapshot?.get("UserImage") as? String ?? "no image!"
//                    if imageStr == "nil" {
//                        self.userImage.image = UIImage(systemName: "person")
//                    } else {
                        self.loadImage(imageStr: imageStr)
                    }
                }
            }
        }
    
//    }
    
    
    func loadImage(imageStr: String) {
        let url = "gs://qim-4f02d.appspot.com/images/" + "\(imageStr)"
        let ref = Storage.storage().reference(forURL: url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("no image down!")
                print(error?.localizedDescription)
            } else {
                self.userImage.image = UIImage(data: data!)
            }
        }
    }
    
    
    @objc func addUserImage() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    func updataImage() {
        uploadImage()
        self.db.collection("Users").document(userID!).updateData([
            "UserImage": userImage.image == UIImage(systemName: "person") ? "nil!" : updateImageName
        ])
        { error in
            if error == nil {
                print("image added!")
            } else {
                print("no image added!",error)
                
            }
            
        }
    }
    
    
    func uploadImage() {
        let imageFolder = Storage.storage().reference().child("images")
        if let imageData = userImage.image?.jpegData(compressionQuality: 0.1) {
            imageFolder.child(updateImageName).putData(imageData, metadata: nil) {
                metaData, error in
                if let error = error {
                    print("!!",error.localizedDescription)
                } else {
                    print("image updated!")
                }
            }
        }
        
    }
   


    
    func loadEx() {
        db.collection("NewEX")
//            .document("EX").getDocument { documentSnapshot, error in
////
////        })
            .getDocuments { [self] (qurysnapshot, error) in
            if let error = error {
                print("no new ex!", error.localizedDescription)
            } else {
                for doc in qurysnapshot!.documents {
                    let data = doc.data()
                    
                    
//                    print((doc.get("UserID") as? String ?? "nil!") == Auth.auth().currentUser?.uid )
//                    if (doc.get("UserID") as? String ?? "nil!") == Auth.auth().currentUser?.uid {
//                        print("!!",(doc.get("UserID") as? String ?? "nil!") == Auth.auth().currentUser?.uid )
                
                    let newEX = Ex(productName: data["productName"] as? String ?? "no product",
                                   opi: data["opi"] as? String ?? "no opi")
//                                   pro: data["pro"] as? String ?? "no pro",
//                                   con: data["con"] as? String ?? "no con")
                
//                let newEX = Ex(productName: documentSnapshot?.get("productName") as? String ?? "no product",
                    
                    
                    
//                               opi: documentSnapshot?.get("opi") as? String ?? "no opi",
//                               pro: documentSnapshot?.get("pro") as? String ?? "no pro",
//                               con: documentSnapshot?.get("con") as? String ?? "no con")
                    self.exArray.append(newEX)
                        print(newEX)
                    }
                    self.myTabel.reloadData()
                    
                    }
                }
            }
//        }
    
    @objc func shareToButton() {

        let c = ProfileVCCell()
        let activityVC = UIActivityViewController(activityItems: [c.titleLabel.text!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view
        print("!! share !!")
        present(activityVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTabel.dequeueReusableCell(withIdentifier: "cell") as! ProfileVCCell
        cell.titleLabel.text = exArray[indexPath.row].productName
        cell.share.addTarget(self, action: #selector(shareToButton), for: .touchUpInside)

        cell.backgroundColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "userEx") as! UserEx
        vc.modalPresentationStyle = .fullScreen
        vc.userEx = exArray[indexPath.row]
        self.present(vc, animated: true, completion: nil)
        
//        let vc = UserEx()
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true, completion: nil)
        print("??")
    }
    
  

    
    
    
}


extension ProfileVc: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    userImage.image = pickedImage
      updataImage()
    picker.dismiss(animated: true, completion: nil)
  }


}



struct Ex {
//    var name: String
//    var userImage: String
    var productName: String
    var opi: String
//    var pro: String
//    var con: String
    
}



//extension UITableView {
//    func setEmptyMasg(_ masg: String) {
//        let masgLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
//        masgLabel.text = masg
//        masgLabel.textColor = .black
//        self.backgroundView = masgLabel
////        self.separatorStyle = .none
//    }
//
//    func restore() {
//        myTabel.backgroundView = nil
//        myTabel.separatorStyle = .singleLine
//    }
//
//}






