//
//  LikeEx.swift
//  Qim
//
//  Created by Badreah Saad on 18/01/2022.
//

import UIKit
import Firebase

class SavedEx: UIViewController {
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
   
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var opiView: UIView!
    
    @IBOutlet weak var opinion: UITextView!
    
    @IBOutlet weak var productImage: UIImageView!
    
    var savedEx: SavedExperience!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadImage(imageStr: savedEx.productImage)

        setUp()
        viewFavEx()

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
    

    func viewFavEx() {
        productName.text = savedEx.productName
        opinion.text = savedEx.opinion
    }

    
}



extension SavedEx {
    
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
        productName.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        productName.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        productName.textColor = .black
        productName.backgroundColor = UIColor(named: "Bu")

       
        opiView.addSubview(opinion)
        opinion.translatesAutoresizingMaskIntoConstraints = false
        opinion.topAnchor.constraint(equalTo: opiView.topAnchor, constant: 10.0).isActive = true
      
        opinion.rightAnchor.constraint(equalTo: opiView.rightAnchor, constant: -20.0).isActive = true
        opinion.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        opinion.widthAnchor.constraint(equalToConstant: 280.0).isActive = true
        opinion.textColor = .black
        opinion.textAlignment = .right
        opinion.backgroundColor = UIColor(named: "Bu")
        opinion.layer.cornerRadius = 5
        opinion.isEditable = false

        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10.0).isActive = true
        productImage.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 10.0).isActive = true
        productImage.widthAnchor.constraint(equalToConstant: 330.0).isActive = true
        productImage.heightAnchor.constraint(equalToConstant: 170.0).isActive = true
        productImage.contentMode = .scaleAspectFill
        productImage.layer.cornerRadius = 10
        productImage.clipsToBounds = true
        backView.addSubview(productImage)
        
        
    }
    
    
    
}
