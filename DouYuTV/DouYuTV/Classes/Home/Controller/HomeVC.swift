//
//  HomeVC.swift
//  DouYuTV
//
//  Created by apple on 2017/7/17.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40
class HomeVC: UIViewController {
    //MARK:-懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.backgroundColor = UIColor.white
        return titleView
    }()

    fileprivate lazy var pageContentView : PageContentView = {
        //1、确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH+kTitleViewH, width: kScreenW, height: contentH)
        //2、确定所有的控制器
        var childVCs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            //vc.view.backgroundColor = UIColor.red
            childVCs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentVC: self)
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension HomeVC{
    //MARK:- 设置UI界面
    fileprivate func setupUI(){
        //0、不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        //1、设置导航栏
        setupNavBar()
        //2、添加TitleView
        view.addSubview(pageTitleView)
        //3、添加ContentView
        view.addSubview(pageContentView)

    }

    private func setupNavBar(){
        //1、设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //2、设置右侧的Item

        let size = CGSize(width: 40, height: 40)

        //let historyItem = UIBarButtonItem.createItem(imageName: "my_video_waiting", highImageName: "", size: size)
        let historyItem = UIBarButtonItem(imageName: "my_video_waiting", highImageName: "", size: size)

        let searchItem = UIBarButtonItem(imageName: "home_newSeacrhcon", highImageName: "", size: size)

        let qrcodeItem = UIBarButtonItem(imageName: "home_newSaoicon", highImageName: "", size: size)

        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]

    }
}
