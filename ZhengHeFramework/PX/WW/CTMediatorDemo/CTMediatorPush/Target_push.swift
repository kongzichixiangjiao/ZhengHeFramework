//
//  Target_push.swift
//  FinancialPlanner
//
//  Created by new on 2019/8/29.
//  Copyright © 2019 PUXIN. All rights reserved.
//

/*
  # # # 需要支持远程url调用的控制器 # # #
   1、所有控制器传参都使用字典方式，原有的传model方式通过HandyJSON转换成字典
   2、控制器需要回调的，如果之前使用的是闭包方式需要改成代理协议方式
 
 # # # 远程调用url规则
    1、url 中需要拼接参数 （kCTMediatorParamsKeySwiftTargetModuleName=项目命名空间)
*/

import UIKit

//制定协议，回调事件
protocol TargetPushDelegate: class {
    func sendMsg(_ str:String)
}

class Target_push: NSObject {
    
    weak var delegate:TargetPushDelegate?

    //打开三方应用app
    @objc func Action_OpenAppWithUrl(_ params:[String:Any]){
        
        let urlString = params["urlString"] as! String
        let encodeUrlString = urlString.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        if let url = URL(string: encodeUrlString ?? "") {
            if ( UIApplication.shared.canOpenURL(url)) {
                //根据iOS系统版本，分别处理
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:],
                                              completionHandler: {
                                                (success) in
                    })
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    //传递参数、不需要回调 支持远程和本地调用
    @objc func Action_MsgCenterList(_ params:[String:Any]){
//        if getCurrentController() == nil {return}
//        let vc = PXMessageCenterListViewController()
//        getCurrentController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //传递参数、闭包回调  只支持本地调用
    @objc func Action_MsgCenterListWithCallBack(_ params:[String:Any]){
        
//        if getCurrentController() == nil {return}
//        let vc = PXMessageCenterListViewController.init { (str) in
//
//            if let block = params["callback"] {
//                typealias CallbackType = @convention(block) (String) -> Void
//                let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(block as AnyObject).toOpaque())
//                let callback = unsafeBitCast(blockPtr, to: CallbackType.self)
//                callback(str)
//            }
//
//        }
//        getCurrentController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    //传递参数、代理回调 支持远程和本地调用
    @objc func Action_MsgCenterListWithDelegate(_ params:[String:Any]){
        
//        if getCurrentController() == nil {return}
//        let vc = PXMessageCenterListViewController.init { (str) in
//             CTMediatorDelegateManager.shared.pushDelegate?.sendMsg(str)
//        }
//
//        getCurrentController()?.navigationController?.pushViewController(vc, animated: true)
    }

}
