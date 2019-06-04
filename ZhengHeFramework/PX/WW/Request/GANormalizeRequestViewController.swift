//
//  GANormalizeRequestViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/19.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GANormalizeRequestViewController: UIViewController {
    
    @IBOutlet weak var contentView: UITextView!
    
    @IBAction func post(_ sender: UIButton) {
        
        let headers = ["pid": "pid", "platform": "11.3999996185303", "clientId": "", "appName": "普信财富", "model": "iPhone", "imei": "", "registrationId": "", "sign": "", "mac": "", "screenSize": "(0.0, 0.0, 375.0, 667.0)", "Token": "", "packageName": "com.puxin.finance", "os": "ios", "factory": "apple", "version": "2.0.3.22", "channel": "appStore"]
        
        PXRequest.sharePX.requestPX(baseUrlType: ZHUrlType.url, zhUrlApi: .newDiscoverindex, method: .post, parameters: headers, successHandler: { (model) in
            print(model.result ?? "-")
            self.contentView.text = model.resultDic.ga_toJSONString()
        }) { (error, code) in
            print(error, code)
        }
        
    }
    
    @IBAction func cancle(_ sender: Any) {
        PXRequest.sharePX.cancleAllRequests()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
