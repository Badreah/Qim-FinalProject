//
//  ForgotPassVC.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase

class ForgotPassVC: UIViewController {
    
    let resetEmail = UITextField(frame: CGRect(x: 60, y: 300, width: 300, height: 50))
    let resetButton = UIButton(frame: CGRect(x: 150, y: 500, width: 100, height: 50))
    let backButton = UIButton(frame: CGRect(x: 10, y: 50, width: 50, height: 50))
 
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(resetEmail)
        resetEmail.placeholder = "  Email"
        resetEmail.backgroundColor = .systemGray
        
        view.addSubview(resetButton)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.black, for: .normal)
        resetButton.backgroundColor = .white
        resetButton.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        
        view.addSubview(backButton)
        backButton.setTitle("<", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func resetPassword(){
        Auth.auth().sendPasswordReset(withEmail: resetEmail.text!) { (error) in
            if error != nil {
                if self.resetEmail.text != "" {
                self.dismiss(animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "تنبيه", message: "", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                print("can't reset", error?.localizedDescription)
            }
        }
    }
    
    
}
