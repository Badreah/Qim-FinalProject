//
//  settings.swift
//  Qim
//
//  Created by Badreah Saad on 20/01/2022.
//

import UIKit
import Firebase


class Settings: UIViewController {
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var logOut: UIButton!
    
    @IBOutlet weak var deleteAccount: UIButton!
    @IBOutlet weak var changePass: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.addSubview(backView)
        backView.layer.cornerRadius = 20
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 5
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170.0).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40.0).isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -220.0).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40.0).isActive = true
        
        
        backView.addSubview(logOut)
        logOut.setTitle("تسجيل الخروج", for: .normal)
        logOut.layer.cornerRadius = 10
        logOut.tintColor = UIColor(named: "Bu")
//        logOut.backgroundColor = UIColor(named: "Bu")
        logOut.setTitleColor(.black, for: .normal)
        logOut.translatesAutoresizingMaskIntoConstraints = false
        logOut.topAnchor.constraint(equalTo: backView.topAnchor, constant: 80.0).isActive = true
        logOut.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -30.0).isActive = true
        logOut.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        logOut.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        
        backView.addSubview(changePass)
        changePass.setTitle("تغيير كلمة المرور", for: .normal)
        changePass.layer.cornerRadius = 10
        changePass.tintColor = UIColor(named: "Bu")
//        logOut.backgroundColor = UIColor(named: "Bu")
        changePass.setTitleColor(.black, for: .normal)
        changePass.translatesAutoresizingMaskIntoConstraints = false
        changePass.topAnchor.constraint(equalTo: backView.topAnchor, constant: 200.0).isActive = true
        changePass.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -30.0).isActive = true
        changePass.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        changePass.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
       
        
        backView.addSubview(deleteAccount)
        deleteAccount.setTitle("حذف الحساب", for: .normal)
        deleteAccount.layer.cornerRadius = 10
        deleteAccount.tintColor = UIColor(named: "Bu")
//        logOut.backgroundColor = UIColor(named: "Bu")
        deleteAccount.setTitleColor(.black, for: .normal)
        deleteAccount.translatesAutoresizingMaskIntoConstraints = false
        deleteAccount.topAnchor.constraint(equalTo: backView.topAnchor, constant: 320.0).isActive = true
        deleteAccount.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -30.0).isActive = true
        deleteAccount.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        deleteAccount.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
       

    }
    

    @IBAction func userLogOut(_ sender: Any) {
        
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
    print("tapped")
       
    }
    
    
    @IBAction func userChangePass(_ sender: Any) {
        
        var newPassword = UITextField()

        let alert = UIAlertController(title: "Update", message: "", preferredStyle: .alert)
        alert.addTextField { alerttext in
            alerttext.placeholder = "add new"
            newPassword = alerttext
        }
      
       
        let action = UIAlertAction(title: "save update", style: .default) { action in
    //        self.achievementsArray[indexPath.row].setValue(textField.text!, forKey: "title")
    //        self.saveData()
            Auth.auth().currentUser?.updatePassword(to: newPassword.text!) { error in
                if error == nil {
                    print("changed")
                } else {
                    print("error!", error?.localizedDescription)
                }
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
       
   
    
    
    
    
    
    
    @IBAction func userDeleteAccount(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: "Are you sure you want to delete your account ?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Delete", style: .default) {_ in
            let user = Auth.auth().currentUser
            
            user?.delete { error in
                if let error = error {
                    print("can't be deleted!", error.localizedDescription)
                } else {
                    print("acouunt deleted!!")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tab") as! UITabBarController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)

    }
    
    func hideKeyboardWhenTappedAround() {
       
      let tap = UITapGestureRecognizer(target: self, action: #selector(Settings.dismissKeyboard))
      tap.cancelsTouchesInView = false
      view.addGestureRecognizer(tap)
     }
      
     @objc func dismissKeyboard() {
      view.endEditing(true)
     }
    
    
    
}
