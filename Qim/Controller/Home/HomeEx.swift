//
//  HomeEx.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase


// butoons acction
// star action

class HomeEx: UIViewController {
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    
    var nameUser = ""
    var imageUser = ""
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productName: UILabel!

    @IBOutlet weak var opiView: UIView!
    @IBOutlet weak var opinion: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
   
    @IBOutlet weak var backButton: UIButton!


    var homeex: AllEX!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backView)
        backView.layer.cornerRadius = 20
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 5
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170.0).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
       
        
        backView.addSubview(productView)
        productView.layer.cornerRadius = 10
//        productView.backgroundColor = UIColor(named: "Bu")
        productView.translatesAutoresizingMaskIntoConstraints = false
        productView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20.0).isActive = true
        productView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20.0).isActive = true
        productView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -500.0).isActive = true
        productView.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20.0).isActive = true
       
        
        backView.addSubview(opiView)
        opiView.layer.cornerRadius = 10
        opiView.translatesAutoresizingMaskIntoConstraints = false
        opiView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 100.0).isActive = true
        opiView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20.0).isActive = true
        opiView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -20.0).isActive = true
        opiView.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20.0).isActive = true
       
        
        productView.addSubview(productName)
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.topAnchor.constraint(equalTo: productView.topAnchor, constant: 3.0).isActive = true
//        productName.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 30.0).isActive = true
//        productName.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -150.0).isActive = true
        productName.rightAnchor.constraint(equalTo: productView.rightAnchor, constant: -50.0).isActive = true
//        productName.backgroundColor = UIColor(named: "Bu")
        productName.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        productName.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        productName.textColor = .black
       
        opiView.addSubview(opinion)
        opinion.translatesAutoresizingMaskIntoConstraints = false
//        opinion.topAnchor.constraint(equalTo: backView.topAnchor, constant: 100.0).isActive = true
//        opinion.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 30.0).isActive = true
        opinion.bottomAnchor.constraint(equalTo: opiView.bottomAnchor, constant: -30.0).isActive = true
        opinion.rightAnchor.constraint(equalTo: opiView.rightAnchor, constant: -20.0).isActive = true
//        opinion.backgroundColor = UIColor(named: "Bu")
        opinion.heightAnchor.constraint(equalToConstant: 450.0).isActive = true
        opinion.widthAnchor.constraint(equalToConstant: 280.0).isActive = true
        opinion.textColor = .black
        
        saveButton.setTitle("حفظ", for: .normal)
        saveButton.layer.cornerRadius = 5
        saveButton.tintColor = UIColor(named: "Vi")
        saveButton.setTitleColor(UIColor(named: "Bu"), for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90.0).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
       
        backButton.setTitle("الرجوع", for: .normal)
        backButton.layer.cornerRadius = 5
        backButton.tintColor = UIColor(named: "Vi")
        backButton.setTitleColor(UIColor(named: "Bu"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90.0).isActive = true
        backButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -200.0).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        
           
        viewHomeEx()
//        getUser()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
print("back??")
        
    }

    @IBAction func saveToFav(_ sender: Any) {
        
        //        let vc = AddEX1()
                db.collection("Saved").addDocument(data: [
                    "UserID": userID,
        //            "UserName": ,
        //            "UserImage": ,
                    "productName" : productName.text!,
                    "opi": opinion.text!
                ])
                { error in
                    if error == nil {
                        print("new saved")
                    } else {
                        print(error?.localizedDescription)
                    }
                }
                print("saved!!")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tab") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
//    func getUser() {
//        if let userId = userID {
//        db.collection("Users").document().getDocument { snapShot, error in
//                if let error = error {
//                    print("e!!",error.localizedDescription)
//                } else {
//                    self.nameUser = snapShot?.get("UserName") as? String ?? "name nil"
//                    let imgStr = snapShot?.get("UserImage") as? String ?? "image nil"
//                    self.imageUser = imgStr
////                    self.getImage(imgStr: imgStr)
//                }
//            }
//        }
//    }

    func viewHomeEx() {
        productName.text = homeex.productname
        opinion.text = homeex.opinion
    }
    
 
    
}



