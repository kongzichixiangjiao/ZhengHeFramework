//
//  SDWViewController.swift
//  ZhengHeFramework
//
//  Created by puxin on 2019/6/2.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class SDWViewController: GANormalizeBaseTableViewController {
    
    
    let dataArray = ["按钮","滚动消息动画","身份证银行卡扫描","textView And textField","广告页","tableviewsView","二维码扫描"]

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
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            self.navigationController?.pushViewController(GAButtonViewController(), animated: true)

        }else if indexPath.row == 1{
            
            self.navigationController?.pushViewController(GAMessageViewController(), animated: true)

        }else if indexPath.row == 3 {
            
            self.navigationController?.pushViewController(GATextViewAndTextFieldViewController(), animated: true)

        } else if indexPath.row == 6 {
            
            self.navigationController?.pushViewController(GANormalizeScanViewController(), animated: true)
        }
        
        
        
    }
}
