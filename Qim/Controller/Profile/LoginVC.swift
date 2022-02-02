//
//  LoginVC.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase



class LoginVC: UIViewController {
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var logButton: UIButton!
    
    let db = Firestore.firestore()
    var userID = Auth.auth().currentUser?.uid
    let imagePicker = UIImagePickerController()
    var updateImageName = "\(UUID().uuidString).png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUP()
        hideKeyboardWhenTappedAround()
        
    }
    
    
    @IBAction func userRestPass(_ sender: Any) {
        performSegue(withIdentifier: "reset", sender: self)
    }
    
    
    
    @IBAction func userLogIn(_ sender: Any) {
        if emailField.text != "" && passField.text != "" {
            Auth.auth().signIn(withEmail: emailField.text!, password: passField.text!) { user, err in
                if err == nil {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tab") as! UITabBarController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                } else {
                    print("user can't login!",err?.localizedDescription)
                    
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
    
    
    
    
    func hideKeyboardWhenTappedAround() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}



extension LoginVC {
    
    func setUP() {
        
        view.addSubview(backView)
        backView.layer.cornerRadius = 20
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 5
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150.0).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400.0).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        
        backView.addSubview(logButton)
        logButton.layer.cornerRadius = 5
        logButton.tintColor = UIColor(named: "Bu")
        logButton.setTitleColor(.black, for: .normal)
        logButton.translatesAutoresizingMaskIntoConstraints = false
        logButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 260.0).isActive = true
        logButton.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -60.0).isActive = true
        logButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        logButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        
    }
    
    
}

