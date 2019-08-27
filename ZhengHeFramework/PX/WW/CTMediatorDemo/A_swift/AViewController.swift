//
//  AViewController.swift
//  ZhengHeFramework
//
//  Created by new on 2019/8/26.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

typealias MyCallBack = ([String:Any])->() //传参

class AViewController: UIViewController {

    var myCallBack:MyCallBack?

    convenience init(_ callBack:@escaping MyCallBack) {
        self.init()
        self.myCallBack = callBack
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        let label =  UILabel()
        label.text = "控制器A"
        label.frame = CGRect.init(x: 0, y: 0, width: 300, height: 300)
        label.center = self.view.center
        label.textAlignment = .center
        self.view.addSubview(label)
        
        if((self.myCallBack) != nil) {
            myCallBack!(["key":"hello"])
        }

    }
    
    deinit {
        print("deinit")
    }

}
