//
//  CollectionCycleCell.swift
//  DouYuTV
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionCycleCell: UICollectionViewCell {

    //MARK:- 定义属性
    var cycle : CycleModel?{
        didSet{
            guard let cycle = cycle else {
                return
            }
            guard let iconURL = URL(string : cycle.pic_url) else {return}
           iconImageView.kf.setImage(with: iconURL)
            titleLabel.text = cycle.title
        }
    }
    //MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
