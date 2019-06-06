//
//  UIBarButtonItem+Extension.swift
//  PXFinancialPlanner
//
//  Created by summer on 2017/8/29.
//  Copyright © 2017年 PUXIN. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName: String, rect: CGRect, imageEdgeInsets: UIEdgeInsets, target: Any, action: Selector)  {
        let backButton = UIButton(type: .custom)
        backButton.frame = rect
        backButton.addTarget(target, action: action, for: .touchUpInside)
        backButton.imageEdgeInsets = imageEdgeInsets
        backButton.setImage(UIImage(named:imageName), for: .normal)
        self.init(customView : backButton)
    }

}
