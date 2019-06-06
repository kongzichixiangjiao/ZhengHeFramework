//
//  GAWaterImageViewController.swift
//  ZhengHeFramework
//
//  Created by puxin on 2019/6/4.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GAWaterImageViewController: UIViewController {

    @IBOutlet weak var waterImageBg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.waterImageBg.image = UIImage().getWaterMarkImage(title: "史德伟 13716838764")
        
        self.waterImageBg.image = UIImage().getWaterMarkImage(title: "理财顾问 13800000000", titleFont: UIFont.systemFont(ofSize: 16), titleColor: UIColor.orange)

    }



}
