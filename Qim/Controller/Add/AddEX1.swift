//
//  AddEX1.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase

class AddEX1: UIViewController {
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    let userEmail = Auth.auth().currentUser?.email
    
    
    let imagePicker = UIImagePickerController()
    let imageName = "\(UUID().uuidString).png"
    
    
    @IBOutlet weak var productCategory: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var productName: UITextField!
    
    @IBOutlet weak var opinion: UITextView!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var addButton: UIButton!
    
    
    var nameUser = ""
    var imageUser = ""
    
    var newExArray = [Experience]()
    
    var addEx: BrandCategory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productCategory.text = addEx.name
        
        setUp()
        
        imagePicker.delegate = self
        
        hideKeyboardWhenTappedAround()
        
        getUser()
        
    }
    
    @IBAction func addEX(_ sender: Any) {
        addNewEX()
        print(" add ex !!")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tab") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func addNewEX() {
        let exID = UUID().uuidString
        let dayDate = Date()


//        if productImage.image != UIImage(systemName: "timelapse") {
            uploadImage()
//        }
        db.collection("NewEX").document("\(userEmail!)-\(productName.text!)").setData([
//            .addDocument(data: [
            "UserID" : userID!,
            "UserName": nameUser,
            "UserImage": imageUser,
                        "ExID": exID,
            "ExType": productCategory.text!,
            "productName": productName.text!,
            "productImage": imageName,
            "opinion": opinion.text!,
            "creationDate": dayDate
            //            "rate": ratingView
            //                productImage.image == UIImage(systemName: "timelapse") ? "nil": imageName
        ])
        
        { error in
            if error == nil {
                print("new ex")
//                let timestamp: Timestamp = "creationDate" as! Timestamp
//                let datetest: Date = timestamp.dateValue()
                let newEX = Experience(name: self.nameUser, userImage: self.imageUser, productName: self.productName.text!, opinion: self.opinion.text!, productImage: self.imageName)
       
                self.newExArray.append(newEX)
            } else {
                print(error?.localizedDescription)
            }
        }
        
    }
    

    
    
    
    func getUser() {
        if let userId = userID {
            db.collection("Users").document(userId).getDocument { snapShot, error in
                if let error = error {
                    print("e!!",error.localizedDescription)
                } else {
                    self.nameUser = snapShot?.get("UserName") as? String ?? "name nil"
//                    let imgStr
                    self.imageUser = snapShot?.get("UserImage") as? String ?? "image nil"
//                    self.imageUser = imgStr
                    //                    self.getImage(imgStr: imgStr)
                }
            }
        }
    }
    
    
    
    @objc func addImage() {
        
        let alert = UIAlertController(title: nil, message: "add photo from", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "libiray", style: .default) {_ in
            
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
            
        }
        
        let action2 = UIAlertAction(title: "camera", style: .default) { _ in
            print("!!camera!!")
            let cameraView = UIImagePickerController()
            cameraView.delegate = self
            cameraView.sourceType = UIImagePickerController.SourceType.camera
            self.present(cameraView, animated: true, completion: nil)
            cameraView.allowsEditing = true
        }
        alert.addAction(action1)
        alert.addAction(action2)
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func uploadImage() {
        let imageFolder = Storage.storage().reference().child("images")
        if let imageData = productImage.image?.jpegData(compressionQuality: 0.1) {
            imageFolder.child(imageName).putData(imageData, metadata: nil) {
                metaData, error in
                if let error = error {
                    print("!!?",error.localizedDescription)
                } else {
                    print("YEES")
                }
            }
        }
    }
    
    
    
    func hideKeyboardWhenTappedAround() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddEX1.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
  
    
    
}



extension AddEX1: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        productImage.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }
    
}




extension AddEX1 {
    
    func setUp() {
        
        view.addSubview(backView)
        backView.layer.cornerRadius = 20
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 5
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150.0).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170.0).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
        
        backView.addSubview(productName)
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.topAnchor.constraint(equalTo: backView.topAnchor, constant: 40.0).isActive = true
        //        productName.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 30.0).isActive = true
        //        productName.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -150.0).isActive = true
        productName.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20.0).isActive = true
        productName.backgroundColor = UIColor(named: "Bu")
        productName.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        productName.widthAnchor.constraint(equalToConstant: 310.0).isActive = true
        productName.textColor = .black
        
        backView.addSubview(opinion)
        opinion.translatesAutoresizingMaskIntoConstraints = false
        //        opinion.topAnchor.constraint(equalTo: backView.topAnchor, constant: 100.0).isActive = true
        //        opinion.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 30.0).isActive = true
        opinion.topAnchor.constraint(equalTo: backView.topAnchor, constant: 120.0).isActive = true
        opinion.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20.0).isActive = true
        opinion.backgroundColor = UIColor(named: "Bu")
        opinion.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        opinion.widthAnchor.constraint(equalToConstant: 310.0).isActive = true
        opinion.layer.cornerRadius = 5
        opinion.textColor = .black
        
        addButton.setTitle("??????", for: .normal)
        addButton.layer.cornerRadius = 5
        addButton.tintColor = UIColor(named: "Vi")
        addButton.setTitleColor(UIColor(named: "Bu"), for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70.0).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        
        
        backView.addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10.0).isActive = true
        productImage.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 10.0).isActive = true
        productImage.widthAnchor.constraint(equalToConstant: 330.0).isActive = true
        productImage.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        productImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(addImage))
        productImage.addGestureRecognizer(tap)
        productImage.contentMode = .scaleAspectFill
        productImage.layer.cornerRadius = 10
        productImage.clipsToBounds = true
    }
    
    
    
}
