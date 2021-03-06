//
//  ViewController.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase

class ProfileVc: UIViewController {
    
    let db = Firestore.firestore()
    var userID = Auth.auth().currentUser?.uid
    let imagePicker = UIImagePickerController()
    var updateImageName = "\(UUID().uuidString).png"
    
    
    let loginView: UIView = {
        let loginView = UIView()
        return loginView
    }()
    
    let loginButton = UIButton()
    
    
    let signUpButton = UIButton()
    
    @IBOutlet weak var lView: UIView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var pView: UIView!
    
    let profileView: UIView = {
        let profileView = UIView()
        return profileView
    }()
    
    let setting = UIButton()
    var userImage = UIImageView()
    var userName = UILabel()
    let myTabel = UITableView()
    let emptyView = UIView()
    
    var experienceArray = [Experience]()
    let refreshC = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginView)
        loginView.isHidden = true
        
        view.addSubview(profileView)
        profileView.isHidden = true
        
        //        loginView.addSubview(lView)
        //        lView.isHidden = true
        
        if Auth.auth().currentUser?.uid != nil {
            profileView.isHidden = false
            loginView.isHidden = true
            lView.isHidden = true
            
        } else {
            profileView.isHidden = true
            loginView.isHidden = false
            labelView.isHidden = true
            pView.isHidden = true
            //            lView.isHidden = false
            
        }
        
        
        imagePicker.delegate = self
        
        setUp()
        
        hideKeyboardWhenTappedAround()
        
        loadUserProfile()
        loadEx()
        
        refreshC.attributedTitle = NSAttributedString(string: "pull to refresh")
        refreshC.addTarget(self, action: #selector(ref(_:)), for: .valueChanged)
        myTabel.addSubview(refreshC)
        
    }
    
    @objc func ref(_ sender: AnyObject){
        experienceArray.removeAll()
        loadEx()
        refreshC.endRefreshing()
    }
    
    
    // loginView
    @objc func userSignUP() {
        performSegue(withIdentifier: "signVc", sender: self)
    }
    
    @objc func userLogIn() {
        performSegue(withIdentifier: "logVc", sender: self)
    }
    
    
    
    
    // profileView
    @objc func userSetting() {
        performSegue(withIdentifier: "set", sender: self)
        print("??set??")
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
        db.collection("NewEX").order(by: "creationDate", descending: true)
            .getDocuments { [self] (qurysnapshot, error) in
                if let error = error {
                    print("no new ex!", error.localizedDescription)
                } else {
                    for doc in qurysnapshot!.documents {
                        let data = doc.data()
                        let timestamp: Timestamp = data["creationDate"] as! Timestamp
                        let datetest: Date = timestamp.dateValue()
                        print((doc.get("UserID") as? String ?? "nil!") == Auth.auth().currentUser?.uid )
                        if (doc.get("UserID") as? String ?? "nil!") == Auth.auth().currentUser?.uid {
                            print("!!",(doc.get("UserID") as? String ?? "nil!") == Auth.auth().currentUser?.uid )
                            
                            let newEX = Experience(name: data["UserName"] as? String ?? "no na",
                                                   userImage: data["UserImage"] as? String ?? "no img",
                                                   productName: data["productName"] as? String ?? "no product",
                                                   opinion: data["opinion"] as? String ?? "no opi",
                                                   productImage: data["productImage"] as? String ?? "no Pro img",
                                                   creationDate: datetest)
                            
                            self.experienceArray.append(newEX)
                            print(newEX)
                        }
                        self.myTabel.reloadData()
                        
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
    
    
    
    
    func hideKeyboardWhenTappedAround() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileVc.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
}


extension ProfileVc: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if experienceArray.count == 0 {
            myTabel.setEmptyMessage("???? ?????? ???????????? ?????????????? ?????? ")
        } else {
            myTabel.restore()
        }
        return experienceArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTabel.dequeueReusableCell(withIdentifier: "cell") as! ProfileVCCell
        cell.productName.text = experienceArray[indexPath.row].productName
        
        let date = experienceArray[indexPath.row].creationDate
        var stringDate = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        stringDate =  formatter.string(from: date ?? Date())
        //
        
        cell.creationDate.text = stringDate
        
        cell.share.addTarget(self, action: #selector(shareToButton), for: .touchUpInside)
        
        cell.backgroundColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "userEx") as! UserEx
        vc.modalPresentationStyle = .fullScreen
        vc.userEx = experienceArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        //        self.present(vc, animated: true, completion: nil)
        
        print("??")
    }
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let userEmail = Auth.auth().currentUser!.email!
        
        if (editingStyle == .delete) {
            db.collection("NewEX").document("\(userEmail)-\(experienceArray[indexPath.row].productName)").delete()
            { error in
                if let error = error {
                    print("??Error removing document",error.localizedDescription)
                } else {
                    let alert = UIAlertController(title: "", message: "???? ?????? ???????????? ??????????", preferredStyle: .alert)
                    let action = UIAlertAction(title: "????????", style: .default ,handler: { action in
                        self.myTabel.reloadData()
                    })
                    alert.addAction(action)
                    self.present(alert, animated: true)
                    print("Document successfully removed!!!")
                }
            }
        }
        
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




extension ProfileVc {
    
    func setUp() {
        
        //login view
        
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30.0).isActive = true
        loginView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20.0).isActive = true
        loginView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -0.0).isActive = true
        
        loginView.addSubview(loginButton)
        loginButton.backgroundColor = UIColor(named: "Bu")
        loginButton.setTitle("?????????? ????????????", for: .normal)
        loginButton.setTitleColor(UIColor(named: "Vi"), for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(userLogIn), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 300.0).isActive = true
        loginButton.rightAnchor.constraint(equalTo: loginView.rightAnchor, constant: -70.0).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        
        loginView.addSubview(signUpButton)
        signUpButton.backgroundColor = UIColor(named: "Bu")
        signUpButton.setTitle("?????????? ???????? ????????", for: .normal)
        signUpButton.setTitleColor(UIColor(named: "Vi"), for: .normal)
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(userSignUP), for: .touchUpInside)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 440.0).isActive = true
        signUpButton.rightAnchor.constraint(equalTo: loginView.rightAnchor, constant: -70.0).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        
        
        //profile view
        
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30.0).isActive = true
        profileView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        profileView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20.0).isActive = true
        profileView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -0.0).isActive = true
        
        profileView.addSubview(setting)
        //        setting.setTitle("????????????????", for: .normal)
        setting.setImage(UIImage(named: "set2"), for: .normal)
        //        setting.setTitleColor(UIColor(named: "Bu"), for: .normal)
        //        setting.tintColor = .red
        setting.heightAnchor.constraint(equalToConstant: 40).isActive = true
        setting.widthAnchor.constraint(equalToConstant: 40).isActive = true
        setting.layer.cornerRadius = 10
        setting.addTarget(self, action: #selector(userSetting), for: .touchUpInside)
        setting.translatesAutoresizingMaskIntoConstraints = false
        setting.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 30.0).isActive = true
        setting.leftAnchor.constraint(equalTo: profileView.leftAnchor, constant: 330.0).isActive = true
        
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
        myTabel.rowHeight = 80
        myTabel.backgroundColor = .white
        myTabel.layer.cornerRadius = 10
        myTabel.layer.masksToBounds = true
        myTabel.translatesAutoresizingMaskIntoConstraints = false
        myTabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 225.0).isActive = true
        myTabel.leftAnchor.constraint(equalTo: profileView.leftAnchor, constant: 20.0).isActive = true
        myTabel.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -80.0).isActive = true
        myTabel.rightAnchor.constraint(equalTo: profileView.rightAnchor, constant: -20.0).isActive = true
        
        
        
        
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
    
    
    
}







