//
//  RecommendViewModel.swift
//  DouYuTV
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class RecommendViewModel {
//MARK:- 懒加载属性
    lazy var anchoGroups : [AnchorGroup] = [AnchorGroup]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
}
//MARK:- 发送网络请求
extension RecommendViewModel {
    //请求推荐数据
    func requestData(finishCallBack : @escaping () ->()){
        //1、定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()];
        //2、创建group
        let dGroup = DispatchGroup()

        //3、请求第一部分推荐数据 http://capi.douyucdn.cn/api/v1/getbigDataRoom
        dGroup.enter()
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", type: .get, parameters: ["time" : NSDate.getCurrentTime()]) { (result : Any) in
            //1、将result转换为词典
            guard let resultDic = result as? [String : Any] else{return}
            //2、获取数组
            guard let dataArr = resultDic["data"] as? [[String : Any]] else{return}

            //3、遍历数组，获取词典并将词典转模型对象

            //3.1 设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //3.2 获取主播数据
            for dic in dataArr{
                let anchor = AnchoModel(dic : dic)
                self.bigDataGroup.anchors.append(anchor)

            }
            dGroup.leave()
            print("请求第0组数据")
        }


        //4、请求第二部分颜值数据 http://capi.douyucdn.cn/api/v1/getVerticalRoom
        dGroup.enter()
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", type: .get, parameters: parameters) { (result : Any) in
            //1、将result转换为词典
            guard let resultDic = result as? [String : Any] else{return}
            //2、获取数组
             guard let dataArr = resultDic["data"] as? [[String : Any]] else{return}

            //3、遍历数组，获取词典并将词典转模型对象

            //3.1 设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //3.2 获取主播数据
            for dic in dataArr{
                let anchor = AnchoModel(dic : dic)
                self.prettyGroup.anchors.append(anchor)

            }
            dGroup.leave()
            print("请求第1组数据")
        }



        //5、请求第三部分游戏数据 http://capi.douyucdn.cn/api/v1/getHotCate
        dGroup.enter()
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", type: .get, parameters: parameters) { (result : Any) in
                //print(result)
            //1、先将result转换为词典
            guard let resultDic = result as? [String : Any] else{return}
            //2、获取数组
            guard let dataArr = resultDic["data"] as? [[String : Any]] else{return}
            //3、遍历数组，获取词典并将词典转模型对象
            for dic in dataArr{
                let group = AnchorGroup(dic: dic)
                self.anchoGroups.append(group)
            }
//            for group in self.anchoGroups{
//                print(group.tag_name)
//                for ancho in group.anchors{
//                    print(ancho.nickname)
//                }
//            }
            dGroup.leave()
            print("请求第2~12组数据")
        }


        //6、所有的数据获取后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            print("所有数据都请求到了")
            self.anchoGroups.insert(self.bigDataGroup, at: 0)
            self.anchoGroups.insert(self.prettyGroup, at: 1)
            finishCallBack()
        }

    }

    //请求无线轮播数据
    func requestCycleData(finishCallBack : @escaping() ->()){
        NetworkTools.requestData(URLString: "http://www.douyu.com/api/v1/slide/6", type: .get, parameters: ["version" : "2.300"]) { (result : Any) in
            print(result)
            guard let resultDic = result as? [String : Any] else{return}
            guard let dataArr = resultDic["data"] as? [[String : Any]] else{return}

            for dic in dataArr{
                let cycle  = CycleModel(dic: dic)

                self.cycleModels.append(cycle)
            }
            finishCallBack()
        }
    }


}














