//
//  GAMessageViewController.swift
//  ZhengHeFramework
//
//  Created by puxin on 2019/6/2.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GAMessageViewController: UIViewController {

    
    lazy var adView: YYTableADView = {
        var models: [YYTableADViewModel] = []
        for i in 0...4 {
            let model = YYTableADViewModel()
            model.text = "消息第" + "\(i)" + "条"
            models.append(model)
        }
        let v = YYTableADView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: kYYScrollADViewHeight), models: models)
        v.backgroundColor = UIColor.orange
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.addSubview(self.adView);
    }

}
