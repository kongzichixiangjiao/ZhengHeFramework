//
//  CTMediatorDelegateManager.swift
//  FinancialPlanner
//
//  Created by new on 2019/8/29.
//  Copyright © 2019 PUXIN. All rights reserved.
//

import UIKit

class CTMediatorDelegateManager: NSObject {
    
    static let shared = CTMediatorDelegateManager()
    
    weak var pushDelegate:TargetPushDelegate?
    
}
