//
//  RecommendVC.swift
//  DouYuTV
//
//  Created by apple on 2017/7/18.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
//MARK:- 定义常量
private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin)/2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50
private let kCycleViewH = kScreenW * 3 / 8

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyCellID = "kPrettyCellID"

class RecommendVC: UIViewController {
    //MARK:- 懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    fileprivate lazy var collectionView : UICollectionView = {
        //1、创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0//行间距
        layout.minimumInteritemSpacing = kItemMargin//item间距
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        //2、创建collectionview
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleHeight]
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
       collectionView.register(UINib(nibName:"CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName:"CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        return collectionView
    }()
    fileprivate lazy var recommendCycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x:0, y:-kCycleViewH, width:kScreenW, height:kCycleViewH)
        return cycleView
    }()
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
        //请求数据
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//MARK:- 请求网络数据
extension RecommendVC{
    func loadData(){
        //请求无线轮播数据
        recommendVM.requestCycleData {
            self.recommendCycleView.cycleModels = self.recommendVM.cycleModels
        }
        //请求推荐数据
        recommendVM.requestData {
            self.collectionView.reloadData()
        }

    }
}

//MARK:- 设置UI界面
extension RecommendVC{
    func setupUI() {
        //1、将collectionview添加到View中
        view.addSubview(collectionView)
        //2、将cycleview添加到collectionview 
        collectionView.addSubview(recommendCycleView)
        //3、设置collectionview的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0)
    }
}

extension RecommendVC : UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchoGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchoGroups[section]
        return group.anchors.count
//        if section==0{
//            return 8
//        }
//        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1、取出模型对象
        let group = recommendVM.anchoGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]

        //2、定义cell
        var cell : CollectionBaseCell!

        //3、取出cell
        if indexPath.section == 1 {
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell


        }else{
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        }
        //4、将模型赋值给cell
        cell.anchor = anchor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1、取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath)
        as! CollectionHeaderView
        //2、取出模型
        headerView.group = recommendVM.anchoGroups[indexPath.section]
        return headerView
    }
}

//MARK:- 遵守UIcollectionViewDelegate
extension RecommendVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }else{
            return CGSize(width: kItemW, height: kNormalItemH)
        }
    }
}




