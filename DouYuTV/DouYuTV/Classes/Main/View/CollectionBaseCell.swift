//
//  CollectionBaseCell.swift
//  DouYuTV
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionBaseCell: UICollectionViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var icoImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!

    //MARK:- 定义模型属性 
    var anchor : AnchoModel? {
        didSet{
            //0、校验模型是否有值
            guard let anchor = anchor else {return}
            //1、取出在线人数显示
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online))万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)

            //2、昵称的显示
            nickNameLabel.text = anchor.nickname

            //3、设置封面图片
            guard let imageURL  = URL(string: anchor.vertical_src) else{return}
            icoImageView.kf.setImage(with: imageURL)

        }

    }
}

