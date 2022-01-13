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
    
//    var pickedImage = UIImage()
    
//    let userNameDis = Auth.auth().currentUser?.displayName
    


    let loginView: UIView = {
        let loginView = UIView()
//        loginView.backgroundColor = .systemCyan
        loginView.frame = CGRect(x: 30, y: 60, width: 350, height: 700)
        return loginView
    }()
    
    let loginButton = UIButton(frame: CGRect(x: 130, y: 250, width: 100, height: 50))
    
    let signUpLabel = UILabel(frame: CGRect(x: 60, y: 500, width: 200, height: 50))
    
    let signUpButton = UIButton(frame: CGRect(x: 250, y: 500, width: 70, height: 50))
   
    
    
    
    let profileView: UIView = {
        let profileView = UIView()
//        profileView.backgroundColor = .systemMint
        profileView.frame = CGRect(x: 30, y: 60, width: 350, height: 700)
        return profileView
    }()
    
    let logOutButton = UIButton(frame: CGRect(x: 250, y: 20, width: 100, height: 50))
    let userImage = UIImageView()
//    let imageButton = UIButton(frame: CGRect(x: 20, y: 130, width: 150, height: 60))
    let userName = UILabel(frame: CGRect(x: 120, y: 100, width: 100, height: 40))
    let myTabel = UITableView()

    
    var exArray = [Ex]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self


        view.backgroundColor = .white
        view.addSubview(loginView)
        loginView.backgroundColor = .white
        loginView.isHidden = true
        view.addSubview(profileView)
        profileView.backgroundColor = .white
        profileView.isHidden = true
        
        profileView.addSubview(logOutButton)
        
//        view.addSubview(logOutButton)
        logOutButton.setTitle("LogOut", for: .normal)
        logOutButton.setTitleColor(.blue, for: .normal)
        logOutButton.layer.cornerRadius = 10
        logOutButton.addTarget(self, action: #selector(userLogOut), for: .touchUpInside)
//        logOutButton.isHidden = true
        
        profileView.addSubview(userImage)
        userImage.image = UIImage(systemName: "person")
        userImage.frame = CGRect(x: 20, y: 70, width: 70, height: 70)
        userImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(addUserImage))
        userImage.addGestureRecognizer(tap)
        
//
//        profileView.addSubview(imageButton)
//        imageButton.setTitle("change image", for: .normal)
//        imageButton.setTitleColor(.red, for: .normal)
//        imageButton.addTarget(self, action: #selector(addUserImage), for: .touchUpInside)
//
        profileView.addSubview(userName)
        userName.text = "nn"
//        "\(userNameDis ?? "name")"
        userName.textColor = .black
        
        profileView.addSubview(myTabel)
        myTabel.register(ProfileVCCell.self, forCellReuseIdentifier: "cell")
        myTabel.delegate = self
        myTabel.dataSource = self
//        myTabel.allowsSelection = true
        myTabel.isUserInteractionEnabled = true
        myTabel.rowHeight = 80
//        myTabel.backgroundColor = .systemGray
        myTabel.translatesAutoresizingMaskIntoConstraints = false
        myTabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 200.0).isActive = true
        myTabel.leftAnchor.constraint(equalTo: profileView.leftAnchor, constant: 10.0).isActive = true
        myTabel.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -50.0).isActive = true
        myTabel.rightAnchor.constraint(equalTo: profileView.rightAnchor, constant: -15.0).isActive = true
//        myTabel.setEmptyMasg("no reviews!!")
//        myTabel.separatorStyle = .none
        
     

        
        loginView.addSubview(loginButton)
        loginView.addSubview(signUpLabel)
        loginView.addSubview(signUpButton)
        
//        view.addSubview(loginButton)
        loginButton.backgroundColor = .systemGray
        loginButton.setTitle("LogIn", for: .normal)
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(userLogIn), for: .touchUpInside)
//        loginButton.isHidden = true
        
//        view.addSubview(signUpLabel)
        signUpLabel.text = "don't have an account?"
        signUpLabel.textColor = .black
//        signUpLabel.isHidden = true
        
//        view.addSubview(signUpButton)
        signUpButton.setTitle("SignUP", for: .normal)
        signUpButton.setTitleColor(.blue, for: .normal)
        signUpButton.addTarget(self, action: #selector(userSignUP), for: .touchUpInside)
//        signUpButton.isHidden = true
        
        if Auth.auth().currentUser?.uid != nil {
            profileView.isHidden = false
            loginView.isHidden = true
            
        } else {
            profileView.isHidden = true
            loginView.isHidden = false
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
        let vc = LoginVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    // profileView
    
    @objc func userLogOut() {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to LogOut", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Log Out", style: .default) {_ in
            
            do {
                try Auth.auth().signOut()
                let vc = HomeCateogry()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)

    }
    
 
    func loadUserProfile() {
        if let userId = userID {
            db.collection("Users").document(userId).getDocument { snapshot, error in
                if let error = error {
                    print("!!",error.localizedDescription)
                } else {
                    self.userName.text = snapshot?.get("Name") as? String ?? "no name"
                    let imageStr = snapshot?.get("UserImage") as? String
                    if imageStr == "nil" {
                        self.userImage.image = UIImage(systemName: "person")
                    } else {
                        self.loadImage(imageStr: imageStr!)
                    }
                }
            }
        }
    
    }
    
    
    func loadImage(imageStr: String) {
        let url = "gs://qim-4f02d.appspot.com/images/" + "\(imageStr)"
        let ref = Storage.storage().reference(forURL: url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("no image down")
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
            "UserImage": userImage.image == UIImage(systemName: "person") ? "nil" : updateImageName
        ])
        { error in
            if error == nil {
                print("image added")
            } else {
                print("no image",error)
                
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
                    print("image updated")
                }
            }
        }
        
    }
   
//    func updateImage() {
//        let newData = ["image": uploadImage(pickedImage)]
//        db.collection("Users").whereField("ID", isEqualTo: Auth.auth().currentUser?.uid as Any)
//            .getDocuments { result, error in
//                if error == nil {
//                    for doc in result!.documents {
//                    //    doc.setValue("1", forKey: "isolationDate")
//                        self.db.collection("Users").document(doc.documentID).setData(newData, merge: true)
//                    }
//                }
//            }
//    }
    
    
//    func uploadImage(_ image: UIImage) -> Data {
//
//   let imageData = pickedImage.jpegData(compressionQuality: 0.1)
//        return imageData ?? Data()
//    }
//
    
    
    func loadEx() {
        db.collection("NewEX").getDocuments { [self] (qurysnapshot, error) in
            if let error = error {
                print("no new ex", error.localizedDescription)
            } else {
                for doc in qurysnapshot!.documents {
                    let data = doc.data()
                    print((doc.get("UserID") as? String ?? "nil") == Auth.auth().currentUser?.uid )
                    if (doc.get("UserID") as? String ?? "nil") == Auth.auth().currentUser?.uid {
                        print("!!",(doc.get("UserID") as? String ?? "nil") == Auth.auth().currentUser?.uid )
                   let newEX = Ex(prouductName: data["productName"] as? String ?? "no Pn")
                    self.exArray.append(newEX)
                        print(newEX)
                    }
                    self.myTabel.reloadData()
                    
                    }
                }
            }
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTabel.dequeueReusableCell(withIdentifier: "cell") as! ProfileVCCell
        cell.titleLabel.text = exArray[indexPath.row].prouductName
        cell.backgroundColor = .separator
        return cell
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
    var prouductName: String
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





