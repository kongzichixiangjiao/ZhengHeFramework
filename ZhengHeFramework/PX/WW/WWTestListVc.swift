//
//  WWTestListVc.swift
//  ZhengHeFramework
//
//  Created by new on 2019/6/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class WWTestListVc: GANormalizeBaseTableViewController {
    
    
    let dataArray = ["0、弹窗提醒","1、新特性","2、request","3、最近搜索，标签","4、CTMediator路由", "5、顶部吐司view", "6、下拉列表"]
    var sss : String?
    
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
            
            self.navigationController?.pushViewController(GANormalizeAlertsViewController(), animated: true)
            
        }else if indexPath.row == 1{
            
            self.navigationController?.pushViewController(GANormailizeNewPaperViewController(), animated: true)
            
        }else if indexPath.row == 2 {
            
            self.navigationController?.pushViewController(GANormalizeRequestViewController(), animated: true)
            
        }else if indexPath.row == 3 {
            
            self.navigationController?.pushViewController(GATagCollectionViewController(), animated: true)
            
        }else if indexPath.row == 4 {
            
            self.navigationController?.pushViewController(CTMediatorDemoListViewController(), animated: true)
            
        }else if indexPath.row == 5 {
            
            self.navigationController?.pushViewController(PXNotifyViewDemo(), animated: true)
            
        }else if indexPath.row == 6 {
            
            self.navigationController?.pushViewController(DropDownMenuViewDemo(), animated: true)
        }
        
        
    }
}
