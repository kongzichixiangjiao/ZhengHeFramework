//
//  CTMediatorDemoListViewController.swift
//  ZhengHeFramework
//
//  Created by new on 2019/8/26.
//  Copyright © 2019 houjianan. All rights reserved.
//
import UIKit
import CTMediator

class CTMediatorDemoListViewController:  GANormalizeBaseTableViewController {
    

    let dataArray = [
        "传递参数、不需要回调,支持远程和本地调用",
        "传递参数、闭包回调,只支持本地调用",
        "传递参数、代理回调,支持远程和本地调用",
        "打开三方应用app,支持远程和本地调用"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.red
        self.tableView.yy_register(classString: UITableViewCell.identifier)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
        
            let url = URL.init(string: "aaa://push/MsgCenterList?id=1234&kCTMediatorParamsKeySwiftTargetModuleName=ZhengHeFramework")
            CTMediator.sharedInstance()?.performAction(with: url, completion: { (param) in
                print("打印")
            })
        }
        
        if indexPath.row == 1 {
            let _ = CTMediator.sharedInstance()?.A_showSwift(callback: { (param) in
                print("打印")
                print(param)
            })
        }
        
        if indexPath.row == 2 {
            
            let url = URL.init(string: "aaa://push/MsgCenterListWithDelegate?id=1234&kCTMediatorParamsKeySwiftTargetModuleName=ZhengHeFramework")
            CTMediator.sharedInstance()?.performAction(with: url, completion: { (param) in
                print("打印")
            })
        }
        
        if indexPath.row == 3 {
            let url = URL.init(string: "aaa://push/OpenAppWithUrl?urlString=1234&kCTMediatorParamsKeySwiftTargetModuleName=ZhengHeFramework")
            CTMediator.sharedInstance()?.performAction(with: url, completion: { (param) in
                print("打印")
            })
        }
        
    }
}

