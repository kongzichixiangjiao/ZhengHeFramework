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
    internal var itemWidth:CGFloat = 0
    private var rowHeight:CGFloat = 40
    private var margin:CGFloat = 16 //边距
    private var maskViewBgColor:UIColor = UIColor.clear //蒙层颜色
    
    lazy var myMaskView:UIView = {
        //蒙层
       let maskView = UIView.init(frame: CGRect.init(x: 0, y: self.frame.size.height + self.frame.origin.y, width: DropDownMenuView_kW, height: DropDownMenuView_kH - self.frame.size.height - self.frame.origin.y))
        maskView.backgroundColor = maskViewBgColor
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapActions))
        maskView.alpha = 0
        maskView.addGestureRecognizer(tap)
        
        //列表
        for i in 0..<tableArray.count{
            
            let tableView = UITableView.init(frame: CGRect.init(x: margin + itemWidth * CGFloat(i), y: 0, width: itemWidth , height: 1), style: .plain)
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tag = 100+i
            tableView.backgroundColor = UIColor.white
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
            tableView.rowHeight = rowHeight
            tableView.isScrollEnabled = false
            maskView.addSubview(tableView)
        }
        
        return maskView
    }()
    
    
    
    init(frame: CGRect,tableArr:[[String]],selectClosure : @escaping (_ tag:Int,_ row:Int)->Void) {
        super.init(frame: frame)
        
        //获取菜单title
        self.titleArray = tableArr.map({ (arr) -> String in
            return arr[0]
        })
        
        self.tableArray = tableArr
        self.selectClosure = selectClosure
        
        //item 宽度
        itemWidth = (DropDownMenuView_kW - 2 * margin)/CGFloat(titleArray.count)
        
        self.backgroundColor = UIColor.white

        //菜单按钮
        setTitleButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //蒙层点击
    @objc func tapActions(){

        for i in 0..<self.tableArray.count{
            let titleBtn = self.viewWithTag(1000+i) as! PXTitleButton
            titleBtn.isSelected = false
            UIView.animate(withDuration: 0.2, animations: {
                self.myMaskView.alpha = 0
            }, completion: { (idCom) in
                self.myMaskView.removeFromSuperview()
            })
        }
    }
    
    //顶部按钮title
    private func setTitleButton(){
        
        for i in 0..<self.titleArray.count{
            let titleBtn = PXTitleButton()
            titleBtn.tag = 1000 + i
            titleBtn.setTitle(self.titleArray[i], for: .normal)
            titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            titleBtn.addTarget(self, action: #selector(titleBtnAction), for: .touchUpInside)
            titleBtn.frame = CGRect.init(x: margin + CGFloat(i)*itemWidth, y: 0, width: itemWidth, height: self.frame.size.height)
            self.addSubview(titleBtn)
        }
    }
    
    //顶部按钮title点击事件
    @objc func titleBtnAction(_ sender:UIButton) {
        
        let btnTag = sender.tag
        
        UIApplication.shared.keyWindow?.addSubview(self.myMaskView)
        
        let selectedTableView = self.myMaskView.viewWithTag(btnTag-900) as! UITableView

        UIView.animate(withDuration: 0.1, animations: {
            self.myMaskView.alpha = 1
        })
        
        for i in 0..<self.titleArray.count {
            
            let titleBtn = self.viewWithTag(i + 1000) as! PXTitleButton
            
            if titleBtn.tag != btnTag {
                titleBtn.isSelected = false
            }
            
            let myTableView = self.myMaskView.viewWithTag(i + 100) as! UITableView

            if myTableView.tag != (btnTag-900) {
                var frame = myTableView.frame
                frame.size.height = 0.1
               myTableView.frame = frame
            }
        }
        
        let arr = tableArray[btnTag - 1000] as [String]
        let H:CGFloat = CGFloat(arr.count)*rowHeight

        UIView.animate(withDuration: 0.2, animations: {
            selectedTableView.frame = CGRect.init(x: self.margin + self.itemWidth * CGFloat(btnTag-1000), y: 0, width: self.itemWidth , height: H)
        })
        
        selectedTableView.reloadData()

        sender.isSelected = !sender.isSelected
        
        if (!sender.isSelected) {
            var frame = selectedTableView.frame
            frame.size.height = 0.1
            UIView.animate(withDuration: 0.2, animations: {
                selectedTableView.frame = frame
                self.myMaskView.alpha = 0
            }, completion: { (idCom) in
                self.myMaskView.removeFromSuperview()
            })
        }
    }

}

extension DropDownMenuView:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let selectedTitleButton = self.myMaskView.viewWithTag(tableView.tag + 900) as! PXTitleButton

        if self.selectClosure != nil {
            self.selectClosure!(tableView.tag-100,indexPath.row)
        }
        
        selectedTitleButton.isSelected = false
        
        var frame = tableView.frame
        frame.size.height = 0.1
        
        UIView.animate(withDuration: 0.2, animations: {
            tableView.frame = frame
            self.myMaskView.alpha = 0
        }, completion: {(idCom) in
            self.myMaskView.removeFromSuperview()
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
