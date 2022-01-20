//
//  UserEx.swift
//  Qim
//
//  Created by Badreah Saad on 18/01/2022.
//

import UIKit
import Firebase

class UserEx: UIViewController {
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var opinion: UITextView!
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var deletButton: UIButton!
    
  
    var userEx: Ex!
    
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
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150.0).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        
        backView.addSubview(productName)
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.topAnchor.constraint(equalTo: backView.topAnchor, constant: 30.0).isActive = true
//        productName.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 30.0).isActive = true
//        productName.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -150.0).isActive = true
        productName.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -40.0).isActive = true
        productName.backgroundColor = UIColor(named: "Bu")
        productName.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        productName.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        productName.textColor = .black
       
        backView.addSubview(opinion)
        opinion.translatesAutoresizingMaskIntoConstraints = false
//        opinion.topAnchor.constraint(equalTo: backView.topAnchor, constant: 100.0).isActive = true
//        opinion.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 30.0).isActive = true
        opinion.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -30.0).isActive = true
        opinion.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20.0).isActive = true
        opinion.backgroundColor = UIColor(named: "Bu")
        opinion.heightAnchor.constraint(equalToConstant: 450.0).isActive = true
        opinion.widthAnchor.constraint(equalToConstant: 280.0).isActive = true
        opinion.layer.cornerRadius = 5
        opinion.textColor = .black
        
        updateButton.setTitle("update", for: .normal)
        updateButton.layer.cornerRadius = 5
        updateButton.tintColor = UIColor(named: "Vi")
        updateButton.setTitleColor(UIColor(named: "Bu"), for: .normal)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        updateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70.0).isActive = true
        updateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        updateButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        updateButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
       
        
        deletButton.setTitle("delet", for: .normal)
        deletButton.layer.cornerRadius = 5
        deletButton.tintColor = UIColor(named: "Vi")
        deletButton.setTitleColor(UIColor(named: "Bu"), for: .normal)
        deletButton.translatesAutoresizingMaskIntoConstraints = false
        deletButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70.0).isActive = true
        deletButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -200.0).isActive = true
        deletButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        deletButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        
        
        viewUserEx()
        
    }
    
    
    func viewUserEx() {
        productName.text = userEx.productName
        opinion.text = userEx.opi
//        pros.text = userEx.pro
//        cons.text = userEx.con
    }
    
    
    @IBAction func updateEX(_ sender: Any) {
        
        db.collection("NewEX").document().updateData([
//            AnyHashable : Any]
//                                                            , completion: <#T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void#>)
//            .document().updateData([
//            AnyHashable : Any])
//            .setData([
//            String : Any])
//            .addDocument(data: [
            "UserID" : userID!,
            "productName": productName.text!,
            "opi": opinion.text!
//                "pro": pros.text!,
//                "con": cons.text!
//            "productImage": imageName
        ])
        { error in
            if error == nil {
                print("update ex")
            } else {
                print("can't update!!",error?.localizedDescription)
            }
        }

        print("!! updated !!")
        dismiss(animated: true)
    }
    
    @IBAction func deletEx(_ sender: Any) {
    }
    
  
    
    
//            @objc func updateEx() {
//                db.collection("NewEX").getDocuments { [self] (qurysnapshot, error) in
//                    if let error = error {
//                        print("no new ex!", error.localizedDescription)
//                    } else {
//                        for doc in qurysnapshot!.documents {
//                            let data = doc.data()
//
//                            if ("productName") == productName.text {
//    //                        self.productName.text = data["productName"] as? String ?? "no product!"
//                            self.opinion.text = data["opi"] as? String ?? "no opi!"
//                            self.pros.text = data["pro"] as? String ?? "no pro!"
//                            self.cons.text = data["con"] as? String ?? "no con!"
//                            }
//            }
//                    }
//                }
//                        print("!! updated !!")
//                        dismiss(animated: true)
//            }
    
    
//    @objc func updateEx() {
//        let newData = [
//            "opi": opinion.text,
//            "pro": pros.text,
//            "con": cons.text
//        ]
//        db.collection("NewEX")
//            .whereField("productName", isEqualTo: productName.text)
//            .getDocuments() { [self]
//                (qurySnapShot, err) in
//                if let err = err {
//                    print(err.localizedDescription)
//                } else {
//                    for doc in qurySnapShot!.documents {
////                        let data = doc.data()
////                        self.opinion.text = data["opi"] as? String ?? "no opi!"
////                        self.pros.text = data["pro"] as? String ?? "no pro!"
////                        self.cons.text = data["con"] as? String ?? "no con!"
//                        db.collection("NewEX").document().setData(newData, merge: true)
//                    }
//                }
//            }
//        print("!! updated !!")
//                           dismiss(animated: true)
//    }
    
    
    
    
    //
    //    @objc func deletEX() {
    //        db.collection("NewEX").document("EX").updateData([
    //            "productName": productName.delete(productName.text),
    //            "opi": opinion.delete(opinion.text),
    //            "pro": pros.delete(pros.text) ,
    //            "con": cons.delete(cons.text)
    ////            "capital": FieldValue.delete(),
    //        ]) { error in
    //            if let error = error {
    //                print("Error updating document: \(error)")
    //            } else {
    //                print("Document successfully updated!!")
    //            }
    //        }
    //        print("!! deleted !!")
    //        dismiss(animated: true)
    //
    //    }
    //
    
    
    
}




