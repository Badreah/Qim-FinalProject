//
//  TableViewCell.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    var categoryBranName: UILabel = {
        let categoryBranName = UILabel()
        categoryBranName.text = "F"
        categoryBranName.textColor = .black
        return categoryBranName
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      addSubview(categoryBranName)
      
        
      let cellFont = UIFont(name: categoryBranName.font.fontName, size: 17)
        categoryBranName.font = cellFont
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryBranName.frame = CGRect(x: 60, y: contentView.frame.size.height - 50, width: contentView.frame.width - 5, height: 20)
    }

}
