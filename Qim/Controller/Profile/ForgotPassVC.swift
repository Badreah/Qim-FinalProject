//
//  ForgotPassVC.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase

class ForgotPassVC: UIViewController {
    
    
    @IBOutlet weak var resetEmailField: UITextField!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        hideKeyboardWhenTappedAround()
        
    }
    
    
    
    @IBAction func userResetPassword(_ sender: Any) {
        
        Auth.auth().sendPasswordReset(withEmail: resetEmailField.text!) { (error) in
            if error != nil {
                if self.resetEmailField.text != "" {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "تنبيه", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                print("can't reset pass", error?.localizedDescription)
            }
        }
    }
    
    
    
    
    func hideKeyboardWhenTappedAround() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ForgotPassVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}


extension ForgotPassVC {
    
    func setUp() {
        
        view.addSubview(backView)
        backView.layer.cornerRadius = 20
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 5
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250.0).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400.0).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        
        
        backView.addSubview(resetButton)
        resetButton.layer.cornerRadius = 5
        resetButton.tintColor = UIColor(named: "Bu")
        resetButton.setTitleColor(.black, for: .normal)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 150.0).isActive = true
        resetButton.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -60.0).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        
    }
    
    
    
}
