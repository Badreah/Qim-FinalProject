//
//  LikeVC.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit

class LikeVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    let myTabel = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        myTabel.register(LikeVCCell.self, forCellReuseIdentifier: "cell")
        myTabel.delegate = self
        myTabel.dataSource = self
        myTabel.allowsSelection = true
        myTabel.isUserInteractionEnabled = true
        myTabel.rowHeight = 70
        myTabel.backgroundColor = .white
        
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(myTabel)
        myTabel.translatesAutoresizingMaskIntoConstraints = false
        myTabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        myTabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        myTabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        myTabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTabel.dequeueReusableCell(withIdentifier: "cell") as! LikeVCCell
        cell.backgroundColor = .separator
        return cell
    }
    


}

