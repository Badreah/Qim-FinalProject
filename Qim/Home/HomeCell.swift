//
//  HomeCell.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    let id = "cell"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "F"
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 50, y: contentView.frame.size.height - 80, width: contentView.frame.width - 5, height: 20)
    }
    
    
    
}
