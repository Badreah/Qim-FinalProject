//
//  SignUPVC.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase


class SignUPVC: UIViewController {
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var signButton: UIButton!
    
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    
    let imagePicker = UIImagePickerController()
    let imageName = "\(UUID().uuidString).png"
    
    var usersArray = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        setUp()
        
        hideKeyboardWhenTappedAround()
  
    }
    
    
    @IBAction func userSignUp(_ sender: Any) {
        
        if emailField.text != "" && passField.text != "" {
        Auth.auth().createUser(withEmail: emailField.text!, password: passField.text!) { user, err in
            if err == nil {
                self.addNewUser(userId: (user?.user.uid)!)
                self.performSegue(withIdentifier: "sign", sender: self)
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "tab") as! UITabBarController
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true, completion: nil)

//                let vc = ProfileVc()
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true, completion: nil)
            } else {
                print("!!",err?.localizedDescription)
                let alert = UIAlertController(title: "تنبيه", message: err?.localizedDescription, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
            }
        }
        } else {
            let alert = UIAlertController(title: "البيانات غير مكتملة", message: "الرجاء التأكد من إدخال البريد الإلكتروني و كلمة المرور", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
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




extension SignUPVC {
    
    func setUp() {
        
        view.addSubview(backView)
        backView.layer.cornerRadius = 20
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 5
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170.0).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -330.0).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        
        backView.addSubview(userImage)
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        userImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 130.0).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 130.0).isActive = true
        userImage.image = UIImage(systemName: "person")
        userImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(addImage))
        userImage.addGestureRecognizer(tap)
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = userImage.frame.width/2
        userImage.clipsToBounds = true
        
        
        backView.addSubview(signButton)
        signButton.layer.cornerRadius = 5
        signButton.tintColor = UIColor(named: "Bu")
        signButton.translatesAutoresizingMaskIntoConstraints = false
        signButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 320.0).isActive = true
        signButton.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -60.0).isActive = true
        signButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        signButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
       
    }
    
    
    
}
