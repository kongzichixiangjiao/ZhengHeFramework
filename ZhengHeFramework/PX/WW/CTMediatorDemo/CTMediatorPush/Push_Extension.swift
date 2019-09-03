//
//  Push_Extension.swift
//  FinancialPlanner
//
//  Created by new on 2019/8/29.
//  Copyright © 2019 PUXIN. All rights reserved.
//

import CTMediator

public extension CTMediator {
    
    //本地调用方法 可以自定义传参和回调
    
    // Swift -> Extension -> Swift
    @objc public func A_showSwift(callback:@escaping (String) -> Void){
        
        let swiftModuleName = Bundle.main.infoDictionary?["CFBundleExecutable"]
        let params = [
            "callback":callback,
            kCTMediatorParamsKeySwiftTargetModuleName:swiftModuleName ?? ""
            ] as [AnyHashable : Any]
        
        self.performTarget("push", action: "MsgCenterListWithCallBack", params: params, shouldCacheTarget: false)
    }
    
    // Swift -> Extension -> Objective-C  （OC 的block  与 swift 的closure 需要转换）
    @objc public func A_showObjc(callback:@escaping (String) -> Void) -> UIViewController? {
        
        let callbackBlock = callback as @convention(block) (String) -> Void
        let callbackBlockObject = unsafeBitCast(callbackBlock, to: AnyObject.self)
        
        let params = ["callback":callbackBlockObject] as [AnyHashable:Any]
        
        if let viewController = self.performTarget("push", action: "MsgCenterListWithCallBack", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
}
