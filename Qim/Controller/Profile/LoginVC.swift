//
//  LoginVC.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase



class LoginVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var passField: UITextField!
    
    @IBOutlet weak var logButton: UIButton!
    
    
    @IBOutlet weak var forButton: UIButton!
    
    @IBOutlet weak var signLabel: UILabel!
    
    
    @IBOutlet weak var signButton: UIButton!
    
    
    let db = Firestore.firestore()
        var userID = Auth.auth().currentUser?.uid
    let imagePicker = UIImagePickerController()
    var updateImageName = "\(UUID().uuidString).png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backView)
        backView.layer.cornerRadius = 20
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 5
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140.0).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400.0).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        
        
        emailField.backgroundColor = UIColor(named: "Bu")
        passField.backgroundColor = UIColor(named: "Bu")
        
        forButton.tintColor = .white

//        logButton.setTitle("back", for: .normal)
        logButton.layer.cornerRadius = 5
        logButton.tintColor = UIColor(named: "Vi")
//        logButton.setTitleColor(.black, for: .normal)
        logButton.translatesAutoresizingMaskIntoConstraints = false
        logButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 500.0).isActive = true
        logButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90.0).isActive = true
        logButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        logButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
       
        signButton.tintColor = UIColor(named: "Bu")

        
        hideKeyboardWhenTappedAround()
        
        
    }
    
    @IBAction func forgotPass(_ sender: Any) {
            let vc = ForgotPassVC()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    
//
//    @objc func forgotPass() {
//        let vc = ForgotPassVC()
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true, completion: nil)
//    }
    
    
    
    @IBAction func userLogIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passField.text!) { user, err in
            if err == nil {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "tab") as! UITabBarController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
//                self.performSegue(withIdentifier: "log", sender: self)
//                let vc = ProfileVc()
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true, completion: nil)
            } else {
                print("can't login!", err?.localizedDescription)
                self.check()
                
                let alert = UIAlertController(title: "there is no account with this email", message: "pleas signup" , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
//    @objc func userLogIn() {
//        Auth.auth().signIn(withEmail: emailField.text!, password: passField.text!) { user, err in
//            if err == nil {
//                self.performSegue(withIdentifier: "log", sender: self)
////                let vc = ProfileVc()
////                vc.modalPresentationStyle = .fullScreen
////                self.present(vc, animated: true, completion: nil)
//            } else {
//                print("can't login!", err?.localizedDescription)
//                self.check()
//
//                let alert = UIAlertController(title: "there is no account with this email", message: "pleas signup" , preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
//    }
    
 
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
    
  
    @IBAction func userSignUp(_ sender: Any) {
        let vc = SignUPVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
//    @objc func userSignUp() {
//        let vc = SignUPVC()
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true, completion: nil)
//    }
    
    
   
    
    
    func hideKeyboardWhenTappedAround() {
       
      let tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
      tap.cancelsTouchesInView = false
      view.addGestureRecognizer(tap)
     }
      
     @objc func dismissKeyboard() {
      view.endEditing(true)
     }
    
}
