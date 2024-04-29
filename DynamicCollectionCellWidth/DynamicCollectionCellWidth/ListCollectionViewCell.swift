//
//  ListCollectionViewCell.swift
//  DynamicCollectionCellWidth
//
//  Created by mac on 25/04/24.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {

    @IBOutlet var backView: UIView!
    static let identifier = "ListCollectionViewCell"
    var height: CGFloat?{
        didSet{
            backView.layer.cornerRadius = height!/2
            backView.layer.borderWidth = 1
            backView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    
    @IBOutlet var listLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = (contentView.frame.height-10)/2
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.gray.cgColor
    }

}
