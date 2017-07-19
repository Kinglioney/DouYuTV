//
//  PageContentView.swift
//  DouYuTV
//
//  Created by apple on 2017/7/18.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class{
    func pageContentView(contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}


private let ContentCellID = "ContentCellID"
class PageContentView: UIView {

    //MARK:-定义属性
    fileprivate var childVCs : [UIViewController]
    fileprivate weak var parentVC : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    fileprivate var isForbidScrollDelegate : Bool = false


    //MARK:-懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //1、创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
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
        collectionView.delegate = self
        return collectionView
    }()
    //MARK:-自定义构造函数
    init(frame : CGRect, childVCs : [UIViewController], parentVC : UIViewController?) {
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
            parentVC?.addChildViewController(childVC)
        }

        //2、添加collectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK:- 遵守UICollectionViewDataSource方法
extension PageContentView : UICollectionViewDataSource {
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
//MARK:- 遵守UICollectionViewDelegate方法
extension PageContentView : UICollectionViewDelegate{

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //0、判断是否是点击事件
        if isForbidScrollDelegate {return}
        //1、定义需要获取的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        //2、判断是左滑还是右滑
        let scrollViewW = scrollView.bounds.width
        let currentOffsetX = scrollView.contentOffset.x
        let radio = currentOffsetX / scrollViewW
        if currentOffsetX > startOffsetX {//左滑
            //2.1 计算progress
            progress = radio - floor(radio)
            //2.2 计算sourceIndex
            sourceIndex = Int(radio)
            //2.3 计算targetIndex
            targetIndex = sourceIndex+1
            if targetIndex >= childVCs.count{
                targetIndex = childVCs.count-1
            }
            //2.4 完全滑过去了
            if currentOffsetX-startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑
            //计算progress
            progress = 1 - (radio - floor(radio))
            // 计算targetIndex
            targetIndex = Int(radio)
            //计算sourceIndex
            sourceIndex = targetIndex+1
            if sourceIndex >= childVCs.count{
                sourceIndex = childVCs.count-1
            }
        }
//        print("radio = \(radio), floor(radio) = \(floor(radio))")
//        print("progress = \(progress),sourceIndex = \(sourceIndex), targetIndex = \(targetIndex)")
        //3、将progress/sourceIndex/targetIndex传递给TitleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK:-对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex : Int)  {
        //1、记录禁止滚动
        isForbidScrollDelegate = true

        let offSetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offSetX, y:0), animated: false)
    }
}




