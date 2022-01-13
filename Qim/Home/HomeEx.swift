//
//  HomeEx.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit


// butoons acction
// star action

class HomeEx: UIViewController {
    
    let backButton = UIButton(frame: CGRect(x: 0, y: 60, width: 100, height: 50))

    var productName = UILabel(frame: CGRect(x: 150, y: 100, width: 300, height: 50))
    var productImage = UIImageView()
    
    var star1 = UIButton(frame: CGRect(x: 30, y: 270, width: 50, height: 50))
    var star2 = UIButton(frame: CGRect(x: 50, y: 270, width: 50, height: 50))
    var star3 = UIButton(frame: CGRect(x: 70, y: 270, width: 50, height: 50))
    var star4 = UIButton(frame: CGRect(x: 90, y: 270, width: 50, height: 50))
    var star5 = UIButton(frame: CGRect(x: 110, y: 270, width: 50, height: 50))

    var opinionLabel = UILabel(frame: CGRect(x: 30, y: 300, width: 200, height: 50))
    var opinion = UILabel(frame: CGRect(x: 30, y: 340, width: 350, height: 70))
    
    var prosLabel = UILabel(frame: CGRect(x: 30, y: 400, width: 200, height: 50))
    var pros = UILabel(frame: CGRect(x: 30, y: 440, width: 350, height: 70))
    
    var consLabel = UILabel(frame: CGRect(x: 30, y: 500, width: 200, height: 50))
    var cons = UILabel(frame: CGRect(x: 30, y: 540, width: 350, height: 70))
    
    var priceLabel = UILabel(frame: CGRect(x: 30, y: 600, width: 200, height: 50))
    var price = UILabel(frame: CGRect(x: 30, y: 640, width: 350, height: 70))

    
    var saveButton = UIButton(frame: CGRect(x: 50, y: 800, width: 150, height: 50))
    var likeButton = UIButton(frame: CGRect(x: 230, y: 800, width: 150, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(backButton)
        view.addSubview(productName)
        view.addSubview(productImage)
        view.addSubview(star1)
        view.addSubview(star2)
        view.addSubview(star3)
        view.addSubview(star4)
        view.addSubview(star5)
        view.addSubview(opinionLabel)
        view.addSubview(opinion)
        view.addSubview(prosLabel)
        view.addSubview(pros)
        view.addSubview(consLabel)
        view.addSubview(cons)
        view.addSubview(priceLabel)
        view.addSubview(price)
        view.addSubview(saveButton)
        view.addSubview(likeButton)
        
        backButton.setTitleColor(.black, for: .normal)
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        productName.text = "product name"
        productName.textColor = .black
        
        productImage.frame = CGRect(x: 80, y: 140, width: 250, height: 130)
        productImage.image = UIImage(named: "1")
        
        star1.setImage(UIImage(systemName: "star"), for: .normal)
        star1.setTitleColor(.blue, for: .normal)
        
        star2.setImage(UIImage(systemName: "star"), for: .normal)
        star2.setTitleColor(.blue, for: .normal)
        
        star3.setImage(UIImage(systemName: "star"), for: .normal)
        star3.setTitleColor(.blue, for: .normal)
        
        star4.setImage(UIImage(systemName: "star"), for: .normal)
        star4.setTitleColor(.blue, for: .normal)
        
        star5.setImage(UIImage(systemName: "star"), for: .normal)
        star5.setTitleColor(.blue, for: .normal)
        
        opinionLabel.text = "opinion"
        opinionLabel.textColor = .black
        
        opinion.numberOfLines = 20
        opinion.backgroundColor = .systemGray
        opinion.text = "aaa"
        opinion.textColor = .black
        
        prosLabel.text = "Pros"
        prosLabel.textColor = .black
        
        pros.numberOfLines = 20
        pros.backgroundColor = .systemGray
        pros.text = "aaa"
        pros.textColor = .black
        
        consLabel.text = "Cons"
        consLabel.textColor = .black
        
        cons.numberOfLines = 20
        cons.backgroundColor = .systemGray
        cons.text = "aa"
        cons.textColor = .black
        
        priceLabel.text = "Price"
        prosLabel.textColor = .black
        
        price.numberOfLines = 20
        price.backgroundColor = .systemGray
        price.text = "aaa"
        price.textColor = .black
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.blue, for: .normal)
        saveButton.backgroundColor = .systemGray
        saveButton.layer.cornerRadius = 10
        
        likeButton.setTitle("Like", for: .normal)
        likeButton.setTitleColor(.blue, for: .normal)
        likeButton.backgroundColor = .systemGray
        likeButton.layer.cornerRadius = 10
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }


}
