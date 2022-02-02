//
//  HomeEx.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase



class HomeEx: UIViewController {
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    
    var nameUser = ""
    var imageUser = ""
    
    let imageName = "\(UUID().uuidString).png"

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var opiView: UIView!
    
    @IBOutlet weak var opinion: UITextView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var saveButton: UIButton!

    var homeex: AllEX!
    
    var userSaveEx = [SavedExperience]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
//        print(homeex.productImage)
//        loadImage(imageStr: homeex.productImage)

        viewHomeEx()
        //        getUser()
        self.loadImage(imageStr: homeex.productImage)
        
    }
    
  
   
    
    
    
    @IBAction func saveToFav(_ sender: Any) {
        
        if Auth.auth().currentUser?.uid == nil {
            
            let alert = UIAlertController(title: "", message: "الرجاء تسجيل الدخول حتى تتمكن من المتابعة", preferredStyle: .alert)
            let action = UIAlertAction(title: "حسناً", style: .default) { _ in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "profileVc") as! ProfileVc
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
                            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
       
        } else {
        uploadImage()
        db.collection("Saved").addDocument(data: [
            "UserID": userID,
            "UserName": nameUser,
            "UserImage": imageUser,
            "productName" : productName.text!,
            "opinion": opinion.text!,
            "productImage": imageName,

        ])
        { error in
            if error == nil {
                print("new saved")
                let saveEX = SavedExperience(name: self.nameUser, userImage: self.imageUser, productName: self.productName.text!, opinion: self.opinion.text!, productImage: self.imageName)
                
                self.userSaveEx.append(saveEX)
            } else {
                print(error?.localizedDescription)
            }
        }
        print("saved!!")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tab") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    }
    
    
    func uploadImage() {
        let imageFolder = Storage.storage().reference().child("images")
        if let imageData = productImage.image?.jpegData(compressionQuality: 0.1) {
            imageFolder.child(imageName).putData(imageData, metadata: nil) {
                metaData, error in
                if let error = error {
                    print("!!?",error.localizedDescription)
                } else {
                    print("??YEES??")
                }
            }
        }
    }
    
    func loadImage(imageStr: String) {
        let url = "gs://qim-4f02d.appspot.com/images/" + "\(imageStr)"
        let ref = Storage.storage().reference(forURL: url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("no image down!")
                print(error?.localizedDescription)
            } else {
                self.productImage.image = UIImage(data: data!)
            }
        }
    }
    

    
    func viewHomeEx() {
        productName.text = homeex.productname
        opinion.text = homeex.opinion

    }
    
    
    
}




extension HomeEx {
    
    func setUp() {
        
        view.addSubview(backView)
        backView.layer.cornerRadius = 20
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 5
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120.0).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170.0).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
        
        
        backView.addSubview(productView)
        productView.layer.cornerRadius = 10
        //        productView.backgroundColor = UIColor(named: "Bu")
        productView.translatesAutoresizingMaskIntoConstraints = false
        productView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 40.0).isActive = true
        productView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20.0).isActive = true
        productView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -470.0).isActive = true
        productView.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20.0).isActive = true
        
        
        backView.addSubview(opiView)
        opiView.layer.cornerRadius = 10
        opiView.translatesAutoresizingMaskIntoConstraints = false
        opiView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 120.0).isActive = true
        opiView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20.0).isActive = true
        opiView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -210.0).isActive = true
        opiView.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20.0).isActive = true
        
        
        productView.addSubview(productName)
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.topAnchor.constraint(equalTo: productView.topAnchor, constant: 3.0).isActive = true
        //        productName.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 30.0).isActive = true
        //        productName.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -150.0).isActive = true
        productName.rightAnchor.constraint(equalTo: productView.rightAnchor, constant: -50.0).isActive = true
        //        productName.backgroundColor = UIColor(named: "Bu")
        productName.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        productName.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        productName.textColor = .black
        
        opiView.addSubview(opinion)
        opinion.translatesAutoresizingMaskIntoConstraints = false
        opinion.topAnchor.constraint(equalTo: opiView.topAnchor, constant: 10.0).isActive = true
        //        opinion.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 30.0).isActive = true
        //        opinion.bottomAnchor.constraint(equalTo: opiView.bottomAnchor, constant: -30.0).isActive = true
        opinion.rightAnchor.constraint(equalTo: opiView.rightAnchor, constant: -20.0).isActive = true
        //        opinion.backgroundColor = UIColor(named: "Bu")
        opinion.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        opinion.widthAnchor.constraint(equalToConstant: 280.0).isActive = true
        opinion.textColor = .black
        opinion.textAlignment = .right
        opinion.backgroundColor = UIColor(named: "Bu")
        opinion.layer.cornerRadius = 10
        opinion.isEditable = false

        
        saveButton.setTitle("حفظ", for: .normal)
        saveButton.layer.cornerRadius = 5
        saveButton.tintColor = UIColor(named: "Vi")
        saveButton.setTitleColor(UIColor(named: "Bu"), for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70.0).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        
         
        backView.addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10.0).isActive = true
        productImage.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 10.0).isActive = true
        productImage.widthAnchor.constraint(equalToConstant: 330.0).isActive = true
        productImage.heightAnchor.constraint(equalToConstant: 170.0).isActive = true
        productImage.contentMode = .scaleAspectFill
        productImage.layer.cornerRadius = 10
        productImage.clipsToBounds = true
        
    }
    
    
    
}
