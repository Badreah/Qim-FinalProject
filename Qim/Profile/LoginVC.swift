//
//  LoginVC.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase



class LoginVC: UIViewController {
    
    let emailField = UITextField(frame: CGRect(x: 70, y: 200, width: 300, height: 40))
    let passField = UITextField(frame: CGRect(x: 70, y: 250, width: 300, height: 40))
    
    let logButton = UIButton(frame: CGRect(x: 110, y: 600, width: 200, height: 50))
    
    let forButton = UIButton(frame: CGRect(x: 100, y: 300, width: 200, height: 50))
    
    let signLabel = UILabel(frame: CGRect(x: 70, y: 750, width: 200, height: 50))
    let signButton = UIButton(frame: CGRect(x: 260, y: 750, width: 70, height: 50))
    
    let backButton = UIButton(frame: CGRect(x: 0, y: 50, width: 100, height: 50))
    
    
    let db = Firestore.firestore()
        var userID = Auth.auth().currentUser?.uid
    let imagePicker = UIImagePickerController()
    var updateImageName = "\(UUID().uuidString).png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        imagePicker.delegate = self

        view.addSubview(emailField)
        view.addSubview(passField)
        view.addSubview(logButton)
        view.addSubview(forButton)
        view.addSubview(signLabel)
        view.addSubview(signButton)
        view.addSubview(backButton)
        
        
        emailField.placeholder = "  email"
        emailField.backgroundColor = .lightText
        
        passField.placeholder = "  password"
        passField.backgroundColor = .lightText
        
        logButton.setTitle("LogIn", for: .normal)
        logButton.backgroundColor = .white
        logButton.layer.cornerRadius = 10
        logButton.setTitleColor(.blue, for: .normal)
        logButton.addTarget(self, action: #selector(userLogIn), for: .touchUpInside)
        
        forButton.setTitle("forgot Password?", for: .normal)
        forButton.setTitleColor(.blue, for: .normal)
        forButton.addTarget(self, action: #selector(forgotPass), for: .touchUpInside)
        
        
        signLabel.text = "don't have an account?"
        signLabel.textColor = .black
        
        signButton.setTitle("SignUp", for: .normal)
        signButton.setTitleColor(.blue, for: .normal)
        signButton.addTarget(self, action: #selector(userSignUp), for: .touchUpInside)
        
        backButton.setTitleColor(.black, for: .normal)
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        //        hideKeyboardWhenTappedAround()
        
        
    }
    
    
    @objc func forgotPass() {
        let vc = ForgotPassVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func userLogIn() {
        Auth.auth().signIn(withEmail: emailField.text!, password: passField.text!) { user, err in
            if err == nil {
                let vc = HomeCateogry()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            } else {
                print("can't login!", err?.localizedDescription)
                self.check()
                
                let alert = UIAlertController(title: "there is no account with this email", message: "pleas signup" , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
 
    func check() {
       if emailField.text == "" && passField.text == "" {
            let alert = UIAlertController(title: "missing email & pass", message: "", preferredStyle: .alert)
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
    }
    
  
    
    @objc func userSignUp() {
        let vc = SignUPVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    //    func hideKeyboardWhenTappedAround() {
    //
    //        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
    //        tap.cancelsTouchesInView = false
    //        view.addGestureRecognizer(tap)
    //    }
    //
    //    @objc func dismissKeyboard() {
    //        view.endEditing(true)
    //    }
    
    
 

    
}
