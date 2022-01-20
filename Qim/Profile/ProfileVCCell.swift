//
//  CollectionViewCell.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit

class ProfileVCCell: UITableViewCell {
    
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "F"
        label.textColor = .black
        return label
    }()
    
    var share: UIButton = {
        let share = UIButton()
        share.setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        share.tintColor = .black
        return share
    }()

    
//    var rateNum: UILabel = {
//        let rateNum = UILabel()
//        rateNum.text = "0"
//        rateNum.textColor = .black
//        return rateNum
//    }()
//
//    var rateButton: UIButton = {
//        let rateButton = UIButton()
////        rateImage.setTitle("A", for: .normal)
//        rateButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
//        rateButton.tintColor = .black
//        return rateButton
//    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      addSubview(titleLabel)
        
        contentView.addSubview(share)

        
      let cellFont = UIFont(name: titleLabel.font.fontName, size: 17)
        titleLabel.font = cellFont
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

        titleLabel.frame = CGRect(x: 40, y: contentView.frame.size.height - 50, width: contentView.frame.width - 5, height: 20)
        
        
        share.frame = CGRect(x: 140, y: contentView.frame.size.height - 50, width: contentView.frame.width - 3, height: 15)
        
    }
    

   

}
