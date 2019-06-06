//
//  ZHDsbridgeUtilsTools.swift
//  PuXinFinancial
//
//  Created by puxin on 2019/2/12.
//  Copyright © 2019年 ZHENGHE. All rights reserved.
//

import UIKit
import dsBridge

typealias PXJSCallback = (String,Bool)->Void
/*
1传递用户信息|zhTransformUserInfor|{key:value}|Dictionary|
2拨打电话|zhTelephoneCall|phoneNum| String |
3打开一个新界面|zhOpenNewHtml|url| String |
4主动退出H5页面|zhFinish|无|
5强制退出|zhLogoutOfLogin|msg|String|账号在别的设备登录|
6退出登录|zhLogout|无|
7提示信息|zhToast|msg|String|
8取消确定弹窗|zhAlertView|msg|String|交互弹窗|
9跳转到登录界面|zhJumpLoginView|msg|String|打开登录界面|
 */

protocol ZHDsbridgeUtilsToolsDelegate :class  {
    
    func operationSucceeded()
}
class ZHBaseDsbridgeUtilsTools: NSObject {
    
    
    weak var delegate : ZHDsbridgeUtilsToolsDelegate?

    //1.传递用户信息-同步获取用户信息
    @objc func zhTransformUserInfor(_ arg:String) -> String {
        
        let dicString:String = ""
        return dicString
    }
    //异步获取用户信息
    @objc func zhTransformUserInfor(_ msg: String, _ handlers: PXJSCallback){
        
        handlers([].ga_toJSONString()!, true)
    }

    // MARK: 字符串转字典
    func stringValueDic(_ str: String) -> [String : Any]?{
        let data = str.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
            return dict
        }
        return nil
    }
    
    //2拨打电话
    @objc func zh_telephoneCall(_ phone:String) {
        print(phone)
    }
    //3打开新界面
    @objc func zhOpenNewHtml(_ url:String) {
        
        print(url)
 
    }
    //4主动退出H5页面
    @objc func zhFinish() {
    }
    //5强制退出|zhLogoutOfLogin|msg|String|账号在别的设备登录|
    @objc func zhLogoutOfLogin(_ msg:String) {
        
     
    }
    //6退出登录|zhLogout|无|
    @objc func zhLogout() {

    }
    
   // 7提示信息|zhToast|msg|String|
    @objc func zhToast(_ msg:String) {
        
    //Toast(text: msg, delay: 0, duration: 2).show()

    }
    
    //8取消确定弹窗|zhAlertView|msg|String|交互弹窗|
    @objc func zhAlertView(_ msg:String, handler:@escaping PXJSCallback) {

    }
    
    //9跳转到登录界面|zhJumpLoginView|msg|String|打开登录界面|
    @objc func zhJumpLoginView(_ msg:String) {
    
    }
    
}
