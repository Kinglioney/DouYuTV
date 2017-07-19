//
//  RecommendCycleView.swift
//  DouYuTV
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    //MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var pageControl: UIPageControl!

    //MARK:- 定义属性
    var cycleModels : [CycleModel]? {
        didSet{
            //1、刷新数据
            collectionView.reloadData()
            //2、设置page的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }



    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
       //设置该控件不随着父控件的拉伸而拉伸 UIViewAutoresizingNone
        autoresizingMask = .init(rawValue: 0)
        //注册自定义的cell
      //  collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellID)
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //设置layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal//水平滚动
        collectionView.isPagingEnabled = true

    }

}
//MARK:- 快速创建View的类方法
extension RecommendCycleView{
    class func recommendCycleView() -> RecommendCycleView {

        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//MARK:- 遵守collectionview的数据源方法
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取模型对象
        let cycle  = cycleModels![indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        //cell.backgroundColor = indexPath.item%2==0 ? UIColor.red :UIColor.blue
        cell.cycle = cycle
        return cell

    }
}
//MARK:-遵守collectionview的代理方法
extension RecommendCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1、获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width/2
        //2、计算currentIndex
        pageControl.currentPage = Int(offsetX/scrollView.bounds.width)
    }
    
}
