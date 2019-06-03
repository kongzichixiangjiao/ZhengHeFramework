//
//  ZHMenuBarMoreLineView.swift
//  PuXinFinancial
//
//  Created by puxin on 2019/2/18.
//  Copyright © 2019年 ZHENGHE. All rights reserved.
//

import UIKit
protocol ZHMenuBarMoreLineViewDelegate:class {
    
    func clickBtnIndex(_ index:Int)
}

class ZHMenuBarMoreLineView: UIView {
 
    private var btnLineNum:Int = 0 //哪一行的按钮
    private var btnArray:[UIButton] = []
    private var bottomSepLineView:UIView!
    //每一行最多显示按钮的个数默认3个
    var lineBtnSum:Int = 4
    //按钮的高度
    var buttonHeight:Int = 40
    //delegate的代理
    weak var delegate:ZHMenuBarMoreLineViewDelegate?

    var titles: [String] = [] {
        didSet {
            //如果当前的最少数量小于
            if titles.count < lineBtnSum {
                lineBtnSum = titles.count
            }
            let shangCount = titles.count / lineBtnSum //取商
            let yuCount = titles.count % lineBtnSum //取余
            var btnCount = lineBtnSum //每一行循环的btn个数
            //为了保留两位小数可方便向上取整的准确性
            let str = String(format: "%.5f", CGFloat(titles.count)/CGFloat(lineBtnSum))
            //向上取整
            for i in 0..<Int(ceil(Double(str)!)) {
                //如果取余不为0 当前i等于当前的取模值 则最后一次的循环 最大值为 余值
                if yuCount != 0 && i == shangCount {
                    btnCount = yuCount
                }
                for j in 0..<btnCount {
                    let btn = UIButton.init(type: .custom)
                    btn.setTitle(titles[i * lineBtnSum + j], for: .normal)
                    btn.tag = i * lineBtnSum + j
                    btn.addTarget(self, action: #selector(touchBtnEvents(_:)), for: .touchUpInside)
                    btn.setTitleColor(UIColor.init(colorWithHexValue: 333333), for: .normal)
                    btn.setTitleColor(UIColor.init(colorWithHexValue: 333333), for: .highlighted)
                    btn.frame = CGRect.init(x: CGFloat(j)*((kScreenWidth-30)/CGFloat(lineBtnSum)) + 15, y: CGFloat(i*buttonHeight), width: (kScreenWidth - 30)/CGFloat(lineBtnSum), height: CGFloat(buttonHeight))
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                    self.addSubview(btn)
                    btnArray.append(btn)
                }
                if i > 0 { //从第一行开始画分割线
                    
                    let lineView = UIView()
                    lineView.frame = CGRect.init(x: 15, y:CGFloat(i*buttonHeight), width: kScreenWidth - 30, height: 1)
                    lineView.backgroundColor = kSeptalLine_1_LevelColor
                    self.addSubview(lineView)
                  
                }
                if bottomSepLineView == nil {
                    bottomSepLineView = UIView()
                    bottomSepLineView.frame = CGRect.init(x:15 + ((kScreenWidth - 30)/CGFloat(lineBtnSum) - 28 )/2, y: CGFloat(buttonHeight) - 1.5, width: 28, height: 1.5)
                    bottomSepLineView.backgroundColor = UIColor.init(r: 34, g: 131, b: 223)
                    self.addSubview(bottomSepLineView)
                }
             
            }
        }
    }
    //点击事件
    @objc func touchBtnEvents(_ btn:UIButton) -> Void {
        
        delegate?.clickBtnIndex(btn.tag)
        
        self.calueYellowBottomSepearte(index: btn.tag)
        
    }
    
    
    func calueYellowBottomSepearte(index:Int) {
        
        let w: CGFloat = 28
        let h: CGFloat = 1.5
        let x: CGFloat = self.btnArray[index].centerX - w / 2
        let y: CGFloat = (CGFloat(index / lineBtnSum) + 1 ) * CGFloat(buttonHeight) - 1.5
        //判断是不是同一行的按钮
        if btnLineNum == (index / lineBtnSum) {
            UIView.animate(withDuration: 0.3) {
                self.bottomSepLineView.frame = CGRect(x: x, y: y, width: w, height: h)
            }
        }else {
            
            self.bottomSepLineView.frame = CGRect(x: x, y: y, width: w, height: h)
            
        }
        
        btnLineNum = index/lineBtnSum
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
}

extension ZHMenuBarMoreLineView:MenuBarOptionProtocol {

    
    
    func menuHeaderView() -> UIView {
        return UIView()
    }
    
    
    
    func menuViewitemOfLine() -> Int {
        
        return 3
    }
    
    func menuViewAllItemsNum() -> Int {
        
        return self.titles.count
    }
    
    func menuHeaderViewSize() -> CGSize {
        
        let str = String(format: "%.5f", self.menuViewAllItemsNum()/self.menuViewitemOfLine())
        
        return CGSize.init(width: kScreenWidth, height: CGFloat(ceil(Double(str)!) * Double(self.menuViewLineHeight())))
        
    }
    
 
    
    func menuViewLineHeight() -> Int {
        
        return 40
    }
    
}
