//
//  CTMediatorDemoListViewController.swift
//  ZhengHeFramework
//
//  Created by new on 2019/8/26.
//  Copyright © 2019 houjianan. All rights reserved.
//
import UIKit

class CTMediatorDemoListViewController:  GANormalizeBaseTableViewController {
    
    
    let dataArray = [
        "跳转TargetClass对象和响应指定方法",
        "动态生成targetClass，传递参数、直接跳转, 传递参数方案待定",
        "跳转TargetClass对象和响应方法，block回调传参",
        "创建CTMediatorExtension,调用其中定制的方法进行本地调用",
        "其他需求可以再自定义"
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
            //协议下跳转TargetClass对象和响应方法
            let url = URL.init(string: "aaa://A/Extension_ViewController?id=1234")
            let controller = CTMediator.sharedInstance()?.performAction(with: url, toOc: false, completion: { (param) in
                print("url参数")
                let aa = param as! [String:Any]
                print(aa)
            })
            navigationController?.pushViewController(controller as! UIViewController, animated: true)
        }
        
        if indexPath.row == 1 {
            //协议下传递跳转targetClass名字直接跳转  （传参方式还在尝试方案解决，支持跳转）
            let url = URL.init(string: "aaa://BViewController/path?id=5678")

            let controller = CTMediator.sharedInstance()?.performDirectJumpVc(with: url, toOc: true, completion: { (param) in
                print("url参数")
                let aa = param as! [String:Any]
                print(aa)
            })
            navigationController?.pushViewController(controller as! UIViewController, animated: true)
        }
        
        if indexPath.row == 2 {
            //协议下跳转TargetClass对象和响应方法，block回调传参
            let url = URL.init(string: "aaa://A/Extension_CallBack?id=1234")
            
            let controller = CTMediator.sharedInstance()?.performAction(with: url, toOc: false, callBack: { (param) in
                print("接受到回调传回的参数")
                print(param as! [String:Any])
            })
            navigationController?.pushViewController(controller as! UIViewController, animated: true)
        }
        
        if indexPath.row == 3 {
            //创建CTMediatorExtension,调用其中定制的方法进行本地调用
           let controller =  CTMediator.sharedInstance()?.A_showSwift(callback: { (msg) in
                print(msg)
            })
            navigationController?.pushViewController(controller!, animated: true)
        }
        
        if indexPath.row == 4 {
            
            
        }
    }
}

