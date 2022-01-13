//
//  HomeCateogry.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit

class HomeCateogry: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
    var cat = [
        Category(title: "Home"),
        Category(title: "Kitchen"),
        Category(title: "Technology"),
        Category(title: "one")
    ]
    

    var myCollection: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        myCollection.register(HomeCell.self, forCellWithReuseIdentifier: "cell")
//        view.addSubview(myCollection)

//               myCollection.backgroundColor = .white
                myCollection.delegate = self
                myCollection.dataSource = self
        myCollection.allowsSelection = true
        myCollection.isUserInteractionEnabled = true
        
        myCollection.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            myCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            myCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            myCollection.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            myCollection.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
//        ])
        

    }
  
    override func loadView() {
        let layOut: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layOut.sectionInset = UIEdgeInsets(top: 50, left: 30, bottom: 10, right: 30)
        layOut.itemSize = CGSize(width: 150, height: 150)
        layOut.scrollDirection = .vertical
        myCollection = UICollectionView(frame: .zero, collectionViewLayout: layOut)
        self.view = myCollection

    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cat.count
    }


     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCell
        cell.titleLabel.text = cat[indexPath.row].title
         cell.layer.cornerRadius = 10
         cell.backgroundColor = .systemGray
         
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        performSegue(withIdentifier: "cat", sender: self)
//        switch indexPath.row {
//        case 0:
//            let vc = Home1()
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true, completion: nil)
//        case 1:
//            let vc = Home2()
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true, completion: nil)
//        case 2:
//            let vc = Home3()
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true, completion: nil)
//        case 3:
//            let vc = Home4()
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true, completion: nil)
//        case 4:
//            let vc = Home5()
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true, completion: nil)
//        default:
//            print("no index")
//        }

    }


    
}


struct Category {
    var title: String
}


