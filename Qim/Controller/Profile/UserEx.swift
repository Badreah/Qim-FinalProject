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
    
    
    let imagePicker = UIImagePickerController()
    let imageName = "\(UUID().uuidString).png"
    
   
    
    @IBOutlet weak var backView: UIView!
 
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var opinion: UITextView!
    @IBOutlet weak var productImage: UIImageView!
    
    
    @IBOutlet weak var update: UIButton!
    
    var userEx: Experience!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadImage(imageStr: userEx.productImage)

        imagePicker.delegate = self

        setUp()
        
        hideKeyboardWhenTappedAround()
        
        viewUserEx()
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
    
    
    func viewUserEx() {
        productName.text = userEx.productName
        opinion.text = userEx.opinion
    }
    
 

    
    @IBAction func userUpdateEX(_ sender: Any) {
      
        let userEmail = Auth.auth().currentUser!.email!
        
uploadImage()
        db.collection("NewEX").document("\(userEmail)-\(productName.text!)").updateData([
                    "productImage": imageName,
                    "opinion": opinion.text!
                ])
            { err in
                if let err = err {
                    print("??Error updating document: \(err.localizedDescription)")
                } else {
                    print("Document successfully updated!!!")
    //                                self.removePostUser()
                }
            }
        performSegue(withIdentifier: "up", sender: self)

        }
        
//    }
    
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

        let tap = UITapGestureRecognizer(target: self, action: #selector(UserEx.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}

extension UserEx: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        productImage.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }
    
}



extension UserEx {
    
    func setUp() {
        
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
        view.addSubview(backView)
        
        
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.topAnchor.constraint(equalTo: backView.topAnchor, constant: 40.0).isActive = true
        productName.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20.0).isActive = true
        productName.backgroundColor = UIColor(named: "Bu")
        productName.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        productName.widthAnchor.constraint(equalToConstant: 310.0).isActive = true
        productName.textColor = .black
        backView.addSubview(productName)

        opinion.translatesAutoresizingMaskIntoConstraints = false
        opinion.topAnchor.constraint(equalTo: backView.topAnchor, constant: 130.0).isActive = true
        opinion.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20.0).isActive = true
        opinion.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        opinion.widthAnchor.constraint(equalToConstant: 310.0).isActive = true
        opinion.textAlignment = .right
        opinion.backgroundColor = UIColor(named: "Bu")
        opinion.layer.cornerRadius = 5
        opinion.textColor = .black
        backView.addSubview(opinion)
    
                update.setTitle("update", for: .normal)
        update.layer.cornerRadius = 5
        update.tintColor = UIColor(named: "Vi")
        update.setTitleColor(UIColor(named: "Bu"), for: .normal)
        update.translatesAutoresizingMaskIntoConstraints = false
        update.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        update.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90.0).isActive = true
        update.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        update.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        
       
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10.0).isActive = true
        productImage.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 10.0).isActive = true
        productImage.widthAnchor.constraint(equalToConstant: 330.0).isActive = true
        productImage.heightAnchor.constraint(equalToConstant: 170.0).isActive = true
        productImage.contentMode = .scaleAspectFill
        productImage.layer.cornerRadius = 10
        productImage.clipsToBounds = true
        productImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(addImage))
        productImage.addGestureRecognizer(tap)
        backView.addSubview(productImage)

        
    }
    
    
}
