//
//  SignUPVC.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase


class SignUPVC: UIViewController {
    
    
    let userImage = UIImageView()
    let nameField = UITextField(frame: CGRect(x: 70, y: 350, width: 300, height: 40))
    let emailField = UITextField(frame: CGRect(x: 70, y: 400, width: 300, height: 40))
    let passField = UITextField(frame: CGRect(x: 70, y: 450, width: 300, height: 40))
    
    let signButton = UIButton(frame: CGRect(x: 110, y: 600, width: 200, height: 50))
    
    let logLabel = UILabel(frame: CGRect(x: 70, y: 750, width: 200, height: 50))
    let logButton = UIButton(frame: CGRect(x: 260, y: 750, width: 150, height: 50))
    
    let backButton = UIButton(frame: CGRect(x: 0, y: 50, width: 100, height: 50))
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    
    let imagePicker = UIImagePickerController()
    let imageName = "\(UUID().uuidString).png"
    
    var usersArray = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        imagePicker.delegate = self
        
        hideKeyboardWhenTappedAround()
        
        view.addSubview(userImage)
        view.addSubview(emailField)
        view.addSubview(nameField)
        view.addSubview(passField)
        view.addSubview(signButton)
        view.addSubview(logLabel)
        view.addSubview(logButton)
      
        view.addSubview(backButton)
        
        userImage.frame = CGRect(x: 150, y: 200, width: 100, height: 100)
        userImage.image = UIImage(systemName: "person")
        userImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(addImage))
        userImage.addGestureRecognizer(tap)
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = userImage.frame.width/2
        userImage.clipsToBounds = true
        
        nameField.placeholder = "الاسم"
        nameField.backgroundColor = .lightText
        nameField.textAlignment = .right
        
        emailField.placeholder = " البريد الالكتروني"
        emailField.backgroundColor = .lightText
        emailField.textAlignment = .right
        
        passField.placeholder = "  كلمة المرور"
        passField.backgroundColor = .lightText
        passField.isSecureTextEntry = true
        passField.textAlignment = .right
        
        signButton.setTitle("سجل", for: .normal)
        signButton.backgroundColor = .white
        signButton.layer.cornerRadius = 10
        signButton.setTitleColor(.blue, for: .normal)
        signButton.addTarget(self, action: #selector(userSignUp), for: .touchUpInside)
        
        
        logLabel.text = "لديك حساب بالفعل؟"
        logLabel.textColor = .black
        
        logButton.setTitle("سجل الدخول", for: .normal)
        logButton.setTitleColor(.blue, for: .normal)
        logButton.addTarget(self, action: #selector(userLogIn), for: .touchUpInside)
                
        backButton.setTitleColor(.black, for: .normal)
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func userLogIn() {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Lvc") as! LoginVC
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
        let vc = LoginVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func userSignUp() {
        check()
        creatUser()
//        addNewUser(userID: String)()
//        let vc = TabBar()
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func addNewUser(userId: String) {
//        if userImage.image != UIImage(systemName: "person") {
            uploadImage()
//        }
        self.db.collection("Users").document(userId).setData([
            "ID": userId,
            "UserName" : self.nameField.text!,
            "Email": self.emailField.text!,
            "UserImage": imageName
//                userImage.image == UIImage(systemName: "person") ? "nil": imageName
            
        ])
        { err in
            if err == nil {
                print("user added")
                //
                let newUser = User(name: self.nameField.text!, image: self.imageName)
                self.usersArray.append(newUser)
            } else {
                print("no user!",err?.localizedDescription)
            }
        }
    }
    
    func creatUser() {
        Auth.auth().createUser(withEmail: emailField.text!, password: passField.text!) { user, err in
            if err == nil {
                self.addNewUser(userId: (user?.user.uid)!)
//                self.displayUserName()
                let vc = ProfileVc()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            } else {
                print("!!",err?.localizedDescription)
                
            }
        }
    }
    
    
    
    func check() {
        if emailField.text == "" && passField.text == "" && nameField.text == "" {
            let alert = UIAlertController(title: "missing info", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if emailField.text == "" {
            let alert = UIAlertController(title: "missing email", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if passField.text == "" {
            let alert = UIAlertController(title: "missing pass", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if nameField.text == "" {
            let alert = UIAlertController(title: "missing name", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    
    func uploadImage() {
        let imageFolder = Storage.storage().reference().child("images")
        if let imageData = userImage.image?.jpegData(compressionQuality: 0.1) {
            imageFolder.child(imageName).putData(imageData, metadata: nil) {
                metaData, error in
                if let error = error {
                    print("!!",error.localizedDescription)
                } else {
                    print("YEES")
                }
            }
        }
    }
    
    @objc func addImage() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
//    func displayUserName() {
//        let cRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//        cRequest?.displayName = self.nameField.text
//        cRequest?.commitChanges { (err) in
//            if err == nil {
//                print("display done")
//                print(Auth.auth().currentUser?.displayName)
//            } else {
//                print(err)
//            }
//        }
//    }
    
    func hideKeyboardWhenTappedAround() {
       
      let tap = UITapGestureRecognizer(target: self, action: #selector(SignUPVC.dismissKeyboard))
      tap.cancelsTouchesInView = false
      view.addGestureRecognizer(tap)
     }
      
     @objc func dismissKeyboard() {
      view.endEditing(true)
     }
    
}


extension SignUPVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        userImage.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }
    
}


