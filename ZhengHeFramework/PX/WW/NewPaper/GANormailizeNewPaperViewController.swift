//
//  GANormailizeNewPaperViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/19.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GANormailizeNewPaperViewController: GANormalizeBaseViewController {

    var newPaperConfig: YYNewPaperConfig?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        base_isShowNavigationView = false
        
        let config = YYNewPaperConfig()
        config.isShowTimer = false
        config.dataSource = ["img_001.jpg", "img_002.jpg", "img_003.jpg"]
        config.isShowLastButton = true
        newPaperConfig = config
        
        let v = YYNewPaperView(frame: self.view.bounds, config: newPaperConfig!) { (type) in
            self.navigationController?.popViewController(animated: true)
            if type == .over {
               
            } else if type == .login {
              
            } else {
                
            }
        }
        
        self.view.addSubview(v)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("deinit GANormailizeNewPaperViewController")
    }

}
