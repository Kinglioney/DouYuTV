//
//  NetworkTools.swift
//
//  Created by apple on 2017/7/14.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType{
    case get
    case post
}
class NetworkTools{
    //class类方法 -- OC + 开头
    class func requestData(URLString : String, type : MethodType, parameters : [String : Any]? = nil, finishedCallBack : @escaping(_ result : Any) -> ()){
        let methodType = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: methodType, parameters: parameters).responseJSON { (response) in
            //1、校验是否有结果
//            if let result = response.result.value{
//            finishedCallBack(result)
//            }else{
//                print(response.result.error)
//            }
            //或者使用guard语句
            guard let result = response.result.value else{
                print(response.result.error)
                return
            }
            finishedCallBack(result)
        }
    }
}







































