//
//  PXNotifyViewDemo.swift
//  ZhengHeFramework
//
//  Created by new on 2019/9/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class PXNotifyViewDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let str = "有一个学习的氛围跟一个交流圈子特别重要!"
        PXNotifyView.showNotify(str)
    }

}
