//
//  UITableView+Extension.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/26.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit


extension UITableView {
    
    func yy_register(nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func yy_register(nibNames: [String]) {
        for nibName in nibNames {
            yy_register(nibName: nibName)
        }
    }
    
    func yy_register(classString: String) {
        self.register(NSClassFromString(classString), forCellReuseIdentifier: classString)
    }
}




