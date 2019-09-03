//
//  DropDownMenuView.swift
//  ZhengHeFramework
//
//  Created by new on 2019/9/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
let DropDownMenuView_kW = UIScreen.main.bounds.size.width
let DropDownMenuView_kH = UIScreen.main.bounds.size.height

class DropDownMenuView: UIView {
    
    fileprivate var cellid = "cellid"
    private lazy  var titleArray = [String]()
    private lazy  var tableArray = [[String]]()
    private var selectClosure:((_ tag:Int,_ row:Int)->Void)?
    private var myMaskView:UIView?
    internal var itemWidth:CGFloat = 0

    
    init(frame: CGRect,tableArr:[[String]],selectClosure : @escaping (_ tag:Int,_ row:Int)->Void) {
        super.init(frame: frame)
        
        //获取菜单title
        self.titleArray = tableArr.map({ (arr) -> String in
            return arr[0]
        })
        
        self.tableArray = tableArr
        self.selectClosure = selectClosure
        
        itemWidth =  DropDownMenuView_kW/CGFloat(titleArray.count)
        
        self.backgroundColor = UIColor.white
        
        //菜单按钮
        setTitleButton()
        
        //蒙层
        setMaskView()
        
        //创建下拉列表
        setTableView()
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setMaskView(){
        myMaskView = UIView.init(frame: CGRect.init(x: 0, y: self.frame.size.height, width: DropDownMenuView_kW, height: DropDownMenuView_kH - self.frame.size.height - self.frame.origin.y))
//        myMaskView?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        myMaskView?.backgroundColor = UIColor.red
        myMaskView?.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapActions))
        myMaskView?.alpha = 0
        myMaskView?.addGestureRecognizer(tap)
    }
    
    //蒙层点击
    @objc func tapActions(){
        print("哈哈")
        for i in 0..<self.tableArray.count{
            let tableView = self.viewWithTag(100+i) as! UITableView
            var frame = tableView.frame
            frame.size.height = 1
            let titleBtn = self.viewWithTag(1000+i) as! PXTitleButton
            
            if tableView.frame.height>1{
                titleBtn.isSelected = false
                UIView.animate(withDuration: 0.2, animations: {
                    tableView.frame = frame
                    self.myMaskView?.alpha = 0
                }, completion: { (idCom) in
                    self.myMaskView?.removeFromSuperview()
                })
                
            }
        }
    }
    
    private func setTitleButton(){
        
        for i in 0..<self.titleArray.count{
            
            let titleBtn = PXTitleButton()
            titleBtn.tag = 1000 + i
            titleBtn.setTitle(self.titleArray[i], for: .normal)
            titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            titleBtn.addTarget(self, action: #selector(titleBtnAction), for: .touchUpInside)
            titleBtn.frame = CGRect.init(x: CGFloat(i)*itemWidth, y: 0, width: itemWidth, height: self.frame.size.height)
            self.addSubview(titleBtn)
        }
    }
    
    @objc func titleBtnAction(_ sender:UIButton) {
        
        let btnTag = sender.tag
        let selectedTableView = self.viewWithTag(btnTag/10) as! UITableView
        
        self.insertSubview(self.myMaskView!, at: 0)
        UIView.animate(withDuration: 0.2, animations: {
            self.myMaskView?.alpha = 1
        })
        
        for i in 0..<self.titleArray.count {
            
            let titleBtn = self.viewWithTag(i + 1000) as! PXTitleButton
            
            if titleBtn.tag != btnTag {
                titleBtn.isSelected = false
            }
            
            let myTableView = self.viewWithTag(i + 100) as! UITableView

            if myTableView.tag != btnTag/10 {
                var frame = myTableView.frame
                frame.size.height = 0.1
               myTableView.frame = frame
            }
        }
        
        let arr = tableArray[btnTag - 1000] as [String]
        let H:CGFloat = CGFloat(arr.count)*40.0

        UIView.animate(withDuration: 0.01, animations: {
            selectedTableView.frame = CGRect.init(x: self.itemWidth * CGFloat(btnTag-1000), y: self.frame.size.height, width: self.itemWidth , height: H)
        })
        
        selectedTableView.reloadData()

        sender.isSelected = !sender.isSelected
        
        if (!sender.isSelected) {
            var frame = selectedTableView.frame
            frame.size.height = 0.1
            UIView.animate(withDuration: 0.2, animations: {
                selectedTableView.frame = frame
                self.myMaskView?.alpha = 0
            }, completion: { (idCom) in
                self.myMaskView?.removeFromSuperview()
            })
        }
    }
    
    private func setTableView(){

        for i in 0..<tableArray.count{
            
            let tableView = UITableView.init(frame: CGRect.init(x: itemWidth * CGFloat(i), y: self.frame.size.height, width: itemWidth , height: 1), style: .plain)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tag = 100+i
            tableView.backgroundColor = UIColor.white
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
            tableView.rowHeight = 40
            tableView.isScrollEnabled = false
            self.addSubview(tableView)
            
        }
            
    }

}

extension DropDownMenuView:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let drop = self.viewWithTag(tableView.tag-100+1000) as! LYDropListTItleView
        let cell = tableView.cellForRow(at: indexPath)
        
//        drop.title  = cell?.textLabel?.text
//        if self.selectClosure != nil {
//            self.selectClosure!(tableView.tag,indexPath.row)
//        }
//
//        drop.isSelected = false
      
        
        UIView.animate(withDuration: 0.2, animations: {
            tableView.frame = CGRect.init(x: 0, y: 40, width: self.itemWidth, height: 0.1)
            self.myMaskView?.alpha = 0
        }, completion: {(idCom) in
            self.myMaskView?.removeFromSuperview()
        })
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableArray[tableView.tag-100].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let normalFontColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as UITableViewCell
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = normalFontColor
        cell.textLabel?.text = tableArray[tableView.tag - 100][indexPath.row]
        return cell
    }
}
