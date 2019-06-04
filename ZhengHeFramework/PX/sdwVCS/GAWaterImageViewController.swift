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
        
        self.waterImageBg.image = UIImage().getWaterMarkImage(title: "史德伟 13716838764")
        
        
    }



}
