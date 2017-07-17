//
//  PageContentView.swift
//  DouYuTV
//
//  Created by apple on 2017/7/18.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
private let ContentCellID = "ContentCellID"
class PageContentView: UIView {

    //MARK:-定义属性
    fileprivate var childVCs : [UIViewController]
    fileprivate var parentVC : UIViewController
    //MARK:-懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {
        //1、创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal

        //2、创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        collectionView.dataSource = self
        //collectionView.delegate = self
        return collectionView
    }()
    //MARK:-自定义构造函数
    init(frame : CGRect, childVCs : [UIViewController], parentVC : UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)

        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension PageContentView {
    //MARK:- 设置UI界面
    fileprivate func setupUI(){
        //1、将所有的子控制器添加到父控制器中
        for childVC in childVCs {
            parentVC.addChildViewController(childVC)
        }

        //2、添加collectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1、创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        //2、设置cell的内容
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)

        return cell
    }


}
