//
//  DropDownMenuViewDemo.swift
//  ZhengHeFramework
//
//  Created by new on 2019/9/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

let DropDownMenuViewDemo_kW = UIScreen.main.bounds.size.width

class DropDownMenuViewDemo: UIViewController {

    let moneyArray:[String] = ["不限金额","0~1000元","1001~2000元","2001~3000元","3001~5000元","5000元以上"]
    let limitArray:[String] = ["不限期限","0~14天","15~30天","30~60天","60~90天","90~180天","180~360天","360天以上"]
    let sortArray:[String] = ["默认排序","贷款成功率 ↓","日费率 ↑"]
    
    lazy var dropList:DropDownMenuView = {
        //传入一个二维数组即可
        let drop = DropDownMenuView.init(frame: CGRect.init(x: 0, y: 100, width: DropDownMenuViewDemo_kW, height: 40), tableArr: [self.moneyArray,self.limitArray,self.sortArray], selectClosure: { (tag, row) in
            //tag - 100是第几个标题菜单，row是菜单第几行
            print(tag-100,row)
        })
        return drop
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1)
        view.addSubview(dropList)
    }

}
