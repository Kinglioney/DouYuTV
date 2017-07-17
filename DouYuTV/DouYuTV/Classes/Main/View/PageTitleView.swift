//
//  PageTitleView.swift
//  DouYuTV
//
//  Created by apple on 2017/7/17.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
private let kScrollLineH : CGFloat = 2
class PageTitleView: UIView {

    //MARK:-定义属性
    fileprivate var titles : [String]

    //MARK:-懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()

    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()




    //MARK:-自定义构造函数
    init(frame : CGRect, titles :[String]) {
        self.titles = titles
        super.init(frame: frame)
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



extension PageTitleView {
    fileprivate func setupUI(){
        //1、添加ScrollView
        addSubview(scrollView)
        scrollView.frame = bounds

        //2、添加title对应的label
        setupTitleLabels()
        //3、设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }

    fileprivate func setupTitleLabels(){
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        for (index, title) in titles.enumerated() {
            //1、创建label
            let label = UILabel()
            //2、设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            //3、设置label的frame
                        let labelX : CGFloat = labelW * CGFloat(index)

            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //4、将label添加到scrollview中
            scrollView.addSubview(label)
            self.titleLabels.append(label)
        }
    }
    fileprivate func setupBottomLineAndScrollLine(){
        //1、添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        //2、添加scrollLine

        //2.1 获取第一个label
        guard let firstLabel = titleLabels.first else{return}
        firstLabel.textColor = UIColor.orange
        //2.2 设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)

    }
}
