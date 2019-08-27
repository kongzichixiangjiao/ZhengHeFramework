//
//  A_Extension.swift
//  A_Extension
//
//  Created by casa on 2018/8/23.
//  Copyright © 2018年 casa. All rights reserved.
//

public extension CTMediator {
    
    @objc func A_showSwift(callback:@escaping (String) -> Void) -> UIViewController? {

        if let viewController = self.performTarget("A", toOc: false, action: "Extension_ViewController", params: nil, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
    
    func A_showObjc(callback:@escaping (String) -> Void) -> UIViewController? {
        let callbackBlock = callback as @convention(block) (String) -> Void
        let callbackBlockObject = unsafeBitCast(callbackBlock, to: AnyObject.self)
        let params = ["callback":callbackBlockObject] as [AnyHashable:Any]
        if let viewController = self.performTarget("A", toOc: false, action: "Category_ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
}

